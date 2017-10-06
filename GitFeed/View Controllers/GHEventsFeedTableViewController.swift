//
//  GHEventsFeedTableViewController.swift
//  GitFeed
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Rswift
import NVActivityIndicatorView
import SafariServices
import RMessage
import Rswift

class GHEventsFeedTableViewController: UITableViewController, EventCellDelegate, NVActivityIndicatorViewable {
    
    let disposeBag = DisposeBag()
    
    var selectedUser: GHUser?
    
    var selectedEvent: GHEvent?
    
    var currentEvents = Variable<[GHEvent]>([])
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        
        //Remove extra separators
        self.tableView.tableFooterView = UIView()
        
        NVActivityIndicatorView.DEFAULT_TYPE = .pacman
        
        self.configureSearchController()
        self.setUpTableView()
        self.loadEventFeed()
    }
    
    override func viewDidLayoutSubviews() {
        
        //Disable or enable scrolling if the content is bigger than the tableview frame
        if (self.tableView.contentSize.height > self.tableView.frame.size.height) {
            self.tableView.isScrollEnabled = true;
        } else {
            self.tableView.isScrollEnabled = false;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureSearchController() {

        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "filter Events"
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.tableView.tableHeaderView = searchController.searchBar
        
        // Place the search bar view to the tableview headerview.
        self.tableView.tableHeaderView = self.searchController.searchBar
    }
    
    func loadEventFeed() {
        
        self.startAnimating()
        //Get the events
        GFNetworkManager.sharedInstance.getGithubEventFeed(completion: { eventFeed in
            guard let evFeed = eventFeed else { return }
            self.currentEvents.value = evFeed
            self.stopAnimating()
        })
    }
    
    func setUpTableView() {
   
        self.tableView.rx
            .modelSelected(GHEvent.self)
            .subscribe(onNext:  { value in
                
                self.selectedUser = value.actor
                self.selectedEvent = value
                
                if self.selectedEvent?.commitComment == nil {
                    RMessage.showNotification(withTitle: R.string.localizable.noInformationAvailable(), subtitle: "", type: .error, customTypeName: "", callback: nil)
                } else {
                    //Dismiss search view controller
                    self.searchController.dismiss(animated: false, completion: nil)
                    self.performSegue(withIdentifier: R.segue.ghEventsFeedTableViewController.eventDetailsSegue.identifier, sender: self)
                }
            })
            .disposed(by: self.disposeBag)
        
        // Set up event filtering
        
        let searchBar = self.searchController.searchBar
        
        let searchResults = searchBar.rx.text.orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[GHEvent]> in
                if query.isEmpty {
                    return self.currentEvents.asObservable()
                }
                var filteredArray = [GHEvent]()
                for ev in self.currentEvents.value {
                    if ev.repo.name.lowercased().range(of: query.lowercased()) != nil {
                        filteredArray.append(ev)
                    }
                }
                return  Observable.just(filteredArray)
                .catchErrorJustReturn([])
            }
            .observeOn(MainScheduler.instance)
        
        searchResults
            .bind(to: self.tableView.rx.items(cellIdentifier: R.reuseIdentifier.eventMainCellId.identifier, cellType: EventMainTableViewCell.self)) {
                (index, event: GHEvent, cell) in
                
                cell.delegate = self
                cell.user = event.actor
                
                cell.repoName.text = event.repo.name
                cell.ownerButton.setTitle("@"+event.actor.login, for: .normal)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                cell.repoCreation.text = dateFormatter.string(from: event.createdAt)
                
                //If there is a commit message we set the imageview bg as green
                //to notify the user that there is information available, as there are many types of event and we've only parsed a little number
                if event.commitComment != nil {
                     cell.detailsAvailable.backgroundColor = UIColor(red: 51/255, green: 124/255, blue: 43/255, alpha: 1.0) /* #337c2b */
                } else {
                    cell.detailsAvailable.backgroundColor = UIColor(red: 166/255, green: 59/255, blue: 58/255, alpha: 1.0) /* #a63b3a */
                }
            }
            .disposed(by: disposeBag)
    }
    
    @IBAction func refreshFeed(_ sender: Any) {
        self.loadEventFeed()
    }
    
    // MARK: - EventCellDelegate
    
    func showUserProfile(user: GHUser) {
        self.selectedUser = user
        self.performSegue(withIdentifier: R.segue.ghEventsFeedTableViewController.userProfileSegue.identifier, sender: self)
        
        //Dismiss search view controller
        self.searchController.dismiss(animated: false, completion: nil)
    }
    
    func openGitUserPage(url: URL) {
        //Open github user page
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true, completion: nil)
    }

    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == R.segue.ghEventsFeedTableViewController.userProfileSegue.identifier && self.selectedUser != nil {
            return true
        } else {
            return false
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == R.segue.ghEventsFeedTableViewController.userProfileSegue.identifier {
            guard let destVc = segue.destination as? UserProfileViewController else { return }
            guard let selUser = self.selectedUser else {
                print("Error showing user profile: Selected user was not set")
                return
            }
            destVc.user = selUser
        } else if segue.identifier == R.segue.ghEventsFeedTableViewController.eventDetailsSegue.identifier {
            guard let destVc = segue.destination as? EventDetailsTableViewController else { return }
            guard let selCommitComment = self.selectedEvent?.commitComment else {
                print("Error showing event info: Selected Event was not set")
                return
            }
            destVc.commitComment = selCommitComment
        }
    }
    

}

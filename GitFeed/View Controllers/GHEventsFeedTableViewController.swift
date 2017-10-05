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

class GHEventsFeedTableViewController: UITableViewController, EventCellDelegate, NVActivityIndicatorViewable {
    
    let disposeBag = DisposeBag()
    
    var selectedUser: GHUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        
        //Remove extra separators
        self.tableView.tableFooterView = UIView()
        
        NVActivityIndicatorView.DEFAULT_TYPE = .pacman
        self.startAnimating()
        
        //Get the events
        GFNetworkManager.sharedInstance.getGithubEventFeed(completion: { eventFeed in
            guard let evFeed = eventFeed else { return }
            
            let currentEvents = Observable.just(evFeed)
            
            currentEvents
                .bind(to: self.tableView.rx.items(cellIdentifier: R.reuseIdentifier.eventMainCellId.identifier, cellType: EventMainTableViewCell.self)) { (row, event, cell) in
                    cell.delegate = self
                    cell.user = event.actor
                    
                    cell.repoName.text = event.repo.name
                    cell.ownerButton.setTitle("@"+event.actor.login, for: .normal)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    cell.repoCreation.text = dateFormatter.string(from: event.createdAt)
                }
                .disposed(by: self.disposeBag)
            
            self.tableView.rx
                .modelSelected(GHEvent.self)
                .subscribe(onNext:  { value in
                    self.selectedUser = value.actor
                })
                .disposed(by: self.disposeBag)
            
            self.stopAnimating()
        })
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
    
    // MARK: - EventCellDelegate
    
    func showUserProfile(user: GHUser) {
        self.selectedUser = user
        self.performSegue(withIdentifier: R.segue.ghEventsFeedTableViewController.userProfileSegue.identifier, sender: self)
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
        }
    }
    

}

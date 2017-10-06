//
//  EventDetailsTableViewController.swift
//  GitFeed
//
//  Created by Daniel Bolivar herrera on 6/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import UIKit
import Rswift
import RxSwift

class EventDetailsTableViewController: UITableViewController {

    var commitComment: GHCommitComment = GHCommitComment()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        
        //Remove extra separators
        self.tableView.tableFooterView = UIView()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 220
        
        self.setUpTableView()
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

    func setUpTableView() {
        
        //In this particular scenario there is only one comment, but this is done so it would support more :P
        let comments = Observable.just([self.commitComment])
        
        comments
            .bind(to: self.tableView.rx.items(cellIdentifier: R.reuseIdentifier.commentCellId.identifier, cellType: CommitCommentTableViewCell.self)) { (row, commitComment, cell) in

                cell.userName.text = "@\(commitComment.user.login)"
                cell.comment.text = commitComment.comment
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                cell.date.text = dateFormatter.string(from: commitComment.createdAt)
                
                cell.avatarActivityIndicator.startAnimating()
                //Load avatar
                guard let imageUrl = URL(string: commitComment.user.avatarUrl) else { return }
                cell.userAvatar.sd_setImage(with: imageUrl, completed: { (image, error, cacheType, imageURL) in
                    cell.avatarActivityIndicator.stopAnimating()
                })
            }
            .disposed(by: disposeBag)
        
    }
}

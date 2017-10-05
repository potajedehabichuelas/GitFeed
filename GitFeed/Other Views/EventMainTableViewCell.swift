//
//  EventMainTableViewCell.swift
//  GitFeed
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import UIKit

protocol EventCellDelegate {
    func showUserProfile(user: GHUser)
}

class EventMainTableViewCell: UITableViewCell {

    @IBOutlet weak var ownerButton: UIButton!
    
    @IBOutlet weak var repoName: UILabel!
    
    @IBOutlet weak var repoCreation: UILabel!
    
    var user: GHUser?
    
    var delegate:EventCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.ownerButton.layer.borderColor = UIColor(red: 60/255, green: 93/255, blue: 103/255, alpha: 1.0).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func showUserProfile(_ sender: Any) {
        guard let usr = self.user else {
            print("Error showing user Profile: User was not set")
            return
        }
        self.delegate?.showUserProfile(user: usr)
    }
}

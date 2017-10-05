//
//  EventMainTableViewCell.swift
//  GitFeed
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import UIKit

protocol EventCellDelegate {
    func openGitUserPage(url: URL)
}

class EventMainTableViewCell: UITableViewCell {

    @IBOutlet weak var ownerButton: UIButton!
    
    @IBOutlet weak var repoName: UILabel!
    
    @IBOutlet weak var repoCreation: UILabel!
    
    var repoOwnerLogin: String = ""
    
    var delegate:EventCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func showOwner(_ sender: Any) {
        guard let url = URL(string: GithubUrl.htmlBase+self.repoOwnerLogin) else {
            print("Error opening repo in browswer: url could not be formed")
            return
        }
        self.delegate?.openGitUserPage(url: url)
    }
}

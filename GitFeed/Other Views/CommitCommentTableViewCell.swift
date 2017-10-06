//
//  CommitCommentTableViewCell.swift
//  GitFeed
//
//  Created by Daniel Bolivar herrera on 6/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CommitCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var comment: UITextView!
    
    @IBOutlet weak var avatarActivityIndicator: NVActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

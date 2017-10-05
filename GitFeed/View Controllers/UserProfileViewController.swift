//
//  UserProfileViewController.swift
//  GitFeed
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SDWebImage
import SafariServices

class UserProfileViewController: UIViewController {

    var user: GHUser = GHUser()
    
    @IBOutlet weak var profileAvatar: UIImageView!
    
    @IBOutlet weak var userLoginName: UILabel!
    
    @IBOutlet weak var gitProfileButton: UIButton!
    
    @IBOutlet weak var avatarActivityIndicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.avatarActivityIndicator.type = .ballZigZagDeflect
        
        self.userLoginName.text = "@\(self.user.login)"
        self.gitProfileButton.setTitle(self.user.url, for: .normal)
        
        //Load user profile image
        
        self.avatarActivityIndicator.startAnimating()
        
        guard let imageUrl = URL(string: user.avatarUrl) else { return }
        self.profileAvatar.layer.borderColor = UIColor(red: 60/255, green: 93/255, blue: 103/255, alpha: 1.0).cgColor
        self.profileAvatar.sd_setImage(with: imageUrl, completed: { (image, error, cacheType, imageURL) in
            self.avatarActivityIndicator.stopAnimating()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showUserProfileWeb(_ sender: Any) {
        
        guard let url = URL(string: GithubUrl.htmlBase+self.user.login) else {
            print("Error opening repo in browswer: url could not be formed")
            return
        }

        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

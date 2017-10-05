//
//  GHUser.swift
//  GitFeed
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import UIKit
import SwiftyJSON

struct GHUserKeys {
    
    static let id = "id"
    static let login = "login"
    static let url = "url"
    static let avatarUrl = "avatar_url"
}

class GHUser: NSObject {

    var id: Int64
    var login: String
    var avatarUrl: String
    var url: String
    
    override init() {
        
        self.id = -1
        self.login = ""
        self.url = ""
        self.avatarUrl = ""
    }
    
    convenience init(userDict: JSON) {
        
        self.init()
        
        if let uId = userDict[GHUserKeys.id].int64 {
            self.id = uId
        }
        
        if let uLogin = userDict[GHUserKeys.login].string {
            self.login = uLogin
        }
        
        if let uUrl = userDict[GHUserKeys.url].string {
            self.url = uUrl
        }
        
        if let uAvatarUrl = userDict[GHUserKeys.avatarUrl].string {
            self.avatarUrl = uAvatarUrl
        }
    }
}

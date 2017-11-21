//
//  GHRepo.swift
//  GitFeed
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import UIKit
import SwiftyJSON

struct GHERepoKeys {
    static let id = "id"
    static let url = "url"
    static let name = "name"
}

struct GHRepo {

    var id: Int64
    var name: String
    var url: String
    
    init() {
        
        self.id = -1
        self.name = ""
        self.url = ""
    }
    
    init(repoDict: JSON) {
        
        self.init()
        if let rId = repoDict[GHERepoKeys.id].int64 {
            self.id = rId
        }
        
        if let rName = repoDict[GHERepoKeys.name].string {
            self.name = rName
        }
        
        if let rUrl = repoDict[GHERepoKeys.url].string {
            self.url = rUrl
        }
    }
}


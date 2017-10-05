//
//  GHEvent.swift
//  GitFeed
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import UIKit
import SwiftyJSON

struct GHEventKeys {
    static let type = "type"
    static let payload = "payload"
    static let createdAt = "created_at"
    static let id = "id"
    static let actor = "actor"
    static let org = "org"
}

class GHEvent: NSObject {
    
    var type: String
    
    var repo: GHRepo
    
    var actor: GHUser
    
    var id: String
    
    var createdAt: Date
    
    var org: GHUser
    
    override init() {
        
        self.id = ""
        self.type = ""
        self.createdAt = Date()
        
        self.repo = GHRepo()
        self.actor = GHUser()
        self.org = GHUser()
    }
    
    convenience init(eventDict: JSON) {
        
        self.init()
        
        if let eType = eventDict[GHEventKeys.type].string {
            self.type = eType
        }
        
        if let eId = eventDict[GHEventKeys.id].string {
            self.id = eId
        }
        
        let isoFormatter = ISO8601DateFormatter()
        if let eCreatedString = eventDict[GHEventKeys.createdAt].string, let creationDate = isoFormatter.date(from: eCreatedString) {
            self.createdAt = creationDate
        }
        
        if eventDict[GHEventKeys.actor] != JSON.null {
            self.actor = GHUser(userDict: eventDict[GHEventKeys.actor])
        }
        
        if eventDict[GHEventKeys.org] != JSON.null  {
            self.org = GHUser(userDict: eventDict[GHEventKeys.org])
        }
        
        if let ePayload = eventDict[GHEventKeys.payload].dictionary {
            // Detect what kind of event this is ?
        }
    }
}

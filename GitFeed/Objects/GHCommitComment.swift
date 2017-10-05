//
//  GHCommitComment.swift
//  GitFeed
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import UIKit
import SwiftyJSON

struct GHCommitCommentKeys {
    static let user = "user"
    static let createdAt = "created_at"
    static let name = "name"
    static let commentBody = "body"
}

class GHCommitComment: NSObject {

    var user: GHUser
    var id: Int64
    var comment: String
    var createdAt: Date
    
    override init() {
        
        self.user = GHUser()
        self.id = -1
        self.comment = ""
        self.createdAt = Date()
    }
    
    convenience init(commitCommentDict: JSON) {
        
        self.init()
        
        if let cmId = commitCommentDict[GHUserKeys.id].int64 {
            self.id = cmId
        }
        
        if let cmComment = commitCommentDict[GHCommitCommentKeys.commentBody].string {
            self.comment = cmComment
        }

        if commitCommentDict[GHCommitCommentKeys.user] != JSON.null {
            self.user = GHUser(userDict: commitCommentDict[GHCommitCommentKeys.user])
        }
        
        let isoFormatter = ISO8601DateFormatter()
        if let eCreatedString = commitCommentDict[GHCommitCommentKeys.createdAt].string, let creationDate = isoFormatter.date(from: eCreatedString) {
            self.createdAt = creationDate
        }
    }
}

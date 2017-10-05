//
//  GFNetworkRouter.swift
//  GitFeed
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

struct GithubUrl {
    static let base = "https://git.io/"
    static let events = "vDdS9"
}

enum GFNetworRouter: URLRequestConvertible {
    
    // Values
    case getGithubFeed()
    
    // Methods
    var method: Alamofire.HTTPMethod {
        
        switch self {
            
            /*
             ** Get Github Events **
             * GET https://git.io/vDdS9
             */
        case .getGithubFeed:
            return .get
        }
    }
    
    // Paths
    var path: String {
        switch self {
            
        case .getGithubFeed():
            return GithubUrl.events
        }
    }
    
    // endpoint parameters
    var parameters: Parameters? {
        
        switch self {
        case .getGithubFeed():
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = URL(string: GithubUrl.base+self.path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        switch self {
            
        case .getGithubFeed():
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with:nil)
            
        }
    }
}

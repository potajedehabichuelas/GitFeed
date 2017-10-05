//
//  GFNetworkManager.swift
//  GitFeed
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class GFNetworkManager: NSObject {

    //Singleton
    static let sharedInstance = GFNetworkManager()
    
    func getGithubEventFeed(completion: @escaping ([String]?) -> Void) {
        
        Alamofire.request(GFNetworRouter.getGithubFeed()) .responseJSON { response in
            
            guard response.result.error == nil else {
                print("Error requesting GitHub Event")
                print(response.result.error!)
                completion(nil)
                return
            }
            
            if let response: AnyObject = response.result.value as AnyObject? {
                
                DispatchQueue.global(qos: .background).async {
                    let jsonFeed = JSON(response)
                    print(jsonFeed)
                   
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
                
            } else {
                print("Error parsing Event Feed Objects")
                completion(nil)
            }
        }
        
        debugPrint(request)
    }
}

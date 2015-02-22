//
//  APIManager.swift
//  WaterlooAnswers
//
//  Created by Hicham Abou Jaoude on 2015-02-21.
//  Copyright (c) 2015 Hicham Abou Jaoude. All rights reserved.
//

import UIKit
import Alamofire

class APIManager: NSObject {

    var sessionToken: String! = nil
    let urlPath = "http://askuw.sahiljain.ca/"

    // MARK: SharedInstance

    class var sharedManager: APIManager {
        struct Static {
            static let instance: APIManager = APIManager()
        }
        return Static.instance
    }

    // MARK: Login/SignUp

    func login(username: String, password: String, completion: () -> Void){
        Alamofire.request(.POST, urlPath + "/api/login", parameters: ["username": username,
            "password": password] )
            .response { (request, response, data, error) in
                println(request)
                println(response)
                println(error)
                if let dataObj = data as? NSDictionary {
                    if let token = dataObj.objectForKey("sessionToken") as? String {
                        self.sessionToken = token;
                    }
                }
                completion()
        }
    }

    func signup(username: String, password: String, name: String, completion: () -> Void){
        Alamofire.request(.POST, urlPath + "/api/signup", parameters: ["username": username,
            "password": password, "name": name] )
            .response { (request, response, data, error) in
                println(request)
                println(response)
                println(error)
                if let dataObj = data as? NSDictionary {
                    if let token = dataObj.objectForKey("sessionToken") as? String {
                        self.sessionToken = token;
                    }
                }
                completion()
        }
    }
    
}

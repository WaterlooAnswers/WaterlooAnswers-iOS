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

    // MARK: Login Flow

    func login(username: String, password: String, completion: (error: NSError!) -> Void) {
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
                completion(error: error)
        }
    }

    func signup(username: String, password: String, name: String, completion: (error: NSError!) -> Void) {
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
                completion(error: error)
        }
    }

    // MARK: Questions

    func getQuestion(id: String, completion: (question: Question?) -> Void) {
        Alamofire.request(.GET, urlPath + "/api/questions/" + id, parameters: nil)
            .response { (request, response, data, error) in
                println(request)
                println(response)
                println(error)
                if let dataObj = data as? NSDictionary {
                    var questionObj = Question(data: dataObj)
                    completion(question: questionObj)
                } else {
                    completion(question: nil)
                }
        }
    }

    func deleteQuestion(id: String, completion: (error: NSError!) -> Void) {
        Alamofire.request(.DELETE, urlPath + "/api/questions/", parameters: ["id": id, "token": sessionToken])
            .response { (request, response, data, error) in
                println(request)
                println(response)
                println(error)
                completion(error: error)
        }
    }

    func addQuestion(question: Question, completion: (error: NSError!) -> Void) {
        Alamofire.request(.POST, urlPath + "/api/questions/", parameters: ["questionTitle": question.name, "questionDescription": question.questionDescription, "categoryIndex": question.category, "token": sessionToken])
            .response { (request, response, data, error) in
                println(request)
                println(response)
                println(error)
                completion(error: error)
        }
    }

    
}

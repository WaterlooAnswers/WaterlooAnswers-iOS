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

    var sessionToken: String?
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
                if let dataObj = data as? Dictionary<String, AnyObject> {
                    if let token = dataObj["sessionToken"] as? String {
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
                if let dataObj = data as? Dictionary<String, AnyObject> {
                    if let token = dataObj["sessionToken"] as? String {
                        self.sessionToken = token;
                    }
                }
                completion(error: error)
        }
    }

    // MARK: User

    func getUser(completion: (person: Person) -> Void) {
        if let sessionToken = self.sessionToken {
            Alamofire.request(.GET, urlPath + "/api/user", parameters: ["token": sessionToken])
                .response { (request, response, data, error) in
                    println(request)
                    println(response)
                    println(error)
                    if let dataObj = data as? Dictionary<String, AnyObject> {
                        var person = Person(data: dataObj)
                    }
            }
        } else {
            println("Session Token is nil")
        }
    }

    // MARK: Questions

    func getQuestion(id: String, completion: (question: Question?) -> Void) {
        Alamofire.request(.GET, urlPath + "/api/questions/" + id, parameters: nil)
            .response { (request, response, data, error) in
                println(request)
                println(response)
                println(error)
                if let dataObj = data as? Dictionary<String, AnyObject> {
                    var questionObj = Question(data: dataObj)
                    completion(question: questionObj)
                } else {
                    completion(question: nil)
                }
        }
    }

    func deleteQuestion(id: String, completion: (error: NSError!) -> Void) {
        if let sessionToken = self.sessionToken {
            Alamofire.request(.DELETE, urlPath + "/api/questions/", parameters: ["id": id, "token": sessionToken])
                .response { (request, response, data, error) in
                    println(request)
                    println(response)
                    println(error)
                    completion(error: error)
            }
        } else {
            println("Session Token is nil")
        }
    }

    func addQuestion(question: Question, completion: (error: NSError!) -> Void) {
        if let sessionToken = self.sessionToken {
            if let name = question.name {
                if let questionDescription = question.questionDescription {
                    if let categoryId = question.categoryId {
                        Alamofire.request(.POST, urlPath + "/api/questions/", parameters: ["questionTitle": name, "questionDescription": questionDescription, "categoryIndex": categoryId, "token": sessionToken])
                            .response { (request, response, data, error) in
                                println(request)
                                println(response)
                                println(error)
                                completion(error: error)
                        }
                    }
                }
            }
        } else {
            println("Session Token is nil")
        }
    }

    func upvoteQuestion(question: Question, completion: (error: NSError!) -> Void) {
        if let sessionToken = self.sessionToken {
            if let questionId = question.questionId {
                Alamofire.request(.PUT, urlPath + "/api/questions/" + questionId + "/upvote", parameters:["token": sessionToken])
                    .response { (request, response, data, error) in
                        println(request)
                        println(response)
                        println(error)
                        completion(error: error)
                }
            }
        } else {
            println("Session Token is nil")
        }
    }

    func downvoteQuestion(question: Question, completion: (error: NSError!) -> Void) {
        if let sessionToken = self.sessionToken {
            if let questionId = question.questionId {
                Alamofire.request(.PUT, urlPath + "/api/questions/" + questionId + "/downvote", parameters:["token": sessionToken])
                    .response { (request, response, data, error) in
                        println(request)
                        println(response)
                        println(error)
                        completion(error: error)
                }
            }
        } else {
            println("Session Token is nil")
        }
    }

    func getQuestionByParameter(questionsPerPage: Int! = nil, pageNumber: Int! = nil, sortOrder: String! = nil, categoryId: Int! = nil, completion: (questions: [Question], error: NSError!) -> Void) {
        var parameters = Dictionary <String, AnyObject>()

        if let qpp = questionsPerPage {
            parameters["questionsPerPage"] = qpp
        }

        if let pn = pageNumber {
            parameters["pageNumber"] = pn
        }

        if let so = sortOrder {
            parameters["sortOrder"] = so
        }

        if let cid = categoryId {
            parameters["categoryId"] = cid
        }

        Alamofire.request(.GET, urlPath + "/api/questions", parameters: parameters)
            .response { (request, response, data, error) in
                println(request)
                println(response)
                println(error)
                var questionArray: [Question] = []
                if let dataArray = data as? [Dictionary<String, AnyObject>] {
                    for item in dataArray {
                        var question = Question(data: item)
                        questionArray.append(question!)
                    }
                }
                completion(questions: questionArray, error: error)
        }
    }

    // MARK: Answers

    func postAnswer(question: Question, answer: AnyObject, completion: (error: NSError!) -> Void) {
        if let sessionToken = self.sessionToken {
            if let questionId = question.questionId {
                Alamofire.request(.POST, urlPath + "/api/answers", parameters: ["questionId": questionId, "answerBody": answer, "token": sessionToken])
                    .response { (request, response, data, error) in
                        println(request)
                        println(response)
                        println(error)
                        var questionArray: [Question] = []
                        if let dataArray = data as? [Dictionary<String, AnyObject>] {
                            for item in dataArray {
                                var question = Question(data: item)
                                questionArray.append(question!)
                            }
                        }
                        completion(error: error)
                }
            }
        } else {
            println("Session Token is nil")
        }
    }

    // MARK: Categories

    func getCategories(completion: (categories: [Dictionary<String, AnyObject>]!, error: NSError!) -> Void) {
        Alamofire.request(.GET, urlPath + "/api/categories", parameters: nil)
            .response { (request, response, data, error) in
                println(request)
                println(response)
                println(error)
                if let dataArray = data as? [Dictionary<String, AnyObject>] {
                    completion(categories: dataArray, error: error)
                }
        }
    }

}

//
//  Person.swift
//  WaterlooAnswers
//
//  Created by Hicham Abou Jaoude on 2015-02-21.
//  Copyright (c) 2015 Hicham Abou Jaoude. All rights reserved.
//

import UIKit

class Person: NSObject {

    var userId: String?
    var firstName: String?
    var email: String?
    var dateJoined: NSDate?
    var questionsAsked: [Question] = []
    var answersGiven: [Answer] = []

    init(data: Dictionary<String, AnyObject>) {
        super.init()

        if let userId = data["userId"] as? String {
            self.userId = userId
        }

        if let firstName = data["firstName"] as? String {
            self.firstName = firstName
        }

        if let email = data["email"] as? String {
            self.email = email
        }

        if let date = data["dateJoined"] as? String {
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yy-mm-dd"
            self.dateJoined = dateFormatter.dateFromString(date)
        }

        if let questions = data["questionsAsked"] as? [Dictionary<String, AnyObject>] {
            for questionData in questions {
                if let question = Question(data: questionData) {
                    self.questionsAsked.append(question)
                }
            }
        }

        if let answers = data["answersGiven"] as? [Dictionary<String, AnyObject>] {
            for answerData in answers {
                if let answer = Answer(data: answerData) {
                    self.answersGiven.append(answer)
                }
            }
        }
    }

}

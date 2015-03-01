//
//  Answer.swift
//  WaterlooAnswers
//
//  Created by Hicham Abou Jaoude on 2015-02-28.
//  Copyright (c) 2015 Hicham Abou Jaoude. All rights reserved.
//

import UIKit

class Answer: NSObject {

    var questionId: String! = nil
    var answerId: String! = nil
    var answererId: String! = nil
    var answererName: String! = nil
    var answerText: String! = nil
    var answerDate: NSDate! = nil

    init?(data: NSDictionary) {
        super.init()

        if let questionId = data["questionId"] as? String {
            self.questionId = questionId
        }

        if let answerId = data["answerId"] as? String {
            self.answerId = answerId
        }

        if let answererId = data["answererId"] as? String {
            self.answererId = answererId
        }

        if let answererName = data["answererName"] as? String {
            self.answererName = answererName
        }

        if let answerText = data["answerText"] as? String {
            self.answerText = answerText
        }

        if let date = data["timeAnswered"] as? String {
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yy-mm-dd"
            self.answerDate = dateFormatter.dateFromString(date)
        }

    }

}
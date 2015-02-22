//
//  Question.swift
//  WaterlooAnswers
//
//  Created by Hicham Abou Jaoude on 2015-02-22.
//  Copyright (c) 2015 Hicham Abou Jaoude. All rights reserved.
//

import UIKit

class Question: NSObject {

    var questionId: String! = nil
    var name: String! = nil
    var questionDescription: String! = nil
    var askerId: String! = nil
    var askerEmail: String! = nil
    var category: Int! = 0 // TODO: Update to Category Enum
    var numAnswers: Int! = 0
    //var answers: [Answers]! = []
    //var favourites: [AnyObject]! = []
    var timeAsked: NSDate! = nil

    init?(data: NSDictionary) {
        super.init()
    }
}
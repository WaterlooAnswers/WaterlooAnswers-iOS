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
    var categoryId: Int! = nil // TODO: Update to Category Enum
    var categoryName: String! = nil
    var numAnswers: Int! = 0
    var answers: [Answer]! = []
    var favourites: [Person]! = []
    var timeAsked: NSDate! = nil

    init?(data: NSDictionary) {
        super.init()
    }

}

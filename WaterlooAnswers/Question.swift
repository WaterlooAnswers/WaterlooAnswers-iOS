//
//  Question.swift
//  WaterlooAnswers
//
//  Created by Hicham Abou Jaoude on 2015-02-22.
//  Copyright (c) 2015 Hicham Abou Jaoude. All rights reserved.
//

import UIKit

class Question: NSObject {

    var questionId: String? 
    var name: String? 
    var questionDescription: String? 
    var askerId: String? 
    var askerEmail: String? 
    var categoryId: Int?  // TODO: Update to Category Enum
    var categoryName: String? 
    var numAnswers: Int? = 0
    var answers: [Answer] = []
    var favourites: [Person] = []
    var timeAsked: NSDate? 

    init?(data: NSDictionary) {
        super.init()
    }

}

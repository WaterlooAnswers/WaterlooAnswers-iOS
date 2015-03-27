//
//  AccountManager.swift
//  WaterlooAnswers
//
//  Created by Hicham Abou Jaoude on 2015-03-22.
//  Copyright (c) 2015 Hicham Abou Jaoude. All rights reserved.
//

import UIKit

class AccountManager: NSObject {

    var me: Person?

    class var sharedManager: AccountManager {
        struct Static {
            static let instance: AccountManager = AccountManager()
        }
        return Static.instance
    }

}

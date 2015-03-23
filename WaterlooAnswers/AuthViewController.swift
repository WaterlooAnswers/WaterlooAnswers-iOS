//
//  AuthViewController.swift
//  WaterlooAnswers
//
//  Created by Hicham Abou Jaoude on 2015-03-22.
//  Copyright (c) 2015 Hicham Abou Jaoude. All rights reserved.
//

import UIKit

enum AuthRowType {
    case Email, Name, Password
}

enum AuthType {
    case SignIn, SignUp
}

class AuthViewController: UITableViewController {

    var rowTypeArray: [AuthRowType] = [.Email, .Password]
    var email: String?
    var name: String?
    var password: String?
    var authType: AuthType!

    init(type: AuthType) {
        super.init()
        authType = type
        if authType == .SignUp {
            rowTypeArray = [.Email, .Name, .Password]
        }
    }

    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if authType == .SignUp {
            self.title = NSLocalizedString("Sign Up", comment: "")
        } else {
            self.title = NSLocalizedString("Sign In", comment: "")

        }

        var footer = UIButton(frame: CGRectMake(0, 0, self.view.frame.width, 35))
        footer.backgroundColor = .greenColor()
        footer.setTitle(NSLocalizedString("Let Me In", comment: ""), forState: .Normal)

        tableView.tableFooterView = footer
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowTypeArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        return cell
    }


}

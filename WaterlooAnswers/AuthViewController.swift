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

class AuthViewController: UITableViewController, UITextFieldDelegate {

    var rowTypeArray: [AuthRowType] = [.Email, .Password]
    var email: String?
    var name: String?
    var password: String?
    var authType: AuthType
    let identifier = "textCell"

    init(type: AuthType) {
        authType = type
        super.init(nibName: nil, bundle: nil)

        if authType == .SignUp {
            rowTypeArray = [.Email, .Name, .Password]
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(TextFieldCell.self, forCellReuseIdentifier: identifier)

        if authType == .SignUp {
            self.title = NSLocalizedString("Sign Up", comment: "")
        } else {
            self.title = NSLocalizedString("Sign In", comment: "")

        }

        var footer = UIButton(frame: CGRectMake(0, 0, self.view.frame.width, 35))
        footer.backgroundColor = .greenColor()
        footer.setTitle(NSLocalizedString("Let Me In", comment: ""), forState: .Normal)
        footer.addTarget(self, action: "didTapButton", forControlEvents: .TouchUpInside)

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
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as TextFieldCell
        cell.textField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        cell.textField.tag = indexPath.row
        var rowType = rowTypeArray[indexPath.row]
        switch rowType {
        case .Email:
            cell.textField.placeholder = NSLocalizedString("Email Address",  comment: "")
        case .Name:
            cell.textField.placeholder = NSLocalizedString("First Name",  comment: "")
        case .Password:
            cell.textField.placeholder = NSLocalizedString("Password",  comment: "")
        default:
            break;
        }
        return cell
    }

    func textFieldDidChange(textField: UITextField) {
        var rowType = rowTypeArray[textField.tag]
        switch rowType {
        case .Email:
            email = textField.text
        case .Name:
            name = textField.text
        case .Password:
            password = textField.text
        default:
            break;
        }
    }

    func didTapButton() {
        if authType == .SignUp {
            if let email = email {
                if let password = password {
                    if let name = name {
                        APIManager.sharedManager.signup(email, password: password, name: name, completion: { (error) -> Void in
                            if let err = error {
                                println(error)
                            }
                        })
                    }
                }
            }
        } else {
            if let email = email {
                if let password = password {
                    APIManager.sharedManager.login(email, password: password, completion: { (error) -> Void in
                        if let err = error {
                            println(error)
                        }
                    })
                }
            }
        }
    }


}

//
//  TableViewCells.swift
//  WaterlooAnswers
//
//  Created by Hicham Abou Jaoude on 2015-03-26.
//  Copyright (c) 2015 Hicham Abou Jaoude. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {

    var textField: UITextField

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        textField = UITextField()
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textField.font = Theme.regularFont(12.0)
        textField.textColor = Theme.textColor()

        contentView.addSubview(textField)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textField.frame = CGRectMake(15, 0, frame.width - 30, frame.height)
    }

}

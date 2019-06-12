//
//  UITextField+Extension.swift
//  SkyFind
//
//  Created by Angie Mugo on 10/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import UIKit

extension UITextField {
    func setupDefaultTextfieldConfig() {
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.light_yellow_fg.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.2)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 0.3
        self.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        self.textColor = UIColor.white
        self.addLeftRightPadding(ofSize: 16)
    }

    func addLeftRightPadding(ofSize size: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

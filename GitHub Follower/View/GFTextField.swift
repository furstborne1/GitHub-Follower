//
//  GFTextField.swift
//  GitHub Follower
//
//  Created by MARC on 4/16/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius           = 7
        layer.borderWidth            = 2
        layer.borderColor            = UIColor.systemGray4.cgColor
        
        textColor                    = .label
        textAlignment                = .center
        tintColor                    = .label
        font                         = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth    = true
        minimumFontSize              = 12
        returnKeyType                = .go
        
        backgroundColor              = .tertiarySystemBackground
        autocorrectionType           = .no
        placeholder                  = "Enter Username"
        
        clearButtonMode              = .whileEditing
    }
}

//
//  TablewView+ext.swift
//  GitHub Follower
//
//  Created by MARC on 5/4/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

extension UITableView {
    func removeExtraCell() {
        tableFooterView = UIView(frame: .zero)
    }
}

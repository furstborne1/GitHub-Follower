//
//  Date+Ext.swift
//  GitHub Follower
//
//  Created by MARC on 4/29/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import Foundation

extension Date {
    func fromDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}

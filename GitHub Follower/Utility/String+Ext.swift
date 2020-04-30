//
//  String+Ext.swift
//  GitHub Follower
//
//  Created by MARC on 4/29/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import Foundation

extension String {
    func  convertStringtToDate() -> Date? {
        let dateFormatter            = DateFormatter()
        dateFormatter.dateFormat     = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale         = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone       = .current
        return dateFormatter.date(from: self)
    }
    
    func displayDate() -> String {
        guard let date = convertStringtToDate() else { return "N/A" }
        return date.fromDateToString()
    }
}

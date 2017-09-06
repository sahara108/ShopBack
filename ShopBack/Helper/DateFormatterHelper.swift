//
//  DateFormatterHelper.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/6/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import UIKit

struct DateFormatterHelper {
    private static let theMovieDBDateFormatter = DateFormatter()
    static func defaultFormatter() -> DateFormatter {
        theMovieDBDateFormatter.dateFormat = "yyyy-MM-dd"
        return theMovieDBDateFormatter
    }
}

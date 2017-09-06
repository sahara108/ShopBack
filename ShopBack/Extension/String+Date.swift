//
//  String+Date.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/6/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import UIKit

extension String {
    func toDate() -> Date? {
        return DateFormatterHelper.defaultFormatter().date(from: self)
    }
}

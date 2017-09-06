//
//  NetworkRequestKeys.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/6/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import UIKit

enum SubKeys: String {
    case lte
    case desc
    case asc
}

enum NetworRequestKeys {
    case api_key
    case primary_release_date(SubKeys)
    case sort_by
    case page
    
    var string : String {
        get {
            switch self {
            case .api_key:
                return "api_key"
            case .primary_release_date(let value):
                let sub = value.rawValue
                return "primary_release_date.\(sub)"
            case .sort_by:
                return "sort_by"
            case .page:
                return "page"
            default:
                return ""
            }
        }
    }
}

enum NetworkRequestValues {
    case release_date(SubKeys)
    
    var string: String {
        get {
            switch self {
            case .release_date(let value):
                let sub = value.rawValue
                return "release_date.\(sub)"
            default:
                return ""
            }
        }
    }
}

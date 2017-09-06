//
//  CompanyModel.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/6/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import UIKit
import SwiftyJSON

class CompanyModel: NSObject {
    let id: Int
    let name: String
    
    init?(json: JSON) {
        guard let idValue = json["id"].int,
            let nameValue = json["name"].string
            else { return nil }
        
        id = idValue
        name = nameValue
        super.init()
    }
}

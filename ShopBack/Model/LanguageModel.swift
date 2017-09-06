//
//  LanguageModel.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/6/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import UIKit
import SwiftyJSON

class LanguageModel: NSObject {
    let iso: String
    let name: String
    
    init?(json: JSON) {
        guard let idValue = json["iso_639_1"].string,
            let nameValue = json["name"].string
            else { return nil }
        
        iso = idValue
        name = nameValue
        super.init()
    }
}

//
//  Helper.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/7/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import UIKit

class Helper: NSObject {
    static func sizeForText(_ text: String, font: UIFont, maxWidth: CGFloat) -> CGSize {
        if maxWidth < 0 || text == "" {
            return CGSize(width: 0, height: 0)
        }
        
        let nstest = text as NSString
        let textsize = nstest.boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin) , attributes:[NSFontAttributeName: font], context: nil)
        
        //round up
        let doubleWdith = ceil(textsize.size.width * 2)
        let doubleHeight = ceil(textsize.size.height * 2)
        let result = CGSize(width: doubleWdith * 0.5, height: doubleHeight * 0.5)
        
        return result
    }
}

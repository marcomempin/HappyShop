//
//  Category.swift
//  Happy Shop
//
//  Created by Marco Mempin on 9/4/17.
//  Copyright © 2017 marcowesome. All rights reserved.
//

import IGListKit
import SwiftyJSON


final class Category: NSObject, JSONAbleType {
    let name: String
    let productCount: Int
    
    init(name: String, productCount: Int) {
        self.name = name
        self.productCount = productCount
    }
    
    static func fromJSON(_ source: [String : Any]) -> Category {
        let json = JSON(source)
        
        var name = json["name"].stringValue
        let productCount = json["products_count"].intValue
        
        // Convert "Bath & Body" to "Bath%20%26%20Body"
        if name.contains("Bath") {
            name = "Bath%20%26%20Body"
        }
        
        return Category(name: name, productCount: productCount)
    }
    
    override var description: String {
        return "Name: \(self.name) - Product Count: \(self.productCount)"
    }

}

//
//  Product.swift
//  Happy Shop
//
//  Created by Marco Mempin on 9/4/17.
//  Copyright © 2017 marcowesome. All rights reserved.
//

import IGListKit
import SwiftyJSON

final class Product: NSObject, JSONAbleType {
    let id: String
    let name: String
    let category: String
    let price: String
    let imageURL: String
    let descriptions: String
    let isOnSale: Bool

    init(id: String, name: String, category: String, price: String, imageURL: String, descriptions: String, onSale: Bool) {
        self.id = id
        self.name = name
        self.category = category
        self.price = price
        self.imageURL = imageURL
        self.descriptions = descriptions
        self.isOnSale = onSale
    }
    
    static func fromJSON(_ source: [String : Any]) -> Product {
        let json = JSON(source)
        
        let id = json["id"].stringValue
        let name = json["name"].stringValue
        let category = json["category"].stringValue
        let price = json["price"].stringValue
        let imageURL = json["img_url"].stringValue
        let descriptions = json["description"].stringValue
        let isOnSale = json["under_sale"].boolValue
        
        return Product(id: id, name: name, category: category, price: price, imageURL: imageURL, descriptions: descriptions, onSale: isOnSale)
    }
    
    override var description: String {
        return "\(self.name)"
    }
}

extension Product: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self.id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
}

//
//  ProductLoader.swift
//  Happy Shop
//
//  Created by Marco Mempin on 9/4/17.
//  Copyright © 2017 marcowesome. All rights reserved.
//

import Foundation
import Moya

class ProductLoader {
    
    var products: [Product] = []
    let provider = MoyaProvider<SephoraAPI>()
    
    func getProducts(for category: String, page: Int = 1, completion: @escaping () -> Void) {
        provider.request(.products(category: category, page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let productJSONDictionary = try response.mapJSON() as! [String : Any]
                    
                    let productJSONArray = productJSONDictionary["products"] as! [[String : Any]]
                    
                    for productJSON in productJSONArray {
                        let product = Product.fromJSON(productJSON)
                        self.products.append(product)
                    }
                    
                    completion()
                    
                } catch {
                    
                }
            
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    print("Cannot convert error to String")
                    break
                }
                print(error.description)
                
            }
            
        }
    }
    
}

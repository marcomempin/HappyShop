//
//  CategoryLoader.swift
//  Happy Shop
//
//  Created by Marco Mempin on 9/4/17.
//  Copyright © 2017 marcowesome. All rights reserved.
//

import Foundation
import Moya

class CategoryLoader {
    
    var categories: [Category] = []
    
    func getCategories(completion: @escaping () -> Void) {
        let provider = MoyaProvider<SephoraAPI>()
        provider.request(.categories) { result in
            switch result {
            case let .success(response):
                do {
                    let categoryJSONDictionary = try response.mapJSON() as! [String : Any]
                    
                    let categoryJSONArray = categoryJSONDictionary["categories"] as! [[String : Any]]
                    
                    for categoryJSON in categoryJSONArray {
                        let category = Category.fromJSON(categoryJSON)
                        self.categories.append(category)
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

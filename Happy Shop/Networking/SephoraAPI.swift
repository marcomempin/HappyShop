//
//  SephoraAPI.swift
//  Happy Shop
//
//  Created by Marco Mempin on 9/4/17.
//  Copyright © 2017 marcowesome. All rights reserved.
//

import Foundation
import Moya

enum SephoraAPI {
    case categories
    case products(category: String, page: Int)
    case product(id: String)
}

extension SephoraAPI: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        return URL(string: "http://sephora-mobile-takehome-2.herokuapp.com/api/v1/")!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .categories:
            return "categories"
            
        case .products,
             .product:
            return "products"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .get
    }
    
    /// The parameters to be encoded in the request.
    var parameters: [String: Any]? {
        switch self {
        case .categories:
            return nil
            
        case .products(let category, let page):
            return ["category" : category, "page" : page]
            
        case .product(let id):
            return ["id" : id]
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        switch self {
        // http://sephora-mobile-takehome-2.herokuapp.com/api/v1/categories
        case .categories:
            return "{\"categories\":[{\"name\":\"Bath \\u0026 Body\",\"products_count\":56},{\"name\":\"Makeup\",\"products_count\":48},{\"name\":\"Skincare\",\"products_count\":58},{\"name\":\"Nails\",\"products_count\":18},{\"name\":\"Tools\",\"products_count\":20},{\"name\":\"Men\",\"products_count\":2}]}".data(using: .utf8)!
            
        // http://sephora-mobile-takehome-2.herokuapp.com/api/v1/products?category=Men
        case .products:
            return "{\"products\":[{\"id\":25,\"name\":\"Precision Shave Gel 150ml\",\"category\":\"Men\",\"price\":2800.0,\"img_url\":\"http://luxola-assets-staging-hades.s3.amazonaws.com/images/pictures/5572/default_404c7e757a530e41b880857c3e8378419517b1c4_1406796515_AC_PercisionShavegel.jpg\",\"under_sale\":false},{\"id\":126,\"name\":\"Precision Shave Gel 150ml\",\"category\":\"Men\",\"price\":2800.0,\"img_url\":\"http://luxola-assets-staging-hades.s3.amazonaws.com/images/pictures/5572/default_404c7e757a530e41b880857c3e8378419517b1c4_1406796515_AC_PercisionShavegel.jpg\",\"under_sale\":false}]}".data(using: .utf8)!
        
        // http://sephora-mobile-takehome-2.herokuapp.com/api/v1/products/18
        case .product:
            return "{\"product\":{\"id\":18,\"name\":\"Big It Up! Firm Mousse 200ml\",\"category\":\"Bath \\u0026 Body\",\"price\":2200.0,\"img_url\":\"http://luxola-assets-staging-hades.s3.amazonaws.com/images/pictures/10919/default_b974b3cf773a7d610adc27a28a3a032b7bb3f75d_1432197755_BigItUp__Mousse_200ml.jpg\",\"description\":\"Lorem ipsum dolor sit amet Big It Up! Firm Mousse 200ml product description consectetur adipiscing elit, sed do eiusmod tempor incididunt.\",\"under_sale\":true}}".data(using: .utf8)!
        }
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }
}

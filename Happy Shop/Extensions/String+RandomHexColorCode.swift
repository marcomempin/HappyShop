//
//  String+RandomHexColorCode.swift
//  Happy Shop
//
//  Created by Marco Mempin on 9/5/17.
//  Copyright © 2017 marcowesome. All rights reserved.
//

import Foundation

extension String {
    // http://www.amarendrasingh.in/swift/swift-3-uicolor-utilities-random-hex-color-codes-random-uicolor/
    static func randomHexColorCode() -> String {
        let a = ["1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"];
        return a[Int(arc4random_uniform(15))]
            .appending(a[Int(arc4random_uniform(15))])
            .appending(a[Int(arc4random_uniform(15))])
            .appending(a[Int(arc4random_uniform(15))])
            .appending(a[Int(arc4random_uniform(15))])
            .appending(a[Int(arc4random_uniform(15))])
    }
}

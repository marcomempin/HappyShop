//
//  UIImageView+ImageFromServerURL.swift
//  Happy Shop
//
//  Created by Marco Mempin on 9/5/17.
//  Copyright © 2017 marcowesome. All rights reserved.
//

import Foundation
import UIKit

// http://stackoverflow.com/a/37019507/737370
extension UIImageView {
    public func imageFromServerURL(urlString: String, completion: @escaping () -> Void) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error!)
                completion()
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
                completion()
            })
            
        }).resume()
    }
}

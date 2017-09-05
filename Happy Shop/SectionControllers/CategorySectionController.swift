//
//  CategorySectionController.swift
//  Happy Shop
//
//  Created by Marco Mempin on 9/4/17.
//  Copyright © 2017 marcowesome. All rights reserved.
//

import UIKit
import IGListKit

class CategorySectionController: ListSectionController {
    
    var category: Category!
    
    override init() {
        super.init()
    }
    
    override func numberOfItems() -> Int {
        return self.category.products.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext!.containerSize.width
        let itemSize = floor(width / 2)
        let heightRatio: CGFloat = 1.7
        return CGSize(width: itemSize, height: itemSize * heightRatio)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(withNibName: "ProductCell", bundle: nil, for: self, at: index) as! ProductCell
        
        let products = self.category.products
        let product = products[index]
        cell.imageView.imageFromServerURL(urlString: product.imageURL) {
            if cell.imageView.image == nil {
                // https://placeholder.com/
                cell.imageView.imageFromServerURL(urlString: "http://via.placeholder.com/1000x1000/\(self.randomHexColorCode())/\(self.randomHexColorCode())") {
                    cell.loadingIndicator.stopAnimating()
                }
            } else {
                cell.loadingIndicator.stopAnimating()
            }
        }
        cell.nameLabel.text = product.name
        cell.priceLabel.text = String(format: "S$%.02f", product.price)
        cell.onSaleLabel.isHidden = !product.isOnSale
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.category = object as! Category
    }
    
    override func didSelectItem(at index: Int) {
        let product = self.category.products[index]
        print("\(product.id) - \(product.name)")
        
        let productViewController = ProductViewController()
        productViewController.product = product
        self.viewController?.navigationController?.pushViewController(productViewController, animated: true)
    }
    
    // http://www.amarendrasingh.in/swift/swift-3-uicolor-utilities-random-hex-color-codes-random-uicolor/
    func randomHexColorCode() -> String {
        let a = ["1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"];
        return a[Int(arc4random_uniform(15))]
            .appending(a[Int(arc4random_uniform(15))])
            .appending(a[Int(arc4random_uniform(15))])
            .appending(a[Int(arc4random_uniform(15))])
            .appending(a[Int(arc4random_uniform(15))])
            .appending(a[Int(arc4random_uniform(15))])
    }
}

// MARK: UIImageView Extension
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

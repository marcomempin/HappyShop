//
//  ProductSectionController.swift
//  Happy Shop
//
//  Created by Marco Mempin on 9/5/17.
//  Copyright © 2017 marcowesome. All rights reserved.
//

import UIKit
import IGListKit

class ProductSectionController: ListSectionController {
    
    var product: Product!
    
    override func numberOfItems() -> Int {
        return 3
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext!.containerSize.width
        switch index {
            
        case 0:
            let height = ProductCell.textHeight(product.name, width: width)
            return CGSize(width: width, height: width + height)
            
        case 1:
            return CGSize(width: width, height: 55)
            
        case 2:
            return CGSize(width: width, height: ProductCell.textHeight(product.descriptions, width: width))
            
        default:
            return .zero
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
            
        case 0:
            let cell = collectionContext!.dequeueReusableCell(withNibName: "ProductCell", bundle: nil, for: self, at: index) as! ProductCell
            cell.imageView.imageFromServerURL(urlString: product.imageURL) {
                if cell.imageView.image == nil {
                    // https://placeholder.com/
                    cell.imageView.imageFromServerURL(urlString: "http://via.placeholder.com/1000x1000/\(String.randomHexColorCode())/\(String.randomHexColorCode())") {
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
            
        case 1:
            let cell = collectionContext!.dequeueReusableCell(withNibName: "ButtonCell", bundle: nil, for: self, at: index) as! ButtonCell
            cell.addToCartButton.addTarget(self, action: #selector(self.addToCart), for: .touchUpInside)
            return cell
            
        case 2:
            let cell = collectionContext!.dequeueReusableCell(withNibName: "DescriptionCell", bundle: nil, for: self, at: index) as! DescriptionCell
            cell.textLabel.text = product.descriptions
            return cell
         
        default:
            return UICollectionViewCell()
        }
    }
    
    override func didUpdate(to object: Any) {
        self.product = object as! Product
    }
    
    override func didSelectItem(at index: Int) {
//        print(String(index))
    }
    
    func addToCart() {
        print("Product \(self.product.name) was added to the cart.")
    }

}

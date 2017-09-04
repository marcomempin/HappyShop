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
        cell.nameLabel.text = product.name
        cell.priceLabel.text = String(format: "S$%.02f", product.price)
        cell.onSaleLabel.isHidden = !product.isOnSale
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.category = object as! Category
    }
    
    override func didSelectItem(at index: Int) {
        
    }
}

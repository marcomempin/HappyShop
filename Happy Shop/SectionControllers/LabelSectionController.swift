//
//  LabelSectionController.swift
//  Happy Shop
//
//  Created by Marco Mempin on 9/4/17.
//  Copyright © 2017 marcowesome. All rights reserved.
//

import UIKit
import IGListKit

class LabelSectionController: ListSectionController {
    
    var object: Category!
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 55)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(withNibName: "LabelCell", bundle: nil, for: self, at: index) as! LabelCell
        cell.textLabel.text = object.name
        cell.countLabel.text = String(object.productCount)
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as! Category
    }
    
    override func didSelectItem(at index: Int) {
        print("\(self.object.name)")
    }
}

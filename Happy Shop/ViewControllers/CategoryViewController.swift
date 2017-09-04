//
//  CategoryViewController.swift
//  Happy Shop
//
//  Created by Marco Mempin on 9/4/17.
//  Copyright © 2017 marcowesome. All rights reserved.
//

import UIKit
import IGListKit

class CategoryViewController: UIViewController {
    
    // MARK: Data
    let productLoader = ProductLoader()
    var category: Category!
    
    // MARK: IGListKit
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    // MARK: UI
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = .white
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.category.name
        
        self.productLoader.getProducts(for: self.category.name) {
            self.category.products = self.productLoader.products
            self.adapter.reloadData()
        }
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension CategoryViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        let objects = [self.category] as [ListDiffable]
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return CategorySectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

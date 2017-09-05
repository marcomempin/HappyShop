//
//  HomeViewController.swift
//  Happy Shop
//
//  Created by Marco Mempin on 9/4/17.
//  Copyright © 2017 marcowesome. All rights reserved.
//

import UIKit
import IGListKit

class HomeViewController: UIViewController {
    
    // MARK: Data
    let categoryLoader = CategoryLoader()
    var categories = [Category]()
    
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

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        
        self.categoryLoader.getCategories { 
            self.categories = self.categoryLoader.categories
            self.adapter.performUpdates(animated: true)
        }
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let userDefaults = UserDefaults.standard
        let productArray = userDefaults.array(forKey: "cart")!
        
        if productArray.count > 1 {
            let cartBarButton = self.navigationItem.rightBarButtonItem
            cartBarButton?.title = "Cart: \(productArray.count)"
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension HomeViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return categories
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return LabelSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

//
//  JCPageContentView.swift
//  Hi,TV!
//
//  Created by admin on 16/9/17.
//  Copyright © 2016年 静持大师. All rights reserved.
//

import UIKit

class JCPageContentView: UIView {
    
    //
    private let kCellID: String = "__kCellID__"
    // 自控制器
    private let childVCs: [UIViewController]
    // 父控制器
    private weak var fatherVC: UIViewController?
    // collectionView
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        let collectionView  = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: self.kCellID)
        
        return collectionView
    }()
    
    // 自定义构造函数
    init(frame: CGRect, childVCs: [UIViewController], fatherVC: UIViewController) {
       self.childVCs = childVCs
        self.fatherVC = fatherVC
         
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JCPageContentView {
    private func setupUI() {
        // 添加子控制器
        for childVC in childVCs {
            fatherVC?.addChildViewController(childVC)
        }
        
        //
        collectionView.frame = bounds
        addSubview(collectionView)
    }
}

extension JCPageContentView: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellID, forIndexPath: indexPath)
 
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC: UIViewController = childVCs[indexPath.item]
        childVC.view.frame = cell.bounds
        childVC.view.backgroundColor = JC_RANDOM_COLOR()
        cell.contentView.addSubview(childVC.view)

        return cell;
    }
}

extension JCPageContentView: UICollectionViewDelegate {
    
}

// MARK:- 对外暴露的方法
extension JCPageContentView {
    func setCurrentIndex(index: Int) {
        collectionView.setContentOffset(CGPoint(x: CGFloat(index) * JC_SCREEN_WIDTH, y: 0), animated: false)
    }
}
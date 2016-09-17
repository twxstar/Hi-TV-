//
//  JCPageContentView.swift
//  Hi,TV!
//
//  Created by admin on 16/9/17.
//  Copyright © 2016年 静持大师. All rights reserved.
//

import UIKit

protocol JCPageContentViewDelegate : class {
    func pageContentView(contentView : JCPageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

class JCPageContentView: UIView {
    
    //
    private let kCellID: String = "__kCellID__"
    // 代理
    weak var delegate: JCPageContentViewDelegate?
    private var isForbidScrollDelegate : Bool = false
    // 开始拖拽时的OffsetX
    private var startOffsetX : CGFloat = 0
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

// MARK: - UICollectionViewDataSource
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

// MARK: - UICollectionViewDelegate
extension JCPageContentView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate {
            return
        }
        
        // 1.定义获取需要的数据
        var progress : CGFloat = 0 // 滑动的占比
        var sourceIndex : Int = 0 // 当前的index
        var targetIndex : Int = 0 // 目标index
        
        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX { // 左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count { // 防止越界
                targetIndex = childVCs.count - 1
            }
            
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }
        else { // 右滑
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK:- 对外暴露的方法
extension JCPageContentView {
    func setCurrentIndex(index: Int) {
        collectionView.setContentOffset(CGPoint(x: CGFloat(index) * JC_SCREEN_WIDTH, y: 0), animated: false)
    }
}
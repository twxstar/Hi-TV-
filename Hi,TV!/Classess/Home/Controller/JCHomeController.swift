//
//  JCHomeController.swift
//  Hi,TV!
//
//  Created by admin on 16/9/16.
//  Copyright © 2016年 静持大师. All rights reserved.
//

import UIKit

let kPageTitleViewH: CGFloat = 44;

class JCHomeController: UIViewController {
    // 懒加载滚动条
    private lazy var pageTitleView: JCPageTitleView = { [weak self] in
        let frame = CGRect(x: 0, y: kStatusBarH + kNavBarH, width: JC_SCREEN_WIDTH, height: kPageTitleViewH)
        let titlesArray: [String] = ["推荐", "游戏", "娱乐", "趣玩"];
        let titleView = JCPageTitleView(frame: frame, titlesArray: titlesArray)
        titleView.delegate = self
        
        return titleView
    }()
    // 滚动内容
    private lazy var pageContentView: JCPageContentView = { [weak self] in
        let contentY: CGFloat = kStatusBarH + kNavBarH + kPageTitleViewH;
        let contentH: CGFloat = JC_SCREEN_HEIGHT - (kStatusBarH + kNavBarH + kPageTitleViewH + kTabBarH)
        let frame = CGRect(x: 0, y:contentY , width: JC_SCREEN_WIDTH, height: contentH) 
        
        var childVCs: [UIViewController] = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = JC_RANDOM_COLOR()
            
            childVCs.append(vc)
        }
        
        let pageContentView = JCPageContentView(frame: frame, childVCs: childVCs, fatherVC: self!)
        
        return pageContentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化导航条UI
        setupUI()
    }
}

// MARK: - UI设置
extension JCHomeController {
    private func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        
        //
        setupNavBar()
        
        // 添加滚动条
        view.addSubview(pageTitleView)
        
        // 添加滚动内容
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = JC_RANDOM_COLOR()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageNamed: "logo")
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageNamed: "image_my_history", highImageNamed: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageNamed: "btn_search", highImageNamed: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageNamed: "Image_scan", highImageNamed: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}

// MARK: - JCPageTitleViewDelegate
extension JCHomeController: JCPageTitleViewDelegate {
    func pageTitleView(titleView: JCPageTitleView, selectedIndex: Int) {
        pageContentView.setCurrentIndex(selectedIndex) 
    }
}
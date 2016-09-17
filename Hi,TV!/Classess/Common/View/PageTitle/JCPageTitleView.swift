//
//  JCPageTitleView.swift
//  Hi,TV!
//
//  Created by admin on 16/9/17.
//  Copyright © 2016年 静持大师. All rights reserved.
//

import UIKit

/// MARK: 协议
//Protocol JCPageTitleViewDelegate: class {
//    func pageTitleView(titleView : JCPageTitleView, selectedIndex index : Int)
//}

let kScrollViewLineH: CGFloat = 2

class JCPageTitleView: UIView {

    // 当前点击索引
    private var currentIndex : Int = 0
    // 滚动条所有标题
    private var titlesArray : [String] = []
    // 滚动条lazy
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
//        scrollView.bounces = false
        
        return scrollView
    }()
    // 所以的标题label
    private lazy var titleLabels : [UILabel] = [UILabel]()
    //
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = JC_TINT_COLOR
        return scrollLine
        }()
    
    init(frame: CGRect, titlesArray: [String]) {
        self.titlesArray = titlesArray;
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JCPageTitleView {
    private func setupUI() {
        // 添加滚动条
        scrollView.frame = bounds
        addSubview(scrollView)
        
        // 滚动条上添加标题
        setupTitleLabel()
        
        // 滚动底部先和滚动条
         setupBottomLineAndScrollLine()
    }
    
    // 滚动条上添加标题
    private func setupTitleLabel() {
        let labelW: CGFloat = frame.width / CGFloat(titlesArray.count)
        let labelH: CGFloat = frame.height - kScrollViewLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titlesArray.enumerate() {
            //
            let label = UILabel()
            
            //
            label.text = title
            label.tag = index
            label.font = UIFont.systemFontOfSize(16)
            label.textColor = UIColor.lightGrayColor()
            label.textAlignment = .Center
            
            // 
            let labelX: CGFloat = CGFloat(index) * labelW
            
            label.frame = CGRectMake(labelX, labelY, labelW, labelH)
            
            scrollView.addSubview(label)
            
            titleLabels.append(label)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGrayColor()
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollLine
        // 2.1.获取第一个Label
        guard let firstLabel = titleLabels.first else { // titleLabels.first没有直接return
            return
        }
        
        firstLabel.textColor = JC_TINT_COLOR
        
        // 2.2.设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollViewLineH, width: firstLabel.frame.width, height: kScrollViewLineH)

    }
}
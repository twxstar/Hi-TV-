//
//  JCPageTitleView.swift
//  Hi,TV!
//
//  Created by admin on 16/9/17.
//  Copyright © 2016年 静持大师. All rights reserved.
//

import UIKit


let kScrollViewLineH: CGFloat = 2
let kNormaleColor: (CGFloat, CGFloat, CGFloat) = (170, 170, 170)
let kSeletedColor: (CGFloat, CGFloat, CGFloat) = (246, 90, 27)


//  MARK: 代理协议 
protocol JCPageTitleViewDelegate: class {
    // 点击titleLabel
    func pageTitleView(titleView : JCPageTitleView, selectedIndex : Int)
}

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
        scrollView.bounces = false
        
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
    // 代理
    weak var delegate: JCPageTitleViewDelegate?
    
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
            label.textColor = JC_COLOR(kNormaleColor.0, g: kNormaleColor.1, b: kNormaleColor.2, a: 1.0)
            label.textAlignment = .Center
            
            // 
            let labelX: CGFloat = CGFloat(index) * labelW
            
            label.frame = CGRectMake(labelX, labelY, labelW, labelH)
            
            scrollView.addSubview(label)
            
            //
            titleLabels.append(label)
            
            // label添加手势
            label.userInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "titleLabelTap:"))
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = JC_COLOR(kNormaleColor.0, g: kNormaleColor.1, b: kNormaleColor.2, a: 1.0)
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

// MARK: - 监听label点击
extension JCPageTitleView {
    @objc private func titleLabelTap(tapGes: UITapGestureRecognizer) {
        // 1.获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else {
            return;
        }
        
        // 2.获取之前的Label
        let previousLabel = titleLabels[currentIndex]
        
        // 3.切换文字的颜色
        currentLabel.textColor = JC_TINT_COLOR
        previousLabel.textColor = JC_COLOR(kNormaleColor.0, g: kNormaleColor.1, b: kNormaleColor.2, a: 1.0)
        
        // 4.保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        // 5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animateWithDuration(0.15) { () -> Void in
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}

// MARK: - Pubclic Func
extension JCPageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑块的逻辑
        let moveX = (targetLabel.frame.origin.x - sourceLabel.frame.origin.x) * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSeletedColor.0 - kNormaleColor.0,
                          kSeletedColor.1 - kNormaleColor.1,
                          kSeletedColor.2 - kNormaleColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = JC_COLOR(kSeletedColor.0 - colorDelta.0 * progress,
                                         g: kSeletedColor.1 - colorDelta.1 * progress,
                                         b: kSeletedColor.2 - colorDelta.2 * progress,
                                         a: 1.0)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = JC_COLOR(kNormaleColor.0 + colorDelta.0 * progress,
                                         g: kNormaleColor.1 + colorDelta.1 * progress,
                                         b: kNormaleColor.2 + colorDelta.2 * progress,
                                         a: 1.0)
        
        // 4.记录最新的index
        currentIndex = targetIndex
    }

}
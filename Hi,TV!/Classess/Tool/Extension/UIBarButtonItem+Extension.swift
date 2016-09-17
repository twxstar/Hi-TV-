//
//  UIBarButtonItem+Extension.swift
//  Hi,TV!
//
//  Created by admin on 16/9/16.
//  Copyright © 2016年 静持大师. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    // 便利构造方法
    convenience init (imageNamed: String, highImageNamed: String = "", size: CGSize = CGSizeZero) {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageNamed), forState: UIControlState.Normal)
        if highImageNamed != "" {
            btn.setImage(UIImage(named: highImageNamed), forState: UIControlState.Highlighted)
        }
        
        if size != CGSizeZero {
            btn.frame = CGRect(origin: CGPointZero, size: size)
        }
        else {
            btn.sizeToFit()
        }
        
        self.init(customView: btn)
    }
}

//
//  Common.swift
//  Hi,TV!
//
//  Created by admin on 16/9/16.
//  Copyright © 2016年 静持大师. All rights reserved.
//

import UIKit

let kStatusBarH: CGFloat = 20.0
let kNavBarH:CGFloat = 44.0
let kTabBarH:CGFloat = 49.0

let JC_SCREEN_WIDTH: CGFloat = UIScreen.mainScreen().bounds.size.width
let JC_SCREEN_HEIGHT: CGFloat = UIScreen.mainScreen().bounds.size.height

//let JC_RANDOM_COLOR: UIColor = UIColor(red: CGFloat(arc4random_uniform(255))/CGFloat(255.0), green: CGFloat(arc4random_uniform(255))/CGFloat(255.0), blue: CGFloat(arc4random_uniform(255))/CGFloat(255.0), alpha: 1.0)

func JC_RANDOM_COLOR() -> UIColor {
    return UIColor(red: CGFloat(arc4random_uniform(255))/CGFloat(255.0), green: CGFloat(arc4random_uniform(255))/CGFloat(255.0), blue: CGFloat(arc4random_uniform(255))/CGFloat(255.0), alpha: 1.0)
}


let JC_TINT_COLOR: UIColor = UIColor(red: 246.0 / 255.0, green: 90.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)


func JC_COLOR (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}




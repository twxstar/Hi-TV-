//
//  AppDelegate.swift
//  Hi,TV!
//
//  Created by admin on 16/9/16.
//  Copyright © 2016年 静持大师. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow()
        
        window?.rootViewController = JCMainTabBarController()
        
        window?.backgroundColor = UIColor.redColor()
 
        window?.makeKeyAndVisible()
        
        return true
    }

    


}


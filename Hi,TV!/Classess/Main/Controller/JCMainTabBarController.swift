//
//  JCMainTabBarController.swift
//  Hi,TV!
//
//  Created by admin on 16/9/16.
//  Copyright © 2016年 静持大师. All rights reserved.
//

import UIKit

class JCMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加子控制器
        jc_addChildViewController(JCHomeController(), itemImageNamed: "btn_home", itemTitle: "首页")
        jc_addChildViewController(JCLiveController(), itemImageNamed: "btn_column", itemTitle: "直播")
        jc_addChildViewController(JCFollowController(), itemImageNamed: "btn_live", itemTitle: "关注")
        jc_addChildViewController(JCMineController(), itemImageNamed: "btn_user", itemTitle: "我的")

    }

    // MARK: - 内部控制方法
    func jc_addChildViewController(childController: UIViewController, itemImageNamed: String, itemTitle: String) {
 
        childController.tabBarItem.image = UIImage(named: itemImageNamed + "_normal")
        childController.tabBarItem.selectedImage = UIImage(named: itemImageNamed + "_selected")
        childController.tabBarItem.title = itemTitle
        
        tabBar.tintColor = JC_TINT_COLOR
        
        //
        let mainNavigationController = JCMainNavController(rootViewController: childController)
        
        addChildViewController(mainNavigationController)
    }
    

}

//
//  YYLBaseBarController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/3.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLBaseBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initialization()
    }
    func initialization(){
        
        var item = UITabBarItem();
//        var vc = UIViewController();
        
        item = UITabBarItem.init(title: "首页", image: UIImage.init(named: "tabHome"), selectedImage: UIImage.init(named: "tabHomeHL")?.withRenderingMode(.alwaysOriginal))
        item.setTitleTextAttributes([NSForegroundColorAttributeName:RGB(235, 97, 7)], for: UIControlState.selected)
        let vc1 = YYLHomeViewController()
//        vc = YYLHistoryViewController()
        vc1.tabBarItem = item

        let viewController1 = YYLNavigationViewController(rootViewController:vc1)
        item = UITabBarItem.init(title: "直播", image: UIImage.init(named: "tabLiving"), selectedImage: UIImage.init(named: "tabLivingHL")?.withRenderingMode(.alwaysOriginal))
        item.setTitleTextAttributes([NSForegroundColorAttributeName:RGB(235, 97, 7)], for: UIControlState.selected)
        let vc2 = YYLLivingViewController()
        vc2.tabBarItem = item
        let viewController2 = YYLNavigationViewController(rootViewController:vc2)
        item = UITabBarItem.init(title: "视频", image: UIImage.init(named: "tabVideo"), selectedImage: UIImage.init(named: "tabVideoHL")?.withRenderingMode(.alwaysOriginal))
        item.setTitleTextAttributes([NSForegroundColorAttributeName:RGB(235, 97, 7)], for: UIControlState.selected)
        //渲染模式  不加则是系统的默认蓝色 .withRenderingMode(.alwaysOriginal)
        let vc3 = YYLVideoViewController()
        vc3.tabBarItem = item

        let viewController3 = YYLNavigationViewController(rootViewController:vc3)
        
        item = UITabBarItem.init(title: "关注", image: UIImage.init(named: "tabFocus"), selectedImage: UIImage.init(named: "tabFocusHL")?.withRenderingMode(.alwaysOriginal))
        item.setTitleTextAttributes([NSForegroundColorAttributeName:RGB(235, 97, 7)], for: UIControlState.selected)
        let vc4 = YYLAttentionViewController()
        vc4.tabBarItem = item
        let viewController4 = YYLNavigationViewController.init(rootViewController:vc4)
        
        item = UITabBarItem.init(title: "我的", image: UIImage.init(named: "tabMine"), selectedImage: UIImage.init(named: "tabMineHL")?.withRenderingMode(.alwaysOriginal))
        item.setTitleTextAttributes([NSForegroundColorAttributeName:RGB(235, 97, 7)], for: UIControlState.selected)
        let vc5 = YYLMineViewController()
        vc5.tabBarItem = item
        let viewController5 = YYLNavigationViewController.init(rootViewController:vc5)
      
        self.viewControllers = [viewController1,viewController2,viewController3,viewController4,viewController5]
//        self.viewControllers = [vc1,vc2,vc3,vc4,vc5]
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
//  YYLHomeViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/3.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class aaaImage: UIView {
    var sss = UIImageView()
    
}

class YYLHomeViewController: YYLViewController {

var pageMenu : CAPSPageMenu?
//    var pageMenu = CAPSPageMenu

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        self.view.backgroundColor = UIColor.white
        var controllerArray:[UIViewController]  = []
        
                let controller1:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
//        let controller1 = YYLHomeClassfiyViewController(nibName:"YYLHomeClassfiyViewController",bundle:nil)
        controller1.title = "推荐"
        controllerArray.append(controller1)
        
                let controller2:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
//        let controller2 = YYLHomeClassfiyViewController(nibName:"YYLHomeClassfiyViewController",bundle:nil)
        controller2.title = "手游"
        controllerArray.append(controller2)
        
                let controller3:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
//        let controller3 = YYLHomeClassfiyViewController(nibName:"YYLHomeClassfiyViewController",bundle:nil)
        
        controller3.title = "娱乐"
        controllerArray.append(controller3)
        
                let controller4:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
//        let controller4 = YYLHomeClassfiyViewController(nibName:"YYLHomeClassfiyViewController",bundle:nil)
        controller4.title = "游戏"
        controllerArray.append(controller4)
        
                let controller5:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
//        let controller5 = YYLHomeClassfiyViewController(nibName:"YYLHomeClassfiyViewController",bundle:nil)
        
        controller5.title = "趣玩"
        controllerArray.append(controller5)
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(RGB(255, 255, 255)),
            .viewBackgroundColor(RGB(255, 255, 255)),
            .selectedMenuItemLabelColor(RGB(253,97, 7)),
            .unselectedMenuItemLabelColor(RGB(0, 0, 0)),
            .selectionIndicatorColor(UIColor.orange),
            .menuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .menuHeight(38.0),
            .menuItemWidth(KScreenWith/5),
            .centerMenuItems(true),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorColor(RGB(255,255,255)),
//            .titleTextSizeBasedOnMenuItemWidth(true),
//            .menuItemSeparatorWidth(10)
//            .scrollAnimationDurationOnMenuItemTap(Int(10))
        ]
        
        pageMenu = CAPSPageMenu.init(viewControllers: controllerArray, frame:CGRect(x:0,y:0,width:KScreenWith,height:KScreenHight), pageMenuOptions: parameters)
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParentViewController: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

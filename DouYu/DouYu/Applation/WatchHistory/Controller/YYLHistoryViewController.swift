//
//  YYLHistoryViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/19.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLHistoryViewController: YYLViewController,YYLViewControllerDelegate{

    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backItem = true
        self.navigationItem.title = "观看历史"
        self.view.backgroundColor = UIColor.yellow
        customRightItem()
        customController()
        // Do any additional setup after loading the view.
    }
    private func customController(){
    
        var controllerArray:[UIViewController]  = []
        
        let controller:YYLHistorySubViewsViewController = YYLHistorySubViewsViewController()
        controller.title = "  直播  "
        controllerArray.append(controller)
        
        let controller1:YYLHistorySubViewsViewController = YYLHistorySubViewsViewController()
        controller1.title = "  视频  "
        controllerArray.append(controller1)
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(RGB(255, 255, 255)),
            .viewBackgroundColor(RGB(255, 255, 255)),
            .selectedMenuItemLabelColor(RGB(253,97, 7)),
            .unselectedMenuItemLabelColor(RGB(0, 0, 0)),
            .selectionIndicatorColor(UIColor.orange),
            .menuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .menuHeight(38.0),
            .menuItemWidth(KScreenWith/5),
            .menuItemWidthBasedOnTitleTextWidth(true),
//            .centerMenuItems(true),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorColor(RGB(255,255,255)),
            ]
        
        pageMenu = CAPSPageMenu.init(viewControllers: controllerArray, frame:CGRect(x:0,y:0,width:KScreenWith,height:KScreenHight), pageMenuOptions: parameters)
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParentViewController: self)
        
    }
    fileprivate func customRightItem() {
        let cleanButton = UIButton.init(type:.custom)
        cleanButton.frame = CGRect(x:0,y:0,width:30,height:20)
        cleanButton.addTarget(self, action:#selector(cleanAllData), for: UIControlEvents.touchUpInside)
       cleanButton.setTitle("清空", for: UIControlState.normal)
        cleanButton.setTitleColor(UIColor.init(hexString: "ffffff"), for: UIControlState.normal)
        cleanButton.titleLabel?.font = TextTwelveFont
        let cleanItem = UIBarButtonItem.init(customView: cleanButton)
        self.navigationItem.rightBarButtonItem = cleanItem
    }
    @objc fileprivate func cleanAllData(){
     self.YYLAlert("确定要清空所有历史记录?")
     self.YYLdelegate = self
    }
    func YYLAlertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//
//  YYLHomeViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/3.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLHomeViewController: YYLViewController {

    
var pageMenu : CAPSPageMenu?
//    var pageMenu = CAPSPageMenu

    override func viewDidLoad() {
      super.viewDidLoad()
      customNav()
        self.view.backgroundColor = UIColor.white
        var controllerArray:[UIViewController]  = []
        
        let controller1:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
        // 网络图，本地图混合
        let imagesURLStrings = [
            "默认banner图",
            "https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=9aa9d217464a20a425133495f13bf347/8cb1cb134954092304ebe97b9b58d109b3de4931.jpg",
            "https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=9aa9d217464a20a425133495f13bf347/8cb1cb134954092304ebe97b9b58d109b3de4931.jpg",
            "https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=9aa9d217464a20a425133495f13bf347/8cb1cb134954092304ebe97b9b58d109b3de4931.jpg",
            "https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=9aa9d217464a20a425133495f13bf347/8cb1cb134954092304ebe97b9b58d109b3de4931.jpg",
            //            "默认banner图",
        ];
        
        let bannerDemo = YYLCustomCycleView.init(frame: CGRect(x:0 ,y:0,width:KScreenWith,height:180), imagesURLStrings as NSArray)
        bannerDemo.autoScrollTimeInterval = 3.0
        
        controller1.title = "推荐"
        self.NavAnimation(controller1)
        controller1.customHeadView = bannerDemo
        controllerArray.append(controller1)
        
        let controller2:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
        
        controller2.title = "手游"
        self.NavAnimation(controller2)
        controller2.customHeadView = customHeadView()
        controllerArray.append(controller2)
        
        let controller3:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
        
        controller3.title = "娱乐"
        self.NavAnimation(controller3)
        controller3.customHeadView = customHeadView()
        controllerArray.append(controller3)
        
        let controller4:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
        controller4.title = "游戏"
        self.NavAnimation(controller4)
        controller4.customHeadView = customHeadView()
        controllerArray.append(controller4)
        
        let controller5:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
        
        controller5.title = "趣玩"
        self.NavAnimation(controller5)
        controller5.customHeadView = customHeadView()
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
//            .centerMenuItems(true),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorColor(RGB(255,255,255)),
            ]
        
        pageMenu = CAPSPageMenu.init(viewControllers: controllerArray, frame:CGRect(x:0,y:0,width:KScreenWith,height:KScreenHight), pageMenuOptions: parameters)
//        pageMenu?.enableHorizontalBounce = true
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParentViewController: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        if self.navigationController?.navigationBar.isHidden == true{
//            self.navigationController?.navigationBar.y = 20
//            self.view.y = 20
            self.navigationController?.navigationBar.y = 20
            UIApplication.shared .setStatusBarStyle(.lightContent, animated: true)
            self.navigationController?.navigationBar.isHidden = false
        }

    }
    fileprivate func NavAnimation(_ controller:YYLHomeClassfiyViewController){
        controller.hiddleNavBlock = {
            UIApplication.shared.setStatusBarStyle(.default, animated: true)
            UIView.animate(withDuration: 0.5, animations: {
                self.navigationController?.navigationBar.y = -52
                self.view.y = 20
            }, completion: { (true) in
                self.navigationController?.navigationBar.isHidden = true
            })
        }
        controller.showNavBlock = {
            self.navigationController?.navigationBar.isHidden = false
            UIApplication.shared .setStatusBarStyle(.lightContent, animated: true)
            UIView.animate(withDuration: 0.5, animations: {
                self.navigationController?.navigationBar.y = 20
                self.view.y = 60.0
            })
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
//        self.view.backgroundColor = UIColor.white
//        var controllerArray:[UIViewController]  = []
//        
//        let controller1:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
//        // 网络图，本地图混合
//        let imagesURLStrings = [
//            "默认banner图",
//            "https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=9aa9d217464a20a425133495f13bf347/8cb1cb134954092304ebe97b9b58d109b3de4931.jpg",
//            "https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=9aa9d217464a20a425133495f13bf347/8cb1cb134954092304ebe97b9b58d109b3de4931.jpg",
//            "https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=9aa9d217464a20a425133495f13bf347/8cb1cb134954092304ebe97b9b58d109b3de4931.jpg",
//            "https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=9aa9d217464a20a425133495f13bf347/8cb1cb134954092304ebe97b9b58d109b3de4931.jpg",
////            "默认banner图",
//            ];
//        
//        let bannerDemo = YYLCustomCycleView.init(frame: CGRect(x:0 ,y:0,width:KScreenWith,height:180), imagesURLStrings as NSArray)
//        bannerDemo.autoScrollTimeInterval = 3.0
//        
//        controller1.title = "推荐"
//        self.NavAnimation(controller1)
//        controller1.customHeadView = bannerDemo
//        controllerArray.append(controller1)
//        
//       let controller2:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
//
//        controller2.title = "手游"
//        self.NavAnimation(controller2)
//        controller2.customHeadView = customHeadView()
//        controllerArray.append(controller2)
//        
//        let controller3:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
//        
//        controller3.title = "娱乐"
//        self.NavAnimation(controller3)
//        controller3.customHeadView = customHeadView()
//        controllerArray.append(controller3)
//        
//        let controller4:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
//        controller4.title = "游戏"
//        self.NavAnimation(controller4)
//        controller4.customHeadView = customHeadView()
//        controllerArray.append(controller4)
//        
//        let controller5:YYLHomeClassfiyViewController = YYLHomeClassfiyViewController()
//        
//        controller5.title = "趣玩"
//        self.NavAnimation(controller5)
//        controller5.customHeadView = customHeadView()
//        controllerArray.append(controller5)
//        
//        let parameters: [CAPSPageMenuOption] = [
//            .scrollMenuBackgroundColor(RGB(255, 255, 255)),
//            .viewBackgroundColor(RGB(255, 255, 255)),
//            .selectedMenuItemLabelColor(RGB(253,97, 7)),
//            .unselectedMenuItemLabelColor(RGB(0, 0, 0)),
//            .selectionIndicatorColor(UIColor.orange),
//            .menuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
//            .menuHeight(38.0),
//            .menuItemWidth(KScreenWith/5),
//            .centerMenuItems(true),
//            .useMenuLikeSegmentedControl(true),
//            .menuItemSeparatorColor(RGB(255,255,255)),
//        ]
//        
//        pageMenu = CAPSPageMenu.init(viewControllers: controllerArray, frame:CGRect(x:0,y:0,width:KScreenWith,height:KScreenHight), pageMenuOptions: parameters)
//        
//        self.addChildViewController(pageMenu!)
//        self.view.addSubview(pageMenu!.view)
//        
//        pageMenu!.didMove(toParentViewController: self)
//        
    }

   fileprivate func customNav(){
    let logoButton = UIButton.init(type:.custom)
    let image = UIImage(named:"homeLogoIcon")
    logoButton.frame = CGRect(x:0,y:0,width:(image?.size.width)!,height:(image?.size.height)!)
    logoButton.addTarget(self, action:#selector(home), for: UIControlEvents.touchUpInside)
    logoButton.setImage(UIImage(named:"homeLogoIcon"), for: UIControlState.normal)
    let logoItem = UIBarButtonItem.init(customView: logoButton)
    self.navigationItem.leftBarButtonItem = logoItem
    
    let historyButton = UIButton.init(type:.custom)
    let image1 = UIImage(named:"viewHistoryIcon")
    historyButton.tag = 1001
    historyButton.addTarget(self, action:#selector(clickHomeBtn(_:)), for: UIControlEvents.touchUpInside)
    historyButton.frame = CGRect(x:0,y:0,width:(image1?.size.width)!+30,height:(image1?.size.height)!)
    historyButton.setImage(UIImage(named:"viewHistoryIcon"), for: UIControlState.normal)
    let historyItem = UIBarButtonItem.init(customView: historyButton)
    
    let scanButton = UIButton.init(type:.custom)
    let image2 = UIImage(named:"scanIcon")
    scanButton.tag = 1002
    scanButton.addTarget(self, action:#selector(clickHomeBtn(_:)), for: UIControlEvents.touchUpInside)
    scanButton.frame = CGRect(x:0,y:0,width:(image2?.size.width)!+30,height:(image2?.size.height)!)
    scanButton.setImage(UIImage(named:"scanIcon"), for: UIControlState.normal)
    let scanItem = UIBarButtonItem.init(customView: scanButton)
    
    let searchButton = UIButton.init(type:.custom)
    let image3 = UIImage(named:"searchBtnIcon")
    searchButton.tag = 1003
    searchButton.addTarget(self, action:#selector(clickHomeBtn(_:)), for: UIControlEvents.touchUpInside)
    searchButton.frame = CGRect(x:0,y:0,width:(image3?.size.width)!+15,height:(image3?.size.height)!)
    searchButton.setImage(UIImage(named:"searchBtnIcon"), for: UIControlState.normal)
    let searchItem = UIBarButtonItem.init(customView: searchButton)
    
    self.navigationItem.rightBarButtonItems = [searchItem,scanItem,historyItem]
    
    }
   fileprivate func customHeadView()->YYLClassifyHeadView{
    let view = YYLClassifyHeadView()
    view.frame = CGRect(x:0 ,y:0,width:KScreenWith,height:160)
    view.backgroundColor = UIColor.init(hexString: "f7f7f7")
    return view
    }
    
     @objc fileprivate func home(){
      print("点击首页刷新")
    }
    @objc fileprivate func clickHomeBtn(_ button:UIButton){
        switch button.tag - 1000 {
        case 1:
//            self.navigationController?.isToolbarHidden = true
            self.hidesBottomBarWhenPushed = true
            let history = YYLHistoryViewController()
            self.navigationController?.pushViewController(history, animated: true)
            self.hidesBottomBarWhenPushed = false
//            self.navigationController?.hidesBottomBarWhenPushed = false
            break
        case 2:
             break
        case 3:
             break
        default:
            break
        }
    }
}

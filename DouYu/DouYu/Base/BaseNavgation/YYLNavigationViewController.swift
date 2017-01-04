//
//  YYLNavigationViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/3.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //导航栏背景栏为背景色
   class func setupNavigationBarByColor(_ navigation:UINavigationBar,_ backGroudColor:UIColor,_ titleColor:UIColor,_ font:UIFont) {
        let BGColor = UIColor()
        if  BGColor == backGroudColor{
            if _ios7_0_ {
                navigation.barTintColor = BGColor
            } else {
                navigation.tintColor = BGColor
            }
        }
        navigation .titleTextAttributes = [NSForegroundColorAttributeName:titleColor,NSFontAttributeName:font]
        navigation.isTranslucent = false
    }
    //导航栏背景栏为图片
   class func setupNavigationBarByImage(_ navigation:UINavigationBar,_ backGroudImage:NSString,_ titleColor:UIColor,_ font:UIFont) {
        navigation .setBackgroundImage(UIImage.init(named: backGroudImage as String), for: .default)
        navigation .titleTextAttributes = [NSForegroundColorAttributeName:titleColor,NSFontAttributeName:font]
        navigation.isTranslucent = false
    }

}

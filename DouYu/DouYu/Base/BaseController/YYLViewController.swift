//
//  YYLViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/3.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
    YYLNavigationViewController .setupNavigationBarByImage((self.navigationController?.navigationBar)!, "Img_orange", UIColor.white, TextMediumFont)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //修改导航栏颜色
    UIApplication.shared .setStatusBarStyle(.lightContent, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

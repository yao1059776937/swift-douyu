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

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //修改状态栏颜色
    UIApplication.shared .setStatusBarStyle(.lightContent, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    YYLNavigationViewController .setupNavigationBarByImage((self.navigationController?.navigationBar)!, "Img_orange", UIColor.white, TextFourTeenFont)
    }

}

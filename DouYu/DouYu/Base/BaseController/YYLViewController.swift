//
//  YYLViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/3.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

protocol YYLViewControllerDelegate {
    func YYLAlertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int)
}

class YYLViewController: UIViewController,UIAlertViewDelegate {

    let YYLNavigation = YYLNavigationViewController()
    
  var YYLdelegate:YYLViewControllerDelegate?
    
  private let image = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.loading)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+5.0) {
//            self.image.frame = CGRect(x:0 ,y:0,width:KScreenWith,height:KScreenHight)
//            self.image.sd_setImage(with: URL.init(string: horrorImage))
////            self.view.bringSubview(toFront: self.image)
//            self.view.addSubview(self.image)
//        }

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.image.removeFromSuperview()
    }
    func loadAnimationStart(){
        self.view.bringSubview(toFront: self.loading)
        self.loading.star()
    }
    func loadAnimationStop(){
        self.loading.stop()
    }
    func loadAnimationFail(){
        self.loading.loadFail()
        self.view.bringSubview(toFront: self.loading)
    }
    var backItem:Bool = false {
        didSet {
            if backItem == true {
                let backButton = UIButton.init(type:.custom)
                let image = UIImage(named:"return_write")
                backButton.frame = CGRect(x:0,y:0,width:(image?.size.width)!,height:(image?.size.height)!)
                backButton.addTarget(self, action:#selector(pop), for: UIControlEvents.touchUpInside)
                backButton.setImage(UIImage(named:"return_write"), for: UIControlState.normal)
                let backItem = UIBarButtonItem.init(customView: backButton)
                self.navigationItem.leftBarButtonItem = backItem
            }
        }
    }
    @objc fileprivate func pop(){
    self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
//        YYLNavigationViewController .setupNavigationBarByImage((self.navigationController?.navigationBar)!, "Img_orange", UIColor.white, TextFourTeenFont)
        super.viewWillAppear(animated)
        //修改状态栏颜色
      UIApplication.shared .setStatusBarStyle(.lightContent, animated: true)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    open func YYLAlert(_ msg:String){
        let alert = UIAlertView.init(title: "", message: msg, delegate: self, cancelButtonTitle: "取消")
        alert.addButton(withTitle: "确定")
        alert.show()
    }
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
           YYLdelegate?.YYLAlertView(alertView, clickedButtonAt: buttonIndex)
    }
  
    lazy var loading: YYLLoadingView = {
        let loading = YYLLoadingView()
        loading.frame = CGRect(x:0 ,y:0,width:KScreenWith,height:KScreenHight)
        return loading
    }()
  
    
}

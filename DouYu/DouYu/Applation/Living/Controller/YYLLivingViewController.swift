//
//  YYLLivingViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/3.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import TTReflect


class YYLLivingViewController: YYLViewController,MenuViewDelegate {

    private var MenuView : YYLMenuView?
    private var MenuController : YYLMenuScrollerView?
    //存储模型的数组
    private var LivingTitleTagArray : NSMutableArray = ["常用","全部"]
    private var isRequest = false
    private var controllerArray:[UIViewController]  = []
    override func viewDidLoad() {
        super.viewDidLoad()

        let par = [client_sys:iosPlatform]
        self.columListModel.getColumnList(method:GetColumnList,parameters:par)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        YYLNavigationViewController .setupNavigationBarByImage((self.navigationController?.navigationBar)!, "Img_orange", UIColor.white, TextFourTeenFont)
        
         }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    func menuSeleteIndex(_ seleteIndex: NSInteger) {
       
        if seleteIndex != 0 {
            let controller = self.controllerArray[seleteIndex] as! YYLPublicViewController
            if seleteIndex == 1{
                let par = [limitPage:KlimitData,client_sys:iosPlatform,offsetPage:"0"]
                controller.liveMethod = par
            }else{
                if  seleteIndex == self.controllerArray.count - 1 {
                    let par = [limitPage:KlimitData,client_sys:iosPlatform,offsetPage:"0"]
                       controller.QieMethod = par
                }else{
                let titleTag : YYLLivingTitleTagModel = self.LivingTitleTagArray[seleteIndex-2] as! YYLLivingTitleTagModel
                let par = ["selectIndex":titleTag.cate_id,limitPage:KlimitData,client_sys:iosPlatform,offsetPage:"0"]
                controller.roomMethod = par
                }
            }
        }
        UIView.animate(withDuration: 0.5) {
//            if self.isRequest == false {
//                let controller = self.controllerArray[seleteIndex]
//                if NSStringFromClass((controller.classForCoder)).isEqual(NSStringFromClass((YYLPublicViewController.classForCoder()))){
//                    let controller2:YYLPublicViewController = controller as! YYLPublicViewController
//                    controller2.roomMethod =
//                }
//            }
        self.MenuController?.Scroller.contentOffset = CGPoint(x:CGFloat(seleteIndex)*KScreenWith,y:0)
        }
    }
    func menuPerSeleteIndex(_ seleteIndex: NSInteger) {
        //获取到上一个controller
        let controller = self.controllerArray[seleteIndex]
        if NSStringFromClass((controller.classForCoder)).isEqual(NSStringFromClass((YYLPublicViewController.classForCoder()))){
            let controller2:YYLPublicViewController = controller as! YYLPublicViewController
            if controller2.isFilterView == true && controller2.AllTagView.isHidden==false{
            controller2.AllTagView.isHidden = true
            }
        }
    }
    func slideIndex(_ seleteIndex: NSInteger) {

        let  button = self.MenuView?.viewWithTag(seleteIndex+1000)
        self.MenuView?.clickTag(button as! UIButton)
    }
    private func loadData(_ titles:NSArray){
    
    let option:[YYLPageMenuOption] = [
        .menuHeight(44), //菜单栏高度
        .selectedLabelColor(UIColor.white), //选中是label的颜色
        .unselectedLabelColor(UIColor.green), //normal是label的颜色
        .LabelFont(TextFourTeenFont) ,//label的字体大小
        .bottomLineColor(UIColor.white) ,//下划线的颜色
        .bottomLineHeight(2.0), //下划线的高度
        .buttonBorderColor(UIColor.clear), //按钮的borderColor
        .buttonBorderWidth(0) ,//按钮的borderWidth
        .buttonCornerRadius(0), //按钮的cornerRadius
        //         .buttonHeight(38) //按钮的高度
    ]
    let pagemenu = YYLMenuView.init(frame: CGRect(x:0 ,y:0,width:KScreenWith,height:44), titles:titles, controllers: [], options: option)
    pagemenu.delegate = self
    self.MenuView = pagemenu
    self.navigationItem.titleView = pagemenu
    
    
    for i in 0...titles.count-1 {
        if i == 0{
            let controller:YYLCommentViewController = YYLCommentViewController()
            controllerArray.append(controller)
        }else{
            if i == 1{
                let controller:YYLPublicViewController = YYLPublicViewController()
                controller.isFilterView = true
                controllerArray.append(controller)
            }else{
                let controller:YYLPublicViewController = YYLPublicViewController()
                controllerArray.append(controller)
            }
        }
    }
    
    let subview = YYLMenuScrollerView.init(frame: CGRect(x:0 ,y:0,width:KScreenWith,height:KScreenHight), controllers: controllerArray)
    subview.delegate = self
    self.MenuController = subview
    self.view.addSubview(subview)
    }
    
    lazy var columListModel: YYLLivingViewModel = {
        let columListModel = YYLLivingViewModel()
        weak var weakself = self
        columListModel.columSuccess = { (response) in Void()
            weakself?.LivingTitleTagArray.removeAllObjects()
            var titles:NSMutableArray = ["常用","全部"]
            for dic in response{
                let tag = Reflect<YYLLivingTitleTagModel>.mapObject(json:dic as AnyObject?)
                titles.add(tag.cate_name)
                weakself?.LivingTitleTagArray.add(tag)
            }
            titles.add("体育频道")
            self.loadData(titles)
        }
        columListModel.columFail = { (error) in Void()
         weakself?.loadAnimationFail()
        }
        return columListModel
    }()

}

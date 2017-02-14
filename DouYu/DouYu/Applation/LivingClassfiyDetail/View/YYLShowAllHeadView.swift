//
//  YYLShowAllHeadView.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/2/10.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLShowAllHeadView: UIView {

    private var perButton=UIButton()
    
    //创建标签button 当屏幕放不下的时候 到时候自动换行
     private var lineButton=UIButton()
    
//    //判断是否是换行后的第一个标签
//    private var isFistTag:Bool=false
    
    //点击标签的回调
    var clickTagBlock : ((NSInteger)->())?
    
    
    //判断是否已经加载过一遍数据了
    private var isLoadData:Bool
    
    override init(frame: CGRect) {
        self.showArray = []
        self.isLoadData = false
        self.seleteIndex = 0
        lineButton.frame = CGRect(x:10 ,y:10,width:70,height:25)
        super.init(frame: frame)

        self.backgroundColor = UIColor.init(hexString: "292929")?.withAlphaComponent(0.6)
            layoutViews()
        
    }
    
    func layoutViews(){

        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let allTouches:NSSet = event!.allTouches! as NSSet //返回与当前接收者有关的所有的触摸对象
        let touch:UITouch = allTouches.anyObject() as! UITouch  //视图中的所有对象
        //只有点击空白处才隐藏
        if NSStringFromClass((touch.view?.classForCoder)!).isEqual(NSStringFromClass((self.animateView.classForCoder))) {
                    self.isHidden = false
        }else{
                    self.isHidden = true
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        showArray = []
        self.isLoadData = false
        self.seleteIndex = 0
        lineButton.frame = CGRect(x:10 ,y:10,width:70,height:25)
        super.init(coder: aDecoder)
        
    }
    //MARK: SETTER
    var seleteIndex:NSInteger{
        didSet{
            perButton.setTitleColor(UIColor.init(hexString: "a1a1a1"), for: UIControlState.normal)
            perButton.layer.borderColor = UIColor.init(hexString: "aaaaaa")?.cgColor

            let button = self.viewWithTag(seleteIndex) as! UIButton
            button.setTitleColor(RGB(235, 97, 7), for: UIControlState.normal)
            button.layer.borderColor = RGB(235, 97, 7).cgColor
            perButton = button
        }
    }
    
    var showArray: NSArray {
        didSet {

//        self.animateView.frame = CGRect(x:0 ,y:0,width:KScreenWith,height:(CGFloat(self.showArray.count)/4.0+1.0)*35.0+40.0)
            
            if isLoadData {return
                }else{

//            if showArray.count%4==0 {
//                self.showView.mas_makeConstraints { (make) in
//                    make?.top.left().right().mas_equalTo()(self.animateView)?.setOffset(0)
//                    make?.height.setOffset((CGFloat(self.showArray.count)/4.0)*35.0)
//            }
//            }else{
//                self.showView.mas_makeConstraints { (make) in
//                    make?.top.left().right().mas_equalTo()(self.animateView)?.setOffset(0)
//                    make?.height.setOffset((CGFloat(self.showArray.count)/4.0+1.0)*35.0)
//                }
//            }
            for i in 0...showArray.count-1 {
                
                let stringWidth:String = showArray[i] as! String
                let rect:CGRect = getTextRectSize(text: stringWidth, font:TextEleven, size: CGSize(width:KScreenWith,height:KScreenHight))
                
                let button = UIButton.init(type: .custom)
                button.setTitle(showArray[i] as? String, for: UIControlState.normal)
                //当大于屏幕宽度是自动换行
                if lineButton.rightX+40+rect.width > KScreenWith{
                button.frame = CGRect(x:10.0,y:lineButton.bottomY+10,width:rect.width+30,height:25.0)
                }else{
                    //第一个button
                    if i==0 {
                button.frame = CGRect(x:10.0,y:10.0,width:rect.width+30,height:25.0)
                    }else{
                button.frame = CGRect(x:lineButton.rightX+10,y:lineButton.y,width:rect.width+30,height:25.0)
                    }
                }
                button.addTarget(self, action: #selector(clickTag(_:)), for:UIControlEvents.touchUpInside)
                button.layer.cornerRadius = 10
                button.tag = 1666 + i
                button.titleLabel?.font = TextEleven
                    button.setTitleColor(UIColor.init(hexString: "a1a1a1"), for: UIControlState.normal)
                    button.layer.borderColor = UIColor.init(hexString: "aaaaaa")?.cgColor
                button.layer.borderWidth = 1.0
                self.lineButton = button
                self.showView.addSubview(button)
            }
                self.animateView.frame = CGRect(x:0 ,y:0,width:KScreenWith,height:self.lineButton.bottomY+50)
                self.showView.mas_makeConstraints { (make) in
                    make?.top.left().right().mas_equalTo()(self.animateView)?.setOffset(0)
                    make?.height.setOffset(self.lineButton.bottomY+10)
                    }
                let lineView = UIView()
                lineView.frame = CGRect(x:0 ,y:self.showView.height - 0.5,width:KScreenWith,height:0.5)
                lineView.backgroundColor = UIColor.init(hexString: "bbbbbb")
                self.showView.addSubview(lineView)
                
                lineView.mas_makeConstraints { (make) in
                    make?.bottom.mas_equalTo()(self.showView.mas_bottom)?.setOffset(0)
                    make?.left.right().mas_equalTo()(self)?.setOffset(0)
                    make?.height.setOffset(0.5)
                }
                
                self.headView.mas_makeConstraints { (make) in
                    make?.top.mas_equalTo()(self.showView.mas_bottom)?.setOffset(0)
                    make?.left.right().mas_equalTo()(self.animateView)?.setOffset(0)
                    make?.height.setOffset(40.0)
                }
//                animateView.height = lineButton.bottomY+10+40
//                showView.height = lineButton.bottomY+10
//                headView.y = showView.bottomY
            }
        }
    }
    
//MARK: 赖加载
    private lazy var showView: UIView = {
        let showView = UIView()
        showView.backgroundColor = UIColor.clear
        showView.alpha = 1.0
        self.animateView.addSubview(showView)
        return showView
    }()

     lazy var animateView: UIView = {
        let animateView = UIView()
        animateView.backgroundColor = UIColor.white
        animateView.alpha = 1.0
        self.addSubview(animateView)
        return animateView
    }()
    private lazy var showButton: UIButton = {
        let showButton = UIButton.init(type: .custom)
        showButton.setImage(UIImage(named:"three_column_view_open"), for: UIControlState.normal)
        self.animateView.addSubview(showButton)
        return showButton
    }()
    private  lazy var headView: YYLLivingHeadView = {

         let headView = YYLLivingHeadView()
        weak var weakself = self
        headView.clickTagButton = {
            
             weakself?.isHidden = true
        }
        headView.backgroundColor = UIColor.init(hexString: "f7f7f7")
        headView.tagTitleArray = []
        headView.imageTitle = "three_column_view_close"
        self.animateView.addSubview(headView)
        return headView
    }()
//MARK: 点击标签
    @objc fileprivate  func clickTag(_ button:UIButton){
        perButton.setTitleColor(UIColor.init(hexString: "a1a1a1"), for: UIControlState.normal)
        perButton.layer.borderColor = UIColor.init(hexString: "aaaaaa")?.cgColor
        button.setTitleColor(RGB(235, 97, 7), for: UIControlState.normal)
        button.layer.borderColor = RGB(235, 97, 7).cgColor
        perButton = button
        if self.clickTagBlock != nil{
            self.clickTagBlock!(perButton.tag-1666+1000)
        }
         self.isHidden = true
    }
}

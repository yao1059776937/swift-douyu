//
//  YYLMenuView.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/19.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

protocol MenuViewDelegate:class{
    func menuSeleteIndex(_ seleteIndex:NSInteger) //当前选中的下标
    func menuPerSeleteIndex(_ seleteIndex:NSInteger) //上个选中的下标
    func slideIndex(_ seleteIndex:NSInteger) //当前滑动的位置时button的小标
}

enum MenuItemType {
    case defaultWidth(CGFloat) //默认不滑动,平分屏幕宽
    case customWidth(CGFloat) //如果总长度大于self.width 则滑动
}
public enum YYLPageMenuOption {
    case menuHeight(CGFloat) //菜单栏高度
    case selectedLabelColor(UIColor) //选中是label的颜色
    case unselectedLabelColor(UIColor) //normal是label的颜色
    case LabelFont(UIFont) //label的字体大小
    case bottomLineColor(UIColor) //下划线的颜色
    case bottomLineHeight(CGFloat) //下划线的高度
    case buttonBorderColor(UIColor) //按钮的borderColor
    case buttonBorderWidth(CGFloat) //按钮的borderWidth
    case buttonCornerRadius(CGFloat) //按钮的cornerRadius
//    case buttonHeight(CGFloat) //按钮的高度
}
 class YYLMenuView: UIView{

    //因为要根据字体宽度来确定大小,因此需要拿到上一个button 来确定下一个button的位置
    private var perButton=UIButton()
    
    //上一个button的下标
    open var perSelectIndex:NSInteger = 0
    //代理
      var delegate:MenuViewDelegate?
    
    //上一个选中时的button
    private var selectButton = UIButton()
    
    open var menuViewHeight:CGFloat = 34.0
    open var selectedLabelViewColor:UIColor = UIColor.white
    open var unselectedLabelViewColor:UIColor = UIColor.init(hexString: "f7f7f7")!
    open var LabelViewFont:UIFont = TextFourTeenFont
    open var bottomLineViewColor:UIColor = UIColor.white
    open var bottomLineViewHeight:CGFloat = 1.0
    open var buttonViewBorderColor:UIColor = UIColor.white
    open var buttonViewBorderWidth:CGFloat = 1.0
    open var buttonViewCornerRadius:CGFloat = 4.0
//    open var buttonViewHeight:CGFloat = 25.0
    
     init(frame:CGRect,titles:NSArray,controllers:[UIViewController],options:[YYLPageMenuOption]?){
        super.init(frame: frame)
        if let menuOption = options {
            for option in menuOption {
                switch (option) {
                case let .menuHeight(value):
                    menuViewHeight = value
                case let .selectedLabelColor(value):
                    selectedLabelViewColor = value
                case let .unselectedLabelColor(value):
                    unselectedLabelViewColor = value
                case let .LabelFont(value):
                    LabelViewFont = value
                case let .bottomLineColor(value):
                    bottomLineViewColor = value
                case let .bottomLineHeight(value):
                    bottomLineViewHeight = value
                case let .buttonBorderColor(value):
                    buttonViewBorderColor = value
                case let .buttonBorderWidth(value):
                    buttonViewBorderWidth = value
                case let .buttonCornerRadius(value):
                    buttonViewCornerRadius = value
//                case let .buttonHeight(value):
//                    buttonViewHeight = value
        }
        }
        }
        //根据字体宽度来创建控件大小
        configUI(titles)

    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    //页面控件布局
    fileprivate func configUI(_ titlesArray:NSArray){
    
        self.menuScroller.mas_makeConstraints { (make) in
            make?.top.left().right().bottom().mas_equalTo()(self)?.setOffset(0)
        }
        //
        for i in 0...titlesArray.count-1 {
            
            let stringWidth:String = titlesArray[i] as! String
            let rect:CGRect = getTextRectSize(text: stringWidth, font:TextEleven, size: CGSize(width:KScreenWith,height:KScreenHight))
            
            let button = UIButton.init(type: .custom)
            button.setTitle(titlesArray[i] as? String, for: UIControlState.normal)
            
            button.addTarget(self, action: #selector(clickTag(_:)), for:UIControlEvents.touchUpInside)
            button.layer.cornerRadius = self.buttonViewCornerRadius
            button.tag = 1000+i
            button.titleLabel?.font = self.LabelViewFont
            if i==0 {
                button.frame = CGRect(x:0,y:0,width:rect.width+30,height:self.menuViewHeight - self.bottomLineViewHeight)
                button.isSelected = true
                self.selectButton = button
                self.lineImage.frame = CGRect(x:0,y:self.menuViewHeight - self.bottomLineViewHeight,width:rect.width+30,height:self.bottomLineViewHeight)
                perSelectIndex = 0
                self.lineImage.backgroundColor = self.bottomLineViewColor
            }else{
                button.frame = CGRect(x:self.perButton.rightX,y:self.perButton.y,width:rect.width+30,height:self.menuViewHeight - self.bottomLineViewHeight)
            }
            button.setTitleColor(self.selectedLabelViewColor, for: UIControlState.selected)
            button.setTitleColor(self.unselectedLabelViewColor, for: UIControlState.normal)
            button.layer.borderColor = self.buttonViewBorderColor.cgColor
            button.layer.borderWidth = self.buttonViewBorderWidth
            self.menuScroller.addSubview(button)
            self.perButton = button
        }
        

        self.menuScroller.contentSize=CGSize(width:self.perButton.rightX,height:self.height-self.bottomLineViewHeight)

    }
//点击菜单按钮
   @objc func clickTag(_ button:UIButton){
    
    if button == self.selectButton{
    return
    }
 
    //动画 当超出屏幕时点击的那个按钮总是在中间
    if button.x<KScreenWith/2.0 || (self.menuScroller.contentSize.width - button.x)<KScreenWith/2.0{
        if button.x < KScreenWith/2.0{
            UIView.animate(withDuration: 0.5) {
            self.menuScroller.contentOffset = CGPoint(x:0,y:0)
            }
        }else{

            UIView.animate(withDuration: 0.5) {
                self.menuScroller.contentOffset = CGPoint(x:self.menuScroller.contentSize.width-KScreenWith+13,y:0)
            }
   
        }
    //该种情况不需要动画 因为没有到中间
    }else{
    UIView.animate(withDuration: 0.5, animations: { 
//        self.menuScroller.contentOffset = CGPoint(x:NSInteger(button.x) - NSInteger(button.x)%NSInteger(KScreenWith/2.0),y:0)
                self.menuScroller.contentOffset = CGPoint(x:button.x+button.width/2.0-KScreenWith/2.0,y:0)
    })
    }
    
    
    self.delegate?.menuSeleteIndex(button.tag-1000)
    
    self.selectButton.isSelected = false
    button.isSelected = true
    self.delegate?.menuPerSeleteIndex(self.selectButton.tag-1000) //上个选中的下标
    self.selectButton = button
    UIView.animate(withDuration: 0.5) { 
        self.lineImage.frame = CGRect(x:button.x ,y:self.lineImage.y,width:button.width,height:self.lineImage.height)
    }
    }
//MARK:赖加载
    //scrollerView
   private lazy var menuScroller: UIScrollView = {
        let menuScroller = UIScrollView()
        menuScroller.showsHorizontalScrollIndicator = false
        menuScroller.bounces = false
        self.addSubview(menuScroller)
        return menuScroller
    }()
    //下划线
   private lazy var lineImage: UIImageView = {
        let lineImage = UIImageView.init(image: UIImage(named:""))
        self.menuScroller.addSubview(lineImage)
        return lineImage
    }()
    
}
//这个类是显示点击菜单后的显示内容的视图
 class YYLMenuScrollerView: UIView,UIScrollViewDelegate{
    
    var delegate:MenuViewDelegate?
    var menuView = MenuItemView()
    
    
    init(frame:CGRect,controllers:[UIViewController]){
            super.init(frame: frame)
        
        self.Scroller.mas_makeConstraints { (make) in
            make?.top.left().mas_equalTo()(self)?.setOffset(0)
            make?.size.setSizeOffset(CGSize(width:KScreenWith,height:KScreenHight))
        }
        for i in 0...controllers.count-1 {

            let controller = controllers[i]
            let subView = controller.view
            
            let view = UIView.init(frame: CGRect(x:CGFloat(i)*KScreenWith ,y:0,width:KScreenWith,height:KScreenHight))
            view.addSubview(subView!)
            self.Scroller.addSubview(view)
            
        }
        self.Scroller.contentSize = CGSize(width:CGFloat(controllers.count)*KScreenWith, height:KScreenHight-49-64)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
     lazy var Scroller: UIScrollView = {
        let menuScroller = UIScrollView()
        menuScroller.showsHorizontalScrollIndicator = false
        menuScroller.translatesAutoresizingMaskIntoConstraints = false
        menuScroller.scrollsToTop = false;
        menuScroller.bounces = true
        menuScroller.isPagingEnabled = true
        menuScroller.delegate = self
        self.addSubview(menuScroller)
        return menuScroller
    }()
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.delegate?.slideIndex(NSInteger(scrollView.contentOffset.x/KScreenWith))
    }
}

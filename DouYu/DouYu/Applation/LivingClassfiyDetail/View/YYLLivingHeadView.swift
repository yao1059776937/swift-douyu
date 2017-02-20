//
//  YYLLivingHeadView.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/2/10.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit


class YYLLivingHeadView: UIView {

     var perButton=UIButton()

    //创建标签button
    private var lineButton=UIButton()
    
    var clickTagButton:(()->())?
    
    
    override init(frame: CGRect) {
        self.imageTitle = ""
        self.tagTitleArray = []
        self.perSelete = 0
        super.init(frame: frame)
        layoutViews()
    }

    required init?(coder aDecoder: NSCoder) {
        self.imageTitle = ""
        self.tagTitleArray = []
        self.perSelete = 0
       super.init(coder: aDecoder)
        
    }

    func layoutViews(){
    
        let lineView = UIView()
        lineView.frame = CGRect(x:0 ,y:39.5,width:KScreenWith,height:0.5)
        lineView.backgroundColor = UIColor.init(hexString: "bbbbbb")
        self.addSubview(lineView)
        
        self.scroller.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.mas_top)?.setOffset(0)
            make?.left.mas_equalTo()(self)?.setOffset(0)
            make?.bottom.mas_equalTo()(self.mas_bottom)?.setOffset(-0.5)
            make?.right.mas_equalTo()(self.mas_right)?.setOffset(-40)
        }
        self.button.mas_makeConstraints { (make) in
            make?.top.right().mas_equalTo()(self)?.setOffset(0)
            make?.bottom.mas_equalTo()(self.mas_bottom)?.setOffset(-0.5)
            make?.left.mas_equalTo()(self.scroller.mas_right)?.setOffset(0.5)
        }
        let ButtonLineView = UIView()

        ButtonLineView.backgroundColor = UIColor.init(hexString: "bbbbbb")
        self.addSubview(ButtonLineView)
        
        ButtonLineView.mas_makeConstraints { (make) in
            make?.top.bottom().mas_equalTo()(self)?.setOffset(0)
            make?.right.mas_equalTo()(self.button.mas_left)?.setOffset(0)
            make?.width.setOffset(0.5)
        }
    }
    //MARK  ----SETTER----- 
    //从全部点击过来的标签
    var perSelete:NSInteger{
        didSet{
            

            perButton.setTitleColor(UIColor.init(hexString: "a1a1a1"), for: UIControlState.normal)
            perButton.layer.borderColor = UIColor.init(hexString: "aaaaaa")?.cgColor
            
            let button = self.viewWithTag(perSelete) as! UIButton
            clickTag(button)
            button.setTitleColor(RGB(235, 97, 7), for: UIControlState.normal)
            button.layer.borderColor = RGB(235, 97, 7).cgColor
            perButton = button
        }
    }
    var imageTitle: String {
        didSet {
            button.setImage(UIImage(named:imageTitle), for: UIControlState.normal)
        }
    }
    var tagTitleArray: NSArray {
        didSet {
            if tagTitleArray.count == 0 {
                return
            }
            for i in 0...tagTitleArray.count-1 {
                
                let stringWidth:String = tagTitleArray[i] as! String
                let rect:CGRect = getTextRectSize(text: stringWidth, font:TextEleven, size: CGSize(width:KScreenWith,height:KScreenHight))
                
                let button = UIButton.init(type: .custom)
                button.setTitle(tagTitleArray[i] as? String, for: UIControlState.normal)

                button.addTarget(self, action: #selector(clickTag(_:)), for:UIControlEvents.touchUpInside)
                button.layer.cornerRadius = 10
                button.tag = 1000+i
                button.titleLabel?.font = TextEleven
                if i==0 {
                    button.frame = CGRect(x:10.0,y:10.0,width:rect.width+30,height:25.0)
                    button.setTitleColor(RGB(235, 97, 7), for: UIControlState.normal)
                    button.layer.borderColor = RGB(235, 97, 7).cgColor
                    self.lineButton = button
                    perButton = button
                }else{
                    button.frame = CGRect(x:self.lineButton.rightX+10,y:self.lineButton.y,width:rect.width+30,height:25.0)
                    button.setTitleColor(UIColor.init(hexString: "a1a1a1"), for: UIControlState.normal)
                    button.layer.borderColor = UIColor.init(hexString: "aaaaaa")?.cgColor
                }
                button.layer.borderWidth = 1.0
                self.scroller.addSubview(button)
                self.lineButton = button
            }
            self.scroller.contentSize=CGSize(width:10+(70+15)*tagTitleArray.count,height:30)
        }
    }
    //MARK:点击标签
    @objc func clickTag(_ button:UIButton){
        if button.tag-1000 == 0 || self.lineButton.rightX+10 <= (KScreenWith-30){
            UIView.animate(withDuration: 0.5) {
                self.scroller.contentOffset = CGPoint(x:0,y:0)
            }
        }else{
            if 10.0+(70.0+15.0)*CGFloat(self.tagTitleArray.count) - (button.x+40) < KScreenWith-30{
                //拿到那个临街button 从最后一个开始算 看哪一个刚好显示不出来 后面那个就是临界button
                
                //拿到最后一个button 判断还有多少没有显示
                let lastButton = self.viewWithTag(1000+tagTitleArray.count-1) as! UIButton
                    //拿到临界button
                    let criticalButton = self.viewWithTag(1000+tagTitleArray.count-Int(KScreenWith-70)/70) as! UIButton
                    // lastButton.rightX - button.x - (KScreenWith-70.0) 最后一个还有多少没有出来
                    UIView.animate(withDuration: 0.5) {
                    self.scroller.contentOffset = CGPoint(x:criticalButton.x + (lastButton.rightX - criticalButton.x - (KScreenWith-70.0)+15.0)-40,y:0)
                }
                
            }else{
           UIView.animate(withDuration: 0.5) {
               self.scroller.contentOffset = CGPoint(x:button.x-40,y:0)
        }
            }
        }
        if perButton == button {
            
        }else{
            perButton.setTitleColor(UIColor.init(hexString: "a1a1a1"), for: UIControlState.normal)
            perButton.layer.borderColor = UIColor.init(hexString: "aaaaaa")?.cgColor
            button.setTitleColor(RGB(235, 97, 7), for: UIControlState.normal)
            button.layer.borderColor = RGB(235, 97, 7).cgColor
            perButton = button
        }
        
    }
    //MARK:点击展开全部标签
    @objc private func showViews(){
        if self.clickTagButton != nil {
            self.clickTagButton!()
        }
    }
//MARK:赖加载
   private lazy var scroller: UIScrollView = {
        let scroller = UIScrollView()
        scroller.showsHorizontalScrollIndicator = false
        scroller.bounces = false
        self.addSubview(scroller)
        return scroller
    }()
    private lazy var button: UIButton = {
      let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(showViews), for: UIControlEvents.touchUpInside)
        self.addSubview(button)
        return button
    }()

}

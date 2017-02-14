//
//  YYLPageCountView.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/11.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLPageCountView: UIView {

    private var firstImageView = UIImageView()
    //当前是第几个 用于在scrollerView上不知道当前滑动到第几个了 少用
    var currentIndex:NSInteger = 0;
    
    var countArray = NSMutableArray()
    
    init(frame:CGRect,pageCount:NSInteger,firstCountImageView:UIImageView?){
        
        super.init(frame: frame)
        self.createImagePageCountView(pageCount: pageCount, firstCountImageView: firstCountImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
//    // 两个图片之间的距离
//    @IBInspectable open var countDistance : NSInteger {
//        didSet {
//            if countDistance<0{return}
//            self.page.frame = CGRect(x:self.page.x,y:self.page.y,width:KScreenWith,height:self.page.height)
//        }
//    }
    
    func createImagePageCountView(pageCount:NSInteger,firstCountImageView:UIImageView?) {
        if pageCount == 0{return}
        var space : CGFloat
        for i in 0..<pageCount {
            if firstCountImageView != nil{
        self.firstImageView = firstCountImageView!
                space = 5.0
                if i==0 {
                    firstCountImageView?.frame = CGRect(x:((KScreenWith-space*CGFloat(pageCount-1)-(firstCountImageView?.width)!*CGFloat(pageCount))/2.0 + ((firstCountImageView?.width)! + space)*CGFloat(i)),y:0,width:(firstCountImageView?.width)!,height:self.height)
                  self.addSubview(firstCountImageView!)
                self.countArray.add(firstCountImageView!)
                }else{
                let view = UIView()
                view.frame = CGRect(x:((KScreenWith-space*CGFloat(pageCount-1)-(firstCountImageView?.width)!*CGFloat(pageCount))/2.0 + ((firstCountImageView?.width)! + space)*CGFloat(i)),y:0,width:(firstCountImageView?.width)!,height:self.height)
                view.backgroundColor = UIColor.clear
                let label = UILabel()
                label.layer.cornerRadius = self.height/2.0;
                label.layer.masksToBounds = true
                label.backgroundColor = UIColor.init(hexString: "cccccc");
                label.frame = CGRect(x:(view.width - self.height)/2,y:0,width:self.height,height:self.height)
                view.addSubview(label)
                self.addSubview(view)
                self.countArray.add(view)
                }
            }else{
                space = 5.0
                let label = UILabel()
                label.layer.cornerRadius = self.height/2.0;
                label.layer.masksToBounds = true
                label.backgroundColor = UIColor.init(hexString: "cccccc");
                label.frame = CGRect(x:((KScreenWith-space*CGFloat(pageCount-1)-self.height*CGFloat(pageCount))/2.0 + (self.height + space)*CGFloat(i)),y:0,width:self.height,height:self.height)
                self.addSubview(label)
                self.countArray.add(label)
            }
        }
    }
    func exchangeCount(_ startCount:NSInteger,_ endCount:NSInteger){
        var view1 = UIView()
        var view2 = UIView()
        
        view1 = self.countArray[startCount] as! UIView
        view2 = self.countArray[endCount] as! UIView
        var x1:CGFloat
        x1 = view1.x
        let x2:CGFloat = view2.x
        UIView.animate(withDuration: 0.5, animations: {
            view1.x = x2
            view2.x = x1
        })
        self.countArray.exchangeObject(at:startCount, withObjectAt:endCount)
    }
}

//
//  YYLPageCountView.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/11.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLPageCountView: UIView {

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
    func createImagePageCountView(pageCount:NSInteger,firstCountImageView:UIImageView?) {
        var space : CGFloat
        for i in 0..<pageCount {
            if firstCountImageView != nil{

                if self.width - (firstCountImageView?.width)!*CGFloat(pageCount) > 0 {
                space = (self.width - (firstCountImageView?.width)!*CGFloat(pageCount))/CGFloat(pageCount - 1)
                }else{
                space = 0.0
                }
                if i==0 {
                  self.addSubview(firstCountImageView!)
                self.countArray.add(firstCountImageView!)
                }else{
                let view = UIView()
                view.frame = CGRect(x:((firstCountImageView?.rightX)!*CGFloat(i) + space*CGFloat(i)),y:0,width:(firstCountImageView?.width)!,height:self.height)
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
                if self.width - (firstCountImageView?.width)!*CGFloat(pageCount) > 0 {
                space = (self.width - self.height*CGFloat(pageCount))/CGFloat(pageCount - 1)
                }else{
                    space = 0.0
                }
                let label = UILabel()
                label.layer.cornerRadius = self.height/2.0;
                label.layer.masksToBounds = true
                label.backgroundColor = UIColor.init(hexString: "cccccc");
                label.frame = CGRect(x:(space+self.height)*CGFloat(i),y:0,width:self.height,height:self.height)
                self.addSubview(label)
                self.countArray.add(label)
            }
        }
    }
}

//
//  YYLMenuView.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/19.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

enum MenuItemType {
    case defaultWidth(CGFloat) //默认不滑动,平分屏幕宽
    case customWidth(CGFloat) //如果总长度大于self.width 则滑动
}

 class YYLMenuView: UIView{

    let menuitems = [MenuItemView()]
    
    
    init(frame:CGRect,titles:NSArray,controllers:[UIViewController]){
        super.init(frame: frame)
 
        let headView = UIScrollView.init(frame: CGRect(x:0 ,y:0,width:frame.width,height:43.5))
        let lineView = UIView.init(frame: CGRect(x:0 ,y:43.5,width:frame.width,height:0.5))
        self.addSubview(headView)
        self.addSubview(lineView)
        
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    
}
class YYLMenuItem: UIView {
    
}

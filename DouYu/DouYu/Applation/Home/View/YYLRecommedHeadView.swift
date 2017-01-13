//
//  YYLRecommedHeadView.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/10.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLRecommedHeadView: UIView {

//    var imageArray = NSArray()
    
    
   override init(frame: CGRect) {
    super.init(frame: frame)
    self.scroller .mas_makeConstraints { (make) in
       make?.edges.mas_equalTo()(self)?.setOffset(0)
    }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public var imageArray: NSArray?{
        didSet{
            
        }
    }
    
    fileprivate lazy var scroller : UIScrollView = {
        let scroller = UIScrollView()
        scroller.showsVerticalScrollIndicator = false
        scroller.showsHorizontalScrollIndicator = false
        self.addSubview(scroller)
        return scroller
    }()
    
}

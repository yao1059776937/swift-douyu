//
//  YYLLoadingView.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/2/21.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLLoadingView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = RGB(242, 242, 242)
         self.backgroundColor = UIColor.white
        self.addSubview(self.anImageView)
        self.poinlLabel.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.anImageView.mas_bottom)?.setOffset(0)
            make?.left.right().mas_equalTo()(self)?.setOffset(0)
            make?.height.setOffset(20)
        }
        loadImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    func star(){
        let image = UIImage(named:"dym_loading_01")
        anImageView.frame = CGRect(x:(KScreenWith-(image?.size.width)!)/2 ,y:(KScreenHight-(image?.size.height)!-64-49-40)/2,width:(image?.size.width)!,height:(image?.size.height)!)
        poinlLabel.font = TextTwelveFont
        poinlLabel.text = "内容正在加载..."
        poinlLabel.textColor = UIColor.init(hexString: "c2c2c2")
        self.anImageView.startAnimating()
        self.isHidden = false
    }
    func stop(){
        self.isHidden = true
    }
    func loadFail() {
//        self.isHidden = true
        self.anImageView.stopAnimating()
        let image = UIImage(named:"group_small_xiaozupeitu")
        self.anImageView.frame = CGRect(x:(KScreenWith-(image?.size.width)!)/2 ,y:(KScreenHight-(image?.size.height)!-64-49-40)/2,width:(image?.size.width)!,height:(image?.size.height)!)
        self.anImageView.image = UIImage(named:"group_small_xiaozupeitu")
        self.poinlLabel.text = "糟糕，加载失败~"
        self.poinlLabel.textColor = UIColor.init(hexString: "ff5000")
        self.poinlLabel.font = TextFourTeenFont
    }
    func loadImage(){
        var imageArray:[UIImage] = []
        for i in 1...4 {
            let image = UIImage(named:"dym_loading_0\(i)")
            imageArray.append(image!)
        }
        //        _:[UIImage] = imageArray
        //先制空
        self.anImageView.animationImages = nil
        self.anImageView.animationImages = imageArray
        self.anImageView.animationDuration = 1
        self.anImageView.animationRepeatCount = 0
    }
    //MARK:加载动画的ImageView
    fileprivate lazy var anImageView:UIImageView={
        let anImageView = UIImageView()
        let image = UIImage(named:"dym_loading_01")
        anImageView.frame = CGRect(x:(KScreenWith-(image?.size.width)!)/2 ,y:(KScreenHight-(image?.size.height)!-64-49-40)/2,width:(image?.size.width)!,height:(image?.size.height)!)
//        self.addSubview(anImageView)
        return anImageView
    }()
//    //MARK:加载页面失败的ImageView
//    fileprivate lazy var failImageView:UIImageView={
//        let failImageView = UIImageView()
//        let image = UIImage(named:"group_small_xiaozupeitu")
//        failImageView.frame = CGRect(x:(KScreenWith-(image?.size.width)!)/2 ,y:(KScreenHight-(image?.size.height)!-64-49-40)/2,width:(image?.size.width)!,height:(image?.size.height)!)
//        //        self.addSubview(anImageView)
//        return failImageView
//    }()
    //MARK:加载动画的label
    fileprivate lazy var poinlLabel:UILabel={
        let poinlLabel = UILabel()

        poinlLabel.textAlignment = .center
        
        self.addSubview(poinlLabel)
        return poinlLabel
    }()
    
}

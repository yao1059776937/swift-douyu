//
//  YYLLoadingView.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/2/21.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLLoadingView: UIView {

    var loadReTry:(()->())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = RGB(242, 242, 242)
         self.backgroundColor = UIColor.white
         self.addSubview(self.anImageView)
         self.poinlLabel.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.anImageView.mas_bottom)?.setOffset(10)
            make?.left.right().mas_equalTo()(self)?.setOffset(0)
            make?.height.setOffset(20)
        }
        self.reTry.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.poinlLabel.mas_bottom)?.setOffset(40)
            make?.left.mas_equalTo()(self.mas_left)?.setOffset((KScreenWith-120)/2)
            make?.size.setSizeOffset(CGSize(width:120,height:30))
        }
        loadImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    func star(){
        self.reTry.isHidden = true
        let image = UIImage(named:"dym_loading_01")
        anImageView.frame = CGRect(x:(KScreenWith-(image?.size.width)!)/2 ,y:(KScreenHight-(image?.size.height)!-64-49-40)/2,width:(image?.size.width)!,height:(image?.size.height)!)
        poinlLabel.font = TextTwelveFont
        poinlLabel.text = "内容正在加载..."
        poinlLabel.textColor = UIColor.init(hexString: "c2c2c2")
        self.anImageView.startAnimating()
        self.isHidden = false
    }
    func stop(){
        self.reTry.isHidden = true
        self.isHidden = true
    }
    func loadFail() {
//        self.isHidden = true
        self.reTry.isHidden = false
        self.anImageView.stopAnimating()
        let image = UIImage(named:"group_small_xiaozupeitu")
        self.anImageView.frame = CGRect(x:(KScreenWith-(image?.size.width)!)/2 ,y:(KScreenHight-(image?.size.height)!-64-49-40)/2,width:(image?.size.width)!,height:(image?.size.height)!)
        self.anImageView.image = UIImage(named:"group_small_xiaozupeitu")
        self.poinlLabel.text = "糟糕，加载失败~"
        self.poinlLabel.textColor = RGB(235, 97, 7)
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
    fileprivate lazy var reTry:UIButton={
        let reTry = UIButton()
        reTry.titleLabel?.textAlignment = .center
        reTry.setTitle("点击重试", for: .normal)
        reTry.setTitleColor(UIColor.white, for: .normal)
        reTry.addTarget(self, action: #selector(retry), for: .touchUpInside)
        reTry.titleLabel?.font = TextTwelveFont
        reTry.layer.cornerRadius = 2
        reTry.backgroundColor = RGB(235, 97, 7)
        self.addSubview(reTry)
        return reTry
    }()
    //点击重试
    @objc private func retry(){
        if loadReTry != nil {
            loadReTry!()
        }
    }
}

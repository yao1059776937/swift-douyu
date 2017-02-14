//
//  YYLClassifyCollectionViewCell.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/16.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLClassifyCollectionViewCell: UICollectionViewCell {
    
    var  title:String?
    var image:String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        ConfigUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func ConfigUI() {
        self.Images.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.contentView.mas_top)?.setOffset(5.0)
            make?.left.mas_equalTo()(self.contentView.mas_left)?.setOffset((self.contentView.width - 40)/2.0)
            make?.size.setSizeOffset(CGSize(width:40,height:40))
        }
        self.titles.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.Images.mas_bottom)?.setOffset(5.0)
            make?.left.mas_equalTo()(self.contentView.mas_left)?.setOffset(0)
            make?.size.setSizeOffset(CGSize(width:self.contentView.width,height:11.0))
        }
    }
    //MARK: 赖加载
    fileprivate lazy var titles:UILabel = {
        let titles = UILabel()
        titles.font = TextEleven
        titles.textColor = UIColor.init(hexString: "222222")
        titles.textAlignment = .center
        titles.text =  "测试\(arc4random()%100)"
        self.contentView.addSubview(titles)
        return titles
    }()
    fileprivate lazy var Images:UIImageView = {
        let Images = UIImageView()
        Images.image = UIImage(named:"默认banner图")
        Images.layer.cornerRadius = 20.0
        Images.layer.masksToBounds = true
        self.contentView.addSubview(Images)
        return Images
    }()
}

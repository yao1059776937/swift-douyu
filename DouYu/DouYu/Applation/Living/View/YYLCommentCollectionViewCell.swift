//
//  YYLCommentCollectionViewCell.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/2/15.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLCommentCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        ConfigUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func ConfigUI(){

        self.gameCoverImage.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.contentView.mas_top)?.setOffset((self.contentView.height-60)/2.0)
            make?.left.mas_equalTo()(self.contentView.mas_left)?.setOffset((self.contentView.width-40)/2.0)
            make?.size.setSizeOffset(CGSize(width:40.0,height:40.0))
        }
        self.gameName.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.gameCoverImage.mas_bottom)?.setOffset(8.0)
            make?.left.mas_equalTo()(self.contentView)?.setOffset(0)
            make?.size.setSizeOffset(CGSize(width:self.contentView.width-1,height:12.0))
        }
        //右边线条和下边线条
        let rightView = UIView()
        rightView.backgroundColor = UIColor.init(hexString: "aaaaaa")
        self.contentView.addSubview(rightView)
        
        rightView.mas_makeConstraints { (make) in
            make?.top.right().bottom().mas_equalTo()(self.contentView)?.setOffset(0)
            make?.width.setOffset(1.0)
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.init(hexString: "aaaaaa")
        self.contentView.addSubview(bottomView)
        
        bottomView.mas_makeConstraints { (make) in
            make?.left.right().bottom().mas_equalTo()(self.contentView)?.setOffset(0)
            make?.height.setOffset(1.0)
        }
        
    }
    lazy var gameCoverImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"默认banner图")
        image.layer.cornerRadius = 20.0
        image.layer.masksToBounds = true
        self.contentView.addSubview(image)
        return image
    }()
    lazy var gameName: UILabel = {
        let gameName = UILabel()
        gameName.text = "英雄联盟"
        gameName.font = TextTwelveFont
        gameName.textAlignment = NSTextAlignment.center
        gameName.textColor = UIColor.black
        self.contentView.addSubview(gameName)
        return gameName
    }()
}

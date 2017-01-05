//
//  YYLHomeCollectionViewCell.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/4.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLHomeCollectionViewCell: UICollectionViewCell {

    var title = UILabel()
    var cover = CoverImage()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        ConfigUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func ConfigUI(){
        
        cover.image = UIImage(named:"默认banner图")
        self.contentView.addSubview(self.cover)
        self.cover.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.contentView)?.setOffset(0)
            make?.left.mas_equalTo()(self.contentView.mas_left)?.setOffset(3.0)
            make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.setOffset(-30.0)
            make?.width.setOffset((KScreenWith-12)/2.0)
        }
        self.cover.initImageView()
        
        self.title.text = "小可：你要开盒子吗"
        self.title.font = TextTwelveFont
        self.title.textColor = UIColor.black
        self.contentView.addSubview(self.title)
        self.title.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.cover.mas_bottom)?.setOffset(5.0)
            make?.left.mas_equalTo()(self.contentView.mas_left)?.setOffset((5.0))
            make?.size.setSizeOffset(CGSize(width:(KScreenWith-20)/2,height:14.0))
        }
    }
    
}
class CoverImage: UIImageView {
  
//       var eyeImage = UIImageView()
//       var countLabel = UILabel()
       var titleLabel = UILabel()
       var headImage = UIImageView()
       var countButton = UIButton()
    
    
    func initImageView(){
        
//        self.eyeImage.image = UIImage.init(named: "close_view_persons")
//        self.addSubview(self.eyeImage)
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        
        
        self.headImage.image = UIImage.init(named: "Img_user")
        self.addSubview(self.headImage)
        
//        self.countLabel=UILabel.init()
//        self.countLabel.text = "2.4万"
//        self.countLabel.font = TextEightFont
//        self.countLabel.textColor = UIColor.white
//        self.addSubview(self.countLabel)
        
        self.countButton.setTitle("2.9万", for: UIControlState.normal)
        self.countButton.titleLabel?.font = TextEightFont
        self.countButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.countButton.setImage(UIImage.init(named: "close_view_persons"), for: UIControlState.normal)
        self.countButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0)
        self.countButton.backgroundColor = RGB(0, 0, 0)
        self.countButton.isUserInteractionEnabled = false
//        self.countButton .setBackgroundImage(UIImage.init(named: "dyla_mute_keyword_setting_edit_clear"), for: UIControlState.normal)
        self.countButton.alpha = 0.4
        self.addSubview(self.countButton)
        
        self.titleLabel.text = "斗鱼、小可"
        self.titleLabel.font = TextTenFont
        self.titleLabel.textColor = UIColor.white
        self.addSubview(self.titleLabel)
        
//        let image = UIImage(named:"close_view_persons")
        let image1 = UIImage(named:"Img_user")
        
        
        self.countButton.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.mas_top)?.setOffset(0)
            make?.right.mas_equalTo()(self.mas_right)?.setOffset(0)
            make?.size.setSizeOffset(CGSize(width:50,height:15))
        }
//        self.countButton.mas_makeConstraints { (make) in
//            make?.right.mas_equalTo()(self.countLabel.mas_left)?.setOffset(-5)
//            make?.top.mas_equalTo()(self.mas_top)?.setOffset(5.0)
//            make?.size.setSizeOffset((image?.size)!)
//        }
        self.headImage.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(self.mas_left)?.setOffset(5.0)
            make?.bottom.mas_equalTo()(self.mas_bottom)?.setOffset(-2.0)
            make?.size.setSizeOffset((image1?.size)!)
        }
        self.titleLabel.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(self.headImage.mas_right)?.setOffset(0)
            make?.bottom.mas_equalTo()(self.mas_bottom)?.setOffset(-2.0)
            make?.size.setSizeOffset(CGSize(width:(KScreenWith - 20)/2,height:14))
        }
    }
    
    
    
//    lazy var eyeImage: UIImageView = {
//        let eyeImage = UIImageView.init(image: UIImage.init(named: "video_viewer"))
//        self.addSubview(eyeImage)
//        return eyeImage
//    }()
}

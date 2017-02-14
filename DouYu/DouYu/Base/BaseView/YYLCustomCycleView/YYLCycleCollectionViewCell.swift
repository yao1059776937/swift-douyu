//
//  YYLCycleCollectionViewCell.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/17.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLCycleCollectionViewCell: UICollectionViewCell {
    
//    var ImageName:String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.Images.mas_makeConstraints { (make) in
            make?.edges.mas_equalTo()(self.contentView)?.setOffset(0)
        }
    }

    var ImageName:String? {
        didSet {
            // 0==count 占位图
            if ImageName!.lengthOfBytes(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) == 0 || ImageName == nil {
                self.Images.image = UIImage(named:"默认banner图")
            }else{
                // 根据ImageName，来判断是网络图片还是本地图
                if (ImageName?.hasPrefix("http"))! || (ImageName?.hasPrefix("https"))! {
                    self.Images.sd_setImage(with: URL.init(string: ImageName!), placeholderImage: UIImage(named:"默认banner图"))
                }else{
                    if let image = UIImage.init(named:ImageName!) {
                            self.Images.image = image
                    }else{
                  self.Images.image = UIImage(named:"默认banner图")
                }
                }
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
   private lazy var Images:UIImageView = {
    let Images = UIImageView()
   self.contentView.addSubview(Images)
    return Images
    }()
}

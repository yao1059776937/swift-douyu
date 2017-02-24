//
//  YYLCommentCollectionViewCell.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/2/15.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLCommentCollectionViewCell: UICollectionViewCell {
    

//    var limitCount:NSInteger = 2

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        ConfigUI()
 
    }
    override var isSelected: Bool{
        didSet{
            if  isSelected == true {
                self.selectImage.image = UIImage(named:"column_selected")
            }else{
                self.selectImage.image = UIImage(named:"")
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    //MARK:SETTER
        //显示的个数 默认显示2个
    var limitCount: NSInteger=2 {
        didSet {
            
        }
    }
    var picUrl: String = ""{
        didSet {
                self.gameCoverImage.sd_setImage(with: URL(string:picCover+picUrl), placeholderImage: UIImage.init(named: "默认banner图"))
        }
    }
    var localPicUrl: String = ""{
          didSet {
            self.gameCoverImage.image = UIImage(named:localPicUrl)
        }
 }
    var Name: String = ""{
        didSet {
          self.gameName.text = Name
        }
    }
    var rightLineImage: String = ""{
        didSet {
            self.rightLine.backgroundColor = UIColor.white
            self.rightLine.image = UIImage(named:rightLineImage)
        }
    }
    
    var bottomLineImage: String = ""{
        didSet {
            self.bottomLine.backgroundColor = UIColor.white
            self.bottomLine.image = UIImage(named:bottomLineImage)
        }
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
        
        rightLine.mas_makeConstraints { (make) in
            make?.top.right().bottom().mas_equalTo()(self.contentView)?.setOffset(0)
            make?.width.setOffset(1.0)
        }
        bottomLine.mas_makeConstraints { (make) in
            make?.left.right().bottom().mas_equalTo()(self.contentView)?.setOffset(0)
            make?.height.setOffset(1.0)
        }
        let image = UIImage(named:"column_selected")
        self.selectImage.mas_makeConstraints { (make) in
        make?.right.bottom().mas_equalTo()(self.contentView)?.setOffset(0)
        make?.size.setSizeOffset(CGSize(width:(image?.size.width)!,height:(image?.size.height)!))
        }

    }
    //下边线条
    fileprivate lazy var rightLine: UIImageView = {
        let rightLine = UIImageView()
       rightLine.layer.masksToBounds = true
        rightLine.backgroundColor = UIColor.init(hexString: "cccccc")
        self.contentView.addSubview(rightLine)
        return rightLine
    }()
    //右边线条
    fileprivate lazy var bottomLine: UIImageView = {
        let bottomLine = UIImageView()
       bottomLine.layer.masksToBounds = true
        bottomLine.backgroundColor = UIColor.init(hexString: "cccccc")
        self.contentView.addSubview(bottomLine)
        return bottomLine
    }()
   private lazy var gameCoverImage: UIImageView = {
        let image = UIImageView()
//        image.image = UIImage(named:"默认banner图")
        image.layer.cornerRadius = 20.0
        image.layer.masksToBounds = true
        self.contentView.addSubview(image)
        return image
    }()
   private lazy var gameName: UILabel = {
        let gameName = UILabel()
//        gameName.text = "英雄联盟"
        gameName.font = TextTwelveFont
        gameName.textAlignment = NSTextAlignment.center
        gameName.textColor = UIColor.black
        self.contentView.addSubview(gameName)
        return gameName
    }()
    private lazy var selectImage: UIImageView = {
        let selectImage = UIImageView()
        self.contentView.addSubview(selectImage)
        return selectImage
    }()
}

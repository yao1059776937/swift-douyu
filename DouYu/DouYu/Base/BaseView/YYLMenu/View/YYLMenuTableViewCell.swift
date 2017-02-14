//
//  YYLMenuTableViewCell.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/20.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLMenuTableViewCell: UITableViewCell {

    private let livingImage = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        MasnoaryUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    private func MasnoaryUI(){
    
    self.coverImage.mas_makeConstraints { (make) in
        make?.top.mas_equalTo()(self.mas_top)?.setOffset(10.0)
        make?.left.mas_equalTo()(self.mas_left)?.setOffset(10.0)
        make?.bottom.mas_equalTo()(self.mas_bottom)?.setOffset(-10.0)
//        make?.height.setOffset(80.0)
        make?.width.setOffset(130.0)
        }
     self.coverImage.addSubview(self.livingImage)
        let living:UIImage = UIImage(named:"attention_living")!
      self.livingImage.image = living
      self.livingImage.mas_makeConstraints { (make) in
            make?.left.top().mas_equalTo()(self.coverImage)?.setOffset((0))
            make?.size.setSizeOffset(living.size)
        }
        self.titleLabel.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.contentView.mas_top)?.setOffset(10.0)
            make?.left.mas_equalTo()(self.coverImage.mas_right)?.setOffset(10.0)
            make?.size.setSizeOffset(CGSize(width:KScreenWith - self.coverImage.rightX-10,height:40.0))
        }
        self.timeLabel.mas_makeConstraints { (make) in
            make?.right.mas_equalTo()(self.mas_right)?.setOffset(-10.0)
            make?.bottom.mas_equalTo()(self.mas_bottom)?.setOffset(-10.0)
            make?.size.setSizeOffset(CGSize(width:60,height:20.0))
        }
        self.useButton.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(self.coverImage.mas_right)?.setOffset(10.0)
            make?.right.mas_equalTo()(self.timeLabel.mas_left)?.setOffset(0)
            make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.setOffset(-10.0)
           make?.height.setOffset(20.0)
        }
        
    }
    private lazy var coverImage: UIImageView = {
        let coverImage = UIImageView()
        coverImage.image = UIImage(named:"默认banner图")
        coverImage.layer.cornerRadius = 4.0
        coverImage.layer.masksToBounds = true
        self.addSubview(coverImage)
        return coverImage
    }()
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = TextFourTeenFont
        titleLabel.text = "饼干：世界第一de提莫打野!sssssssssssssssssssssssssss"
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.init(hexString: "000000")
        self.addSubview(titleLabel)
        return titleLabel
    }()
    private lazy var useButton: UIButton = {
        let useButton = UIButton()
        useButton.setImage(UIImage(named:"home_live_player_normal"), for: UIControlState.normal)
        useButton.setTitle("饼干狂魔MasterB", for: UIControlState.normal)
        useButton.titleLabel?.font = TextTwelveFont
        useButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        useButton.setTitleColor(UIColor.init(hexString: "bbbbbb"), for: UIControlState.normal)
        self.addSubview(useButton)
        return useButton
    }()
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = TextTwelveFont
        timeLabel.text = "23小时前"
        timeLabel.textColor = UIColor.init(hexString: "bbbbbb")
        self.addSubview(timeLabel)
        return timeLabel
    }()
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

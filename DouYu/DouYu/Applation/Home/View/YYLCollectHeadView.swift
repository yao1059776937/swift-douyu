//
//  YYLCollectHeadView.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/10.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLCollectHeadView: UIView {

//    var icon = UIImageView()
//    var content = UILabel()
//    var more = UIButton()

    var moreLiving:(()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeCompont()
    }
    func initializeCompont(){
        let iconImage = UIImage(named:"home_header_normal")
        self.icon .mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.mas_top)?.setOffset((self.frame.height - (iconImage?.size.height)!)/2)
            make?.left.mas_equalTo()(self.mas_left)?.setOffset(3.0);
            make?.size.setSizeOffset((iconImage?.size)!)
        }
        self.content .mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.mas_top)?.setOffset((self.frame.height - 14)/2)
            make?.left.mas_equalTo()(self.icon.mas_right)?.setOffset(5.0)
            make?.size.setSizeOffset(CGSize(width:100,height:14.0))
        }
        self.more .mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.mas_top)?.setOffset((self.frame.height - 14)/2)
            make?.right.mas_equalTo()(self.mas_right)?.setOffset(-3.0)
            make?.size.setSizeOffset(CGSize(width:100,height:14.0))
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //赖加载

    private lazy var icon : UIImageView = {
    let icon = UIImageView.init(image: UIImage(named:"home_header_normal"))
    self.addSubview(icon)
    return icon
    }()
    private lazy var content : UILabel = {
        let content = UILabel()
        content.text = "数码科技"
        content.textColor = UIColor.init(hexString: "000000")
        content.font = TextFourTeenFont
        self.addSubview(content)
        return content
    }()
    private lazy var more : UIButton = {
        let more = UIButton.init(type:UIButtonType.custom)
        more.setTitle("更多", for: UIControlState.normal)
        more.titleLabel?.font = TextFourTeenFont
        more.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -100);
        more.addTarget(self, action:#selector(btnMore), for: UIControlEvents.touchUpInside)
//        more.titleEdgeInsets = UIEdgeInsetsMake(0, -50, <#T##bottom: CGFloat##CGFloat#>, <#T##right: CGFloat##CGFloat#>)
        more.setImage(UIImage(named:"homeMoreIcon"), for: UIControlState.normal)
        more.setTitleColor(UIColor.init(hexString: "dddddd"), for: UIControlState.normal)
        self.addSubview(more)
        return more
    }()
    @objc private func btnMore(){
        if self.moreLiving != nil {
            self.moreLiving!()
        }
    }
}

//
//  DouYuTV.swift
//  douyuTV
//
//  Created by mac--yaoyinglong on 16/11/1.
//  Copyright © 2016年 mac--yyl. All rights reserved.
//

import UIKit
import Masonry
import SDWebImage
import RxSwift
import RxCocoa
import TTReflect

//let weakSelf = __weak typeof(self) weakSelf
let  KScreenWith = UIScreen .main.bounds.size.width
let  KScreenHight = UIScreen.main.bounds.size.height

//请求前面的统一参数
let UnifyUrl = "https://capi.douyucdn.cn/api/v1/"
let picCover = "https://staticlive.douyucdn.cn/upload/game_cate/" //封面图片统一参数
//请求method
let GetColumnList = "getColumnList"
let GetColumnDetail = "getColumnDetail"
let GetColumnRoom = "getColumnRoom"
let Live = "live"
let Qie = "qie"
let ShortName = "shortName"
var publicParams:[String:Any] = [limitPage:KlimitData,client_sys:iosPlatform,offsetPage:"0"]
//普通参数
let client_sys = "client_sys"
let iosPlatform = "ios"
//翻页参数
let offsetPage = "offset"

//每次请求获取的数据条数
//key
let limitPage = "limit"
let KlimitData = "20"

//获取当前系统版本
let _ios8_0_  = ((UIDevice.current.systemVersion as NSString).floatValue >= 8.0)
let _ios7_0_  = ((UIDevice.current.systemVersion as NSString).floatValue >= 7.0)
let _ios6_1_  = ((UIDevice.current.systemVersion as NSString).floatValue >= 6.1)
let _ios6_0_  = ((UIDevice.current.systemVersion as NSString).floatValue >= 6.0)
let _ios5_1_  = ((UIDevice.current.systemVersion as NSString).floatValue >= 5.1)
let _ios5_0_  = ((UIDevice.current.systemVersion as NSString).floatValue >= 5.0)

//字体
let TextSixTeenFont = UIFont.systemFont(ofSize: 16.0)
let TextFourTeenFont = UIFont.systemFont(ofSize: 14.0)
let TextTwelveFont = UIFont.systemFont(ofSize: 12.0)
let TextEleven = UIFont.systemFont(ofSize: 10.0)
let TextTenFont = UIFont.systemFont(ofSize: 10.0)
let TextEightFont = UIFont.systemFont(ofSize: 8.0)

let horrorImage = "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1484818065&di=fbfe10f51322f0a79f4bf6ca13c0e547&src=http://img.sc115.com/uploads/sc/jpgs/04/xpic8850_sc115.com.jpg"

func RGB(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat) ->UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}
//获取字符串的宽高
func getTextRectSize(text:String,font:UIFont,size:CGSize) -> CGRect {
    
    let attributes = [NSFontAttributeName: font]
    
    let option = NSStringDrawingOptions.usesLineFragmentOrigin
    
    let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
    
    return rect;
}

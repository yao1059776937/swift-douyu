//
//  YYLLivingViewModel.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/2/17.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit
import AFNetworking
import RxSwift

class YYLLivingViewModel: NSObject {

    //获取导航栏上标题请求结果
        var columSuccess:((NSArray)->())?
        var columFail:((Error)->())?
    //获取导航栏上第一个标题"常用"详情结果
        var columDetailSuccess:((NSArray)->())?
        var columDetailFail:((Error)->())?
    //获取导航栏上其他标题详情结果
        var columAllSuccess:((NSArray)->())?
        var columAllFail:((Error)->())?
   //获取导航栏标题请求
    func getColumnList(method:String,parameters : [String : Any]){
        YYLHttpRequest.shareInstance.request(requestType: .Get, method:method, parameters: parameters, succeed: { (response) in
            if self.columSuccess != nil{
            self.columSuccess!(response?["data"] as! NSArray)
            }
        }) { (error) in
            if self.columFail != nil{
                self.columFail!(error!)
            }
        }
    }
    //获取导航栏上第一个标题"常用"详情
    func getColumnDetail(method:String,parameters : [String : Any]){
        YYLHttpRequest.shareInstance.request(requestType: .Get, method:method, parameters: parameters, succeed: { (response) in
            if self.columDetailSuccess != nil{
                self.columDetailSuccess!(response?["data"] as! NSArray)
            }
        }) { (error) in
            if self.columDetailFail != nil{
                self.columDetailFail!(error!)
            }
        }
    }
    //获取导航栏上其他标题详情
    func getColumnAll(method:String,parameters : [String : Any]){
        YYLHttpRequest.shareInstance.request(requestType: .Get, method:method, parameters: parameters, succeed: { (response) in
            if self.columAllSuccess != nil{
                self.columAllSuccess!(response?["data"] as! NSArray)
            }
        }) { (error) in
            if self.columAllFail != nil{
                self.columAllFail!(error!)
            }
        }
    }
}

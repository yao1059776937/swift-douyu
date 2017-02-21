//
//  YYLHttpRequest.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/2/17.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import Foundation

import AFNetworking

enum YYLRequestType {
    case Get
    case Post
}

class YYLHttpRequest: AFHTTPSessionManager {
    
    static let shareInstance : YYLHttpRequest = {
        let toolInstance = YYLHttpRequest()
        toolInstance.responseSerializer.acceptableContentTypes?.insert("text/html")
        return toolInstance
    }()
    
    // 将成功和失败的回调写在一个逃逸闭包中
    func request(requestType : YYLRequestType, url : String, parameters : [String : Any], resultBlock : @escaping([String : Any]?, Error?) -> ()) {
        
        // 成功闭包
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
            resultBlock(responseObj as? [String : Any], nil)
        }
        
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            resultBlock(nil, error)
        }
        
        // Get 请求
        if requestType == .Get {
            get(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        // Post 请求
        if requestType == .Post {
            post(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
    }
    
    // 将成功和失败的回调分别写在两个逃逸闭包中
    func request(requestType : YYLRequestType,method:String, parameters : [String : Any], succeed : @escaping([String : Any]?) -> (), failure : @escaping(Error?) -> ()) {
       let url = UnifyUrl+method
        // 成功闭包
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
            succeed(responseObj as? [String : Any])
        }
        
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
        
        // Get 请求
        if requestType == .Get {
            get(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        // Post 请求
        if requestType == .Post {
            post(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
    }
}


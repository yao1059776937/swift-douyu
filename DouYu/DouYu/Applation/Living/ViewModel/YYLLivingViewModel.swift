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


//    var columSuccess:(([String : Any]?)->())?
        var columSuccess:((NSArray)->())?
    var columFail:((Error)->())?
    
//    let observable = { (columnListResult: NSArray) -> Observable<NSArray> in
//        return Observable.create { observer in
//            observer.on(.next(columnListResult))
//            observer.on(.completed)
//            //            return NopDisposable.instance
//            return Disposable.self as! Disposable
//        }
//    }
    
    
    func getColumnList(parameters : [String : Any]){
        YYLHttpRequest.shareInstance.request(requestType: .Get, url: "https://capi.douyucdn.cn/api/v1/getColumnList", parameters: parameters, succeed: { (response) in
            if self.columSuccess != nil{
            self.columSuccess!(response?["data"] as! NSArray)
            }
        }) { (error) in
            if self.columFail != nil{
                self.columFail!(error!)
            }
        }
    }
//    public var rx_text: Observable<String> {
//        return defer { [weak self] in
//            let text = self?.text ?? ""
//            
//            return self?.rx_delegate.observe("searchBar:textDidChange:") ?? empty()
//                .map { a in // a 包含了searchbar:textDidChange:的参数，第一个是Searchbar,第二个是值
//                    return a[1] as? String ?? ""
//                }
//                .startWith(text)
//        }
}

//
//  YYLHomeClassfiyViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/5.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLHomeClassfiyViewController: YYLViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    private var bannerDemo = LLCycleScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 网络图，本地图混合
        let imagesURLStrings = [
            "https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=9aa9d217464a20a425133495f13bf347/8cb1cb134954092304ebe97b9b58d109b3de4931.jpg",
            "https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=9aa9d217464a20a425133495f13bf347/8cb1cb134954092304ebe97b9b58d109b3de4931.jpg",
            "https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=9aa9d217464a20a425133495f13bf347/8cb1cb134954092304ebe97b9b58d109b3de4931.jpg",
            "https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=9aa9d217464a20a425133495f13bf347/8cb1cb134954092304ebe97b9b58d109b3de4931.jpg",
            "默认banner图",
            "https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=9aa9d217464a20a425133495f13bf347/8cb1cb134954092304ebe97b9b58d109b3de4931.jpg",
            ];
        // Demo--点击回调
        self.bannerDemo = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect.init(x: 0, y: 0, width: KScreenWith, height: 150), imageURLPaths: imagesURLStrings, titles:[], didSelectItemAtIndex: { index in
            print("当前点击图片的位置为:\(index)")
        })
        self.bannerDemo.placeHolderImage = UIImage(named:"默认banner图")
        self.bannerDemo.customPageControlStyle = .custom
        self.bannerDemo.customPageControlTintColor = UIColor.init(hexString: "eeeeee")!
        self.bannerDemo.customPageControlInActiveTintColor = RGB(235, 97, 7)
        self.bannerDemo.autoScrollTimeInterval = 3.0
//        self.view.addSubview(bannerDemo)
        self.view.addSubview(self.collect)
        
        //自定义pageController
        let pageImage = UIImageView.init(frame: CGRect(x:0,y:0,width:12,height:6))
        pageImage.backgroundColor = RGB(235, 97, 7)
        pageImage.layer.cornerRadius = 3.0
        pageImage.layer.masksToBounds = true
        
        let page = YYLPageCountView.init(frame: CGRect(x:(KScreenWith-100)/2,y:140,width:100,height:6), pageCount:imagesURLStrings.count , firstCountImageView: pageImage)
//        page.backgroundColor = UIColor.green
        self.bannerDemo.addSubview(page)
        self.bannerDemo.customPage = page
        
    }
//MARK: --UICollectionDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collect.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:KScreenWith/2-1,height:120)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0{
        return CGSize(width:KScreenWith,height:190)
        }else{
        return CGSize(width:KScreenWith,height:40.0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collect.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "head", for: indexPath)
//        if kind == UICollectionElementKindSectionHeader  {
//        let headView = collect.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "head", for: indexPath)
        if indexPath.section == 0 {
            headView.backgroundColor = UIColor.init(hexString: "f7f7f7")
            let rect = CGRect(x:0,y:160,width:KScreenWith,height:30)
            let contentView = YYLCollectHeadView.init(frame:rect)
            contentView.backgroundColor = UIColor.init(hexString: "ffffff")
            headView.addSubview(contentView)
            headView.addSubview(self.bannerDemo)
        }else{
            headView.backgroundColor = UIColor.init(hexString: "f7f7f7")
            let rect = CGRect(x:0,y:10,width:KScreenWith,height:30)
            let contentView = YYLCollectHeadView.init(frame:rect)
            contentView.backgroundColor = UIColor.init(hexString: "ffffff")
            headView.addSubview(contentView)
        }

        return headView
//        }
//        return UIView() as! UICollectionReusableView
    }
    //赖加载collect
    private lazy var collect: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let collect = UICollectionView.init(frame:CGRect(x:0,y:0,width:KScreenWith,height:KScreenHight - 49 - 64-38), collectionViewLayout: layout)
        collect.register(YYLHomeCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        collect.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "head")
        collect.backgroundColor = UIColor.white
        collect.delegate = self
        collect.dataSource = self
        return collect
    }()

}

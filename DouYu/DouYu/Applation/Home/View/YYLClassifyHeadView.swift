//
//  YYLClassifyHeadView.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/10.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLClassifyHeadView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    private var perCount:NSInteger = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let view = UIView.init(frame:CGRect(x:0 ,y:130,width:KScreenWith,height:30.0))
        view.backgroundColor = UIColor.white
        view.addSubview(self.page)
        self.addSubview(view)
        
        self.addSubview(self.collect)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private  lazy var page:YYLPageCountView = {
        //自定义pageController
        let pageImage = UIImageView.init(frame: CGRect(x:0,y:0,width:6,height:6))
        pageImage.backgroundColor = RGB(235, 97, 7)
        pageImage.layer.cornerRadius = 3.0
        pageImage.layer.masksToBounds = true
        
        let page = YYLPageCountView.init(frame: CGRect(x:0,y:10,width:KScreenWith,height:6), pageCount:2 , firstCountImageView: pageImage)
        page.backgroundColor = UIColor.white
        
        return page
    }()
    public var imageArray: NSArray?{
        didSet{
            
        }
    }
//MARK:UICollectViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = self.collect.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:KScreenWith/4,height:60)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    //赖加载collect
    private lazy var collect: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let collect = UICollectionView.init(frame:CGRect(x:0,y:0,width:KScreenWith,height:130), collectionViewLayout: layout)
        collect.showsHorizontalScrollIndicator = false
        collect.bounces = false
        collect.isPagingEnabled = true
        collect.register(YYLClassifyCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell2")
        collect.backgroundColor = UIColor.white
        collect.delegate = self
        collect.dataSource = self
        return collect
    }()

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let endCount = NSInteger(scrollView.contentOffset.x/KScreenWith)
        print("%ld",endCount)
        self.page.exchangeCount(perCount, endCount)
        perCount = endCount
    }
}

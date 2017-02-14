//
//  YYLCustomCycleView.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/17.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLCustomCycleView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    private var ImagesArray : NSMutableArray
    // 计时器
    fileprivate var timer: Timer?
    private var startIndex = 0
    private var endIndex = 1
    private var currentIndex = 0
    
    public init(frame: CGRect,_ ImagesArray:NSArray) {
        self.ImagesArray = NSMutableArray.init(array: ImagesArray)
        self.ImagesArray.insert(ImagesArray.lastObject as! String, at: 0)
        self.ImagesArray.insert(ImagesArray.firstObject as! String, at:self.ImagesArray.count)
        super.init(frame:frame)
        self.frame = frame
        self.addSubview(self.collect)
        self.addSubview(self.page)
        self.bringSubview(toFront: self.page)
        self.setupTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Timer
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: autoScrollTimeInterval as TimeInterval, target: self, selector: #selector(automaticScroll), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    func invalidateTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    // MARK: 控制参数
    // 是否自动滚动，默认true
    @IBInspectable open var autoScroll: Bool? = true {
        didSet {
            invalidateTimer()
            if autoScroll! {
                setupTimer()
            }
        }
    }
    // 滚动间隔时间,默认2s
    @IBInspectable open var autoScrollTimeInterval: Double = 2.0 {
        didSet {
            autoScroll = true
        }
    }

   @objc fileprivate func automaticScroll() {
        
        if self.ImagesArray.count == 0 {return}

            self.currentIndex = NSInteger(self.collect.contentOffset.x/KScreenWith)
            if currentIndex == self.ImagesArray.count-1 {
                self.collect.contentOffset.x = KScreenWith
                self.timer?.fire()
            }else{
             self.collect.scrollToItem(at:IndexPath.init(item: self.currentIndex+1, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
                if currentIndex != self.ImagesArray.count-2{
                self.page.exchangeCount(self.currentIndex-1, self.currentIndex)
                self.startIndex = self.currentIndex
                }else{
                self.page.exchangeCount(self.ImagesArray.count-3, 0)
                self.startIndex = 0
                }
          }

    }
    
    //MARK: --UICollectionDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ImagesArray.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//         var cell = YYLCycleCollectionViewCell()
        
       let cell = self.collect.dequeueReusableCell(withReuseIdentifier: "cycle", for: indexPath) as! YYLCycleCollectionViewCell
        cell.ImageName = self.ImagesArray[indexPath.row] as? String
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:KScreenWith,height:self.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }
    //赖加载collect
    private lazy var collect: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collect = UICollectionView.init(frame:CGRect(x:0,y:0,width:KScreenWith,height:self.height), collectionViewLayout: layout)
        collect.bounces = false
        collect.showsHorizontalScrollIndicator = false
        collect.register(YYLCycleCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cycle")
        collect.contentOffset.x = KScreenWith
        collect.backgroundColor = UIColor.white
        collect.isPagingEnabled = true
        collect.delegate = self
        collect.dataSource = self
        return collect
    }()
    private  lazy var page:YYLPageCountView = {
        //自定义pageController
        let pageImage = UIImageView.init(frame: CGRect(x:0,y:0,width:12,height:6))
        pageImage.backgroundColor = RGB(235, 97, 7)
        pageImage.layer.cornerRadius = 3.0
        pageImage.layer.masksToBounds = true
        
        let page = YYLPageCountView.init(frame: CGRect(x:0,y:self.height-10,width:KScreenWith,height:6), pageCount:self.ImagesArray.count-2, firstCountImageView: pageImage)
        page.backgroundColor = UIColor.clear
        
        return page
    }()
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if autoScroll!{
        invalidateTimer()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if autoScroll!{
        setupTimer()
        }
        
        self.endIndex = NSInteger(scrollView.contentOffset.x/KScreenWith) - 1
        
        if NSInteger(scrollView.contentOffset.x/KScreenWith) == 0 {
            scrollView.contentOffset.x = KScreenWith * CGFloat(self.ImagesArray.count - 2)
            self.endIndex = self.ImagesArray.count - 3
        }
        if NSInteger(scrollView.contentOffset.x/KScreenWith) == self.ImagesArray.count-1 {
            scrollView.contentOffset.x = KScreenWith
            
            self.endIndex = 0
        }
        if self.startIndex != self.endIndex{
            self.page.exchangeCount(self.startIndex, endIndex)
            self.startIndex = self.endIndex
        }
    }

}

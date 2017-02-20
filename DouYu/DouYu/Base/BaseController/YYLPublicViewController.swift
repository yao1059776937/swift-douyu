//
//  YYLPublicViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/2/15.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit
import MJRefresh

class YYLPublicViewController: YYLViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
        var customHeadView = UIView()
        let layout111 = UICollectionViewFlowLayout()
        override func viewDidLoad() {
        super.viewDidLoad()
        
        //                for (var i = 1; i<=60; i++) {
        //                    var image:UIImage = UIImage(named: "dropdown_anim__000\(i)")! as UIImage
        //                    idleImages.addObject(image)
        //                }
        let refreshImages : NSMutableArray = []
        for i in 1..<5 {
            let image:UIImage = UIImage(named: "img_mj_stateRefreshing_0\(i)")!
            refreshImages.add(image)
        }
        //                // 设置普通状态的动画图片
        //                for (var i = 1; i<=3; i++) {
        //                    var image: UIImage = UIImage(named: "dropdown_loading_0\(i)")! as UIImage
        //                    idleImages.addObject(image)
        //                }
        
        //                //定义动画刷新Header
        let header:MJRefreshGifHeader = MJRefreshGifHeader(refreshingTarget: self, refreshingAction:#selector(refresh))
        header.stateLabel.isHidden = true
        header.lastUpdatedTimeLabel.isHidden = true
        //设置普通状态动画图片
        header.setImages([UIImage(named:"img_mj_stateIdle")!] as [AnyObject], for: MJRefreshState.idle)
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        header.insertSubview(imageView, at: 0)
        
        //设置下拉操作时动画图片
        header.setImages([UIImage(named:"img_mj_statePulling")!] as [AnyObject], for: MJRefreshState.pulling)
        //                //设置正在刷新时动画图片
        header.setImages(refreshImages as [AnyObject],duration: 2.0, for:MJRefreshState.refreshing)
        self.collect.mj_header = header
        self.view.addSubview(self.collect)
    }
    //MARK: --UICollectionDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collect.dequeueReusableCell(withReuseIdentifier: "livingCell", for: indexPath)
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
    
    //是否需要标签筛选视图
    //MARK:SETTER
    var isFilterView: Bool = false {
        didSet {
        self.view.addSubview(self.headView)
        self.collect.y = 40.0
        self.collect.height = KScreenHight - 64-49-40.0
        }
    }
    //赖加载collect
    private  lazy var headView: YYLLivingHeadView = {
        let headView = YYLLivingHeadView.init(frame: CGRect(x:0 ,y:0,width:KScreenWith,height:40.0))
        
        weak var weakself = self
        headView.clickTagButton = {
            weakself?.AllTagView.isHidden = false
            UIApplication.shared.keyWindow?.addSubview((weakself?.AllTagView)!)
            weakself?.view.bringSubview(toFront:(weakself?.AllTagView)!)
        }
        
        headView.tagTitleArray =  ["全部","妹纸主播","荣耀上单","野区霸主","全部","中路杀神","最强AD","神级辅助","赛事直播"]
        //              headView.tagTitleArray =  ["全部","妹纸主播","野区霸主","全部","中路杀神"]
        headView.imageTitle = "three_column_view_open"
        return headView
    }()
     lazy var AllTagView: YYLLivingShowAllView = {
        let AllTagView = YYLLivingShowAllView.init(frame: CGRect(x:0 ,y:64,width:KScreenWith,height:KScreenHight-64))
//        weak var weakself = self
//        AllTagView.clickTagBlock = {(select:NSInteger) in Void()
//            weakself?.headView.perSelete = select
//        }
//        AllTagView.showArray = ["全部","妹纸主播","荣耀上单","野区霸主","全部","中路杀神","最强AD","神级辅助","赛事直播"]
        //                 AllTagView.showArray = ["全部","妹纸主播","野区霸主","全部","中路杀神"]
        self.view.addSubview(AllTagView)
        return AllTagView
    }()
    private lazy var collect: YYLCollectionView = {
        
        let collect = YYLCollectionView.init(frame:CGRect(x:0,y:0,width:KScreenWith,height:KScreenHight - 64-49), collectionViewLayout: self.layout111)
//        collect.bounces = true
        collect.register(YYLHomeCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "livingCell")
        collect.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "living")
        collect.backgroundColor = UIColor.init(hexString: "f7f7f7")
        collect.delegate = self
        collect.dataSource = self
        return collect
    }()
    func refresh(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0) {
            self.collect.mj_header.endRefreshing()
        }
    }
    deinit {
        
    }

}

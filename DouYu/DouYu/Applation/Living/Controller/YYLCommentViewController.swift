//
//  YYLCommentViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/2/15.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit
import MJRefresh

class YYLCommentViewController: YYLViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var customHeadView = UIView()
    let layout111 = UICollectionViewFlowLayout()
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        let cell = self.collect.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:KScreenWith/2,height:120)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }

    //赖加载collect
    private lazy var collect: YYLCollectionView = {
        
        let collect = YYLCollectionView.init(frame:CGRect(x:0,y:0,width:KScreenWith,height:KScreenHight - 64-49), collectionViewLayout: self.layout111)
        //        collect.bounces = true
        collect.register(YYLCommentCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "CommentCell")
//        collect.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "living")
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

//
//  YYLCommentViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/2/15.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit
import MJRefresh
import TTReflect

class YYLCommentViewController: YYLViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var customHeadView = UIView()
    //一行显示多少个
    private var broadcast_limit:NSInteger = 2
    
    private var dataSouceArray:NSMutableArray = []
    
    let layout111 = UICollectionViewFlowLayout()
    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshImages : NSMutableArray = []
        for i in 1..<5 {
            let image:UIImage = UIImage(named: "img_mj_stateRefreshing_0\(i)")!
            refreshImages.add(image)
        }

      //定义动画刷新Header
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
        
        self.loadAnimationStart()
        let par = [client_sys:iosPlatform]
       self.columListModel.getColumnDetail(method:GetColumnDetail,parameters:par)
    }

    //MARK: --UICollectionDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSouceArray.count;
//             return 15;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let columDetail = self.dataSouceArray[indexPath.row] as! YYLLivingColumnDetailModel
        
        let cell = self.collect.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as! YYLCommentCollectionViewCell
        cell.picUrl = columDetail.icon_name
        cell.Name = columDetail.tag_name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:KScreenWith/CGFloat(self.broadcast_limit),height:120)
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
        collect.register(YYLCommentCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "CommentCell")
        collect.backgroundColor = UIColor.init(hexString: "f7f7f7")
        collect.delegate = self
        collect.dataSource = self
        return collect
    }()
    lazy var columListModel: YYLLivingViewModel = {
        let columListModel = YYLLivingViewModel()
        weak var myself:YYLCommentViewController? = self
        columListModel.columDetailSuccess = { (response) in Void()
            myself?.loadAnimationStop()
//            myself?.loadAnimationFail()
            for dic in response{
                if (myself?.dataSouceArray.count)! > 14{break}
                let tag = Reflect<YYLLivingColumnDetailModel>.mapObject(json:dic as AnyObject?)
                myself?.broadcast_limit = NSInteger(tag.broadcast_limit)!
                myself?.dataSouceArray.add(tag)
            }
                    myself?.collect.reloadData()
        }
        columListModel.columDetailFail = { (error) in Void()
//            myself?.loadAnimationStop()
                    myself?.loadAnimationFail()
        }
        return columListModel
    }()
    func refresh(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0) {
            self.collect.mj_header.endRefreshing()
        }
    }
    deinit {
        
    }
}

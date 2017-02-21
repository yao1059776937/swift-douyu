//
//  YYLPublicViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/2/15.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit
import MJRefresh
import TTReflect

class YYLPublicViewController: YYLViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
        var customHeadView = UIView()
        let layout111 = UICollectionViewFlowLayout()
       private var dataSouceArray:NSMutableArray = []
      //尾部加载控件
      var foot:MJRefreshAutoNormalFooter?
      //选择的cat_id
      private var catID:String = ""
      //当前的controller是否是"全部"
      private var isAllController:Bool = false
    //当前的controller是否是"体育频道"
     private var isQieController:Bool = false
      //是否是头部刷新
      private var isHeadRefresh = false
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
           
        self.foot = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction:#selector(footRefresh))
        self.foot!.setTitle("正在加载更多数据...", for: .refreshing)
        self.foot!.setTitle("", for: .idle)

        self.collect.mj_footer = self.foot
            
        self.view.addSubview(self.collect)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       }
    //MARK: --UICollectionDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSouceArray.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let allDetail = self.dataSouceArray[indexPath.row] as! YYLLivingCoverModel
        let cell = self.collect.dequeueReusableCell(withReuseIdentifier: "livingCell", for: indexPath) as! YYLHomeCollectionViewCell
        cell.online = allDetail.online
        cell.room_src = allDetail.room_src
        cell.nickname = allDetail.nickname
        cell.room_name = allDetail.room_name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:KScreenWith/2,height:150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 0
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
    //标签不包括全部
    var roomMethod: [String:Any] = [:]{
        didSet {
            if self.dataSouceArray.count != 0 {
                return
            }
           var cat_id:String = ""
            
            //遍历数组获取 cat_id
            for (key,value) in roomMethod {
                if key == "selectIndex" {
                    cat_id = (value) as! String
                    self.catID = cat_id
                }
            }
            roomMethod.removeValue(forKey: "selectIndex")
            self.loadAnimationStart()
            //数据请求
            self.columListModel.getColumnAll(method:GetColumnRoom+"/"+cat_id,parameters:roomMethod)
        }
    }
    //标签“全部”
    var liveMethod: [String:Any] = [:]{
        didSet {
            if self.dataSouceArray.count != 0 {
                return
            }
       self.loadAnimationStart()
        self.isAllController = true
        //数据请求
        self.columListModel.getColumnAll(method:Live,parameters:roomMethod)
        }
    }
    //标签“体育频道”
    var QieMethod: [String:Any] = [:]{
        didSet {
            if self.dataSouceArray.count != 0 {
                return
            }
             self.loadAnimationStart()
        self.isQieController = true
            //数据请求
       self.columListModel.getColumnAll(method:Qie,parameters:QieMethod)
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
        headView.imageTitle = "three_column_view_open"
        return headView
    }()
     lazy var AllTagView: YYLLivingShowAllView = {
        let AllTagView = YYLLivingShowAllView.init(frame: CGRect(x:0 ,y:64,width:KScreenWith,height:KScreenHight-64))

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
    lazy var columListModel: YYLLivingViewModel = {
        let columListModel = YYLLivingViewModel()
        weak var myself = self
        columListModel.columAllSuccess = { (response) in Void()
             myself?.loadAnimationStop()
            myself?.collect.mj_footer.endRefreshing()
            //头部刷新
            if myself?.isHeadRefresh == true{
                myself?.dataSouceArray.removeAllObjects()
                myself?.collect.mj_header.endRefreshing()
                myself?.collect.mj_footer.resetNoMoreData()
                myself?.isHeadRefresh = !(myself?.isHeadRefresh)!
            }
            for dic in response{
                let tag = Reflect<YYLLivingCoverModel>.mapObject(json:dic as AnyObject?)
                myself?.dataSouceArray.add(tag)
            }
            myself?.collect.reloadData()
            //没有更多数据了
            if (myself?.dataSouceArray.count)!-response.count == 0&&response.count<NSInteger(KlimitData)!{
                myself?.foot!.setTitle("", for: .noMoreData)
                myself?.collect.mj_footer.state = .noMoreData
            }else if response.count < NSInteger(KlimitData)! && myself?.dataSouceArray.count != 0{
                myself?.foot!.setTitle("已经全部加载完毕", for: .noMoreData)
                myself?.collect.mj_footer.state = .noMoreData
                return
            }
        }
        columListModel.columAllFail = { (error) in Void()
            myself?.loadAnimationStop()
        }
        return columListModel
    }()
    func refresh(){
        
        self.isHeadRefresh = !self.isHeadRefresh
        if self.isAllController == true {
           self.liveMethod.updateValue("0", forKey:offsetPage)
           self.columListModel.getColumnAll(method:Live,parameters:self.liveMethod)
        }else if self.isQieController == true {
            self.QieMethod.updateValue("0", forKey:offsetPage)
            self.columListModel.getColumnAll(method:Qie,parameters:self.QieMethod)
        }else{
            self.roomMethod.updateValue("0", forKey: offsetPage)
            //数据请求
            self.columListModel.getColumnAll(method:GetColumnRoom+"/"+self.catID,parameters:self.roomMethod)
        }
     }
    func footRefresh(){
        if self.isAllController == true {
            self.liveMethod.updateValue("\(self.dataSouceArray.count)", forKey:offsetPage)
            self.columListModel.getColumnAll(method:Live,parameters:self.liveMethod)
        }else if self.isQieController == true {
            self.QieMethod.updateValue("\(self.dataSouceArray.count)", forKey:offsetPage)
            self.columListModel.getColumnAll(method:Qie,parameters:self.QieMethod)
        }else{
            self.roomMethod.updateValue("\(self.dataSouceArray.count)", forKey: offsetPage)
            //数据请求
            self.columListModel.getColumnAll(method:GetColumnRoom+"/"+self.catID,parameters:self.roomMethod)
        }
    }
    deinit {
        
    }

}

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
    //直播间数据
        private var dataSouceArray:NSMutableArray = []
    //短标题数据
        private var shortNameArray:NSMutableArray = []
        private let semaphore = DispatchSemaphore.init(value: 0)
      //尾部加载控件
      var foot:MJRefreshAutoNormalFooter?
      //选择的cat_id
     private var catID:String = ""
      //当前的controller是否是"全部"
      private var isAllController:Bool = false
    //当前的controller是否是"体育频道"
      private var isQieController:Bool = false
    //当前的controller是否是"短标题频道"
      private var isShortNameController:Bool = false
    //当前的controller的短标题tag_id 避免上啦刷新 下拉加载出现错误
      private var shortTag_id:String = ""
    //当前的controller的上一个短标题tag_id 当当前短标题与上一个短标题不一样时 清空数据源数组
     private var perShortTag_id:String = "-1"
    //记住当前点击的是第几个shortName
    private var currentShortName:NSInteger = 0
      //是否是头部刷新
      private var isHeadRefresh = false
        override func viewDidLoad() {
        super.viewDidLoad()
            
       self.view.backgroundColor = UIColor.white
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
        self.view.addSubview(self.headView)
        UIApplication.shared.keyWindow?.addSubview(self.AllTagView)
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
    //是否需要展示短标题栏
    fileprivate func showShortName(isShow:Bool) {
        if  isShow == true {
            self.headView.isHidden = false
            self.collect.y = 40.0
            self.collect.height = KScreenHight - 64-49-40.0
        }else{
            self.headView.isHidden = true
            self.collect.y = 0
            self.collect.height = KScreenHight - 64-49
        }
    }
    //是否需要标签筛选视图
    //MARK:SETTER
    var isFilterView: Bool = false {
        didSet {
        self.collect.y = 40.0
        self.collect.height = KScreenHight - 64-49-40.0
        }
    }
    //标签不包括全部
    var roomMethod: [[String:Any]] = [[:]]{
        didSet {
            if self.dataSouceArray.count != 0 {
                return
            }
           var cat_id:String = ""
            //获取请求直播封面数据 参数
            var RoomMethod:[String:Any] = roomMethod[0]
            
            //遍历数组获取 cat_id
            for (key,value) in RoomMethod {
                if key == "selectIndex" {
                    cat_id = (value) as! String
                    self.catID = cat_id
                }
            }
            RoomMethod.removeValue(forKey: "selectIndex")
            self.loadAnimationStart()
            //队列管理
            let queue1 = DispatchQueue.init(label: "columRoom")
            queue1.async{
            self.columListModel.getColumnAll(Semaphore: self.semaphore,identify:"shortName",method:GetColumnDetail,parameters:self.roomMethod.last!)
                self.semaphore.wait()
                self.columListModel.getColumnAll(Semaphore: self.semaphore,identify: "all",method:GetColumnRoom+"/"+cat_id,parameters:RoomMethod)
                self.semaphore.wait()
                //这里已经是请求全部完成了

            }
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
        self.columListModel.getColumnAll(Semaphore: self.semaphore,identify:"all",method:Live,parameters:liveMethod)
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
       self.columListModel.getColumnAll(Semaphore: self.semaphore,identify:"all",method:Qie,parameters:QieMethod)
        }
    }
    //赖加载collect
    private  lazy var headView: YYLLivingHeadView = {
        let headView = YYLLivingHeadView.init(frame: CGRect(x:0 ,y:0,width:KScreenWith,height:40.0))
        
        weak var weakself = self
        headView.clickTagButton = {
        weakself?.AllTagView.isHidden = false
        weakself?.AllTagView.seleteIndex = (weakself?.currentShortName)!
        weakself?.AllTagView.dataSouceArray = (weakself?.shortNameArray)!
            weakself?.view.bringSubview(toFront:(weakself?.AllTagView)!)
        }
        headView.shortNameClick = { (seleteIndex) in Void()
            weakself?.currentShortName = seleteIndex
            weakself?.loading.y = 40.0
            //"全部"不属于短标题
            if seleteIndex == 0{
            weakself?.isShortNameController = false
            weakself?.refresh()
            }else{
               weakself?.isShortNameController = true
           let shortName = weakself?.shortNameArray[seleteIndex-1] as! YYLLivingColumnDetailModel
            weakself?.shortTag_id = shortName.tag_id
            weakself?.loadAnimationStart()
            weakself?.columListModel.getColumnAll(Semaphore: (weakself?.semaphore)!,identify:"shortNameLiving",method:Live+"/"+shortName.tag_id,parameters:publicParams)
            }
        }
        headView.imageTitle = "three_column_view_open"
        headView.isHidden = true
        return headView
    }()
     lazy var AllTagView: YYLLivingShowAllView = {
        let AllTagView = YYLLivingShowAllView.init(frame: CGRect(x:0 ,y:64,width:KScreenWith,height:KScreenHight-64))
        weak var weakself = self
        AllTagView.selectBlock = { (selectIndex) in Void()
            weakself?.headView.perSelete = selectIndex+1000
            AllTagView.isHidden = true
           weakself?.currentShortName = selectIndex
        }
        AllTagView.isHidden = true
        self.view.addSubview(AllTagView)
        return AllTagView
    }()
    private lazy var collect: YYLCollectionView = {
        
        let collect = YYLCollectionView.init(frame:CGRect(x:0,y:0,width:KScreenWith,height:KScreenHight - 64-49), collectionViewLayout: self.layout111)
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
        columListModel.columAllSuccess = { (response,identify) in Void()

            myself?.collect.mj_footer.endRefreshing()
            //头部刷新
            if myself?.isHeadRefresh == true{
                myself?.dataSouceArray.removeAllObjects()
                myself?.collect.mj_header.endRefreshing()
                myself?.collect.mj_footer.resetNoMoreData()
                myself?.isHeadRefresh = !(myself?.isHeadRefresh)!
            }

                if identify == "shortName"{
                if response.count > 1 {
                    myself?.showShortName(isShow: true)
                    }else{
                    myself?.showShortName(isShow: false)
                    }
                //短标题
                var shortNameArray:Array<String> = ["全部"]
                for dic in response{
                let tag = Reflect<YYLLivingColumnDetailModel>.mapObject(json:dic as AnyObject?)
                shortNameArray.append(tag.tag_name)
                myself?.shortNameArray.add(tag)
                    }
                myself?.headView.tagTitleArray = shortNameArray
                }else if  identify == "shortNameLiving"{
                    if myself?.shortTag_id != myself?.perShortTag_id{
                    myself?.dataSouceArray.removeAllObjects()
                    myself?.perShortTag_id = (myself?.shortTag_id)!
                    myself?.collect.contentOffset=CGPoint(x:0,y:0)
                    }
                for dic in response{
                    let tag = Reflect<YYLLivingCoverModel>.mapObject(json:dic as AnyObject?)
                    myself?.dataSouceArray.add(tag)
                    }
            }else{
              for dic in response{
                let tag = Reflect<YYLLivingCoverModel>.mapObject(json:dic as AnyObject?)
                myself?.dataSouceArray.add(tag)
                    }
                }
           myself?.collect.reloadData()
            myself?.loadAnimationStop()
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
    override func loadReData() {
        self.loadAnimationStart()
  
        if self.isAllController == true {
            //请求的全部直播
            self.liveMethod.updateValue("\(self.dataSouceArray.count)", forKey:offsetPage)
            self.columListModel.getColumnAll(Semaphore: self.semaphore,identify:"",method:Live,parameters:self.liveMethod)
        }else if self.isQieController == true {
            //请求的体育频道
            self.QieMethod.updateValue("\(self.dataSouceArray.count)", forKey:offsetPage)
            self.columListModel.getColumnAll(Semaphore: self.semaphore,identify:"",method:Qie,parameters:self.QieMethod)
        }else{
            //请求的其他标题的频道
            self.roomMethod[0].updateValue("\(self.dataSouceArray.count)", forKey: offsetPage)
            let queue1 = DispatchQueue.init(label: "columRoom")
            queue1.async{
                self.columListModel.getColumnAll(Semaphore: self.semaphore,identify:"shortName",method:GetColumnDetail,parameters:self.roomMethod.last!)
                self.semaphore.wait()
                self.columListModel.getColumnAll(Semaphore: self.semaphore,identify: "all",method:GetColumnRoom+"/"+self.catID,parameters:self.roomMethod[0])
                self.semaphore.wait()
                //这里已经是请求全部完成了
        }
        }
    }
    func refresh(){
        
        self.isHeadRefresh = !self.isHeadRefresh
        if self.isAllController == true {
            if  self.isShortNameController == false {
                self.liveMethod.updateValue("0", forKey:offsetPage)
                self.columListModel.getColumnAll(Semaphore: self.semaphore,identify:"all",method:Live,parameters:self.liveMethod)
            }else{
                self.columListModel.getColumnAll(Semaphore:self.semaphore,identify:"shortNameLiving",method:Live+"/"+self.shortTag_id,parameters:publicParams)
            }

        }else if self.isQieController == true {
                        if  self.isShortNameController == false {
            self.QieMethod.updateValue("0", forKey:offsetPage)
            self.columListModel.getColumnAll(Semaphore:self.semaphore,identify:"all",method:Qie,parameters:self.QieMethod)
                        }else{
        self.columListModel.getColumnAll(Semaphore:self.semaphore,identify:"shortNameLiving",method:Live+"/"+self.shortTag_id,parameters:publicParams)
            }
        }else{
                if  self.isShortNameController == false {
            self.roomMethod[0].updateValue("0", forKey: offsetPage)
            //数据请求
            self.columListModel.getColumnAll(Semaphore: self.semaphore,identify:"all",method:GetColumnRoom+"/"+self.catID,parameters:self.roomMethod[0])
                               }else{
        self.columListModel.getColumnAll(Semaphore:self.semaphore,identify:"shortNameLiving",method:Live+"/"+self.shortTag_id,parameters:publicParams)
            }
        }
     }
    func footRefresh(){
        if self.isAllController == true {
           if  self.isShortNameController == false {
               self.liveMethod.updateValue("\(self.dataSouceArray.count)", forKey:offsetPage)
               self.columListModel.getColumnAll(Semaphore: self.semaphore,identify:"all",method:Live,parameters:self.liveMethod)
            }else{
            publicParams.updateValue("\(self.dataSouceArray.count)", forKey: offsetPage)
            self.columListModel.getColumnAll(Semaphore:self.semaphore,identify:"shortNameLiving",method:Live+"/"+self.shortTag_id,parameters:publicParams)
            }
        }else if self.isQieController == true {
                     if  self.isShortNameController == false {
            self.QieMethod.updateValue("\(self.dataSouceArray.count)", forKey:offsetPage)
            self.columListModel.getColumnAll(Semaphore: self.semaphore,identify:"all",method:Qie,parameters:self.QieMethod)
                     }else{
            publicParams.updateValue("\(self.dataSouceArray.count)", forKey: offsetPage)
            self.columListModel.getColumnAll(Semaphore:self.semaphore,identify:"shortNameLiving",method:Live+"/"+self.shortTag_id,parameters:publicParams)
            }
        }else{
                if  self.isShortNameController == false {
            self.roomMethod[0].updateValue("\(self.dataSouceArray.count)", forKey: offsetPage)
            //数据请求
            self.columListModel.getColumnAll(Semaphore: self.semaphore,identify:"all",method:GetColumnRoom+"/"+self.catID,parameters:self.roomMethod[0])
                               }else{
            publicParams.updateValue("\(self.dataSouceArray.count)", forKey: offsetPage)
            self.columListModel.getColumnAll(Semaphore:self.semaphore,identify:"shortNameLiving",method:Live+"/"+self.shortTag_id,parameters:publicParams)
            }
        }
    }
    deinit {

    }

}

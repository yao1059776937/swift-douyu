//
//  YYLLivingShowAllView.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/2/16.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLLivingShowAllView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    private var perButton=UIButton()

    //选中的回调
    var selectBlock:((NSInteger)->())?
    //创建标签button 当屏幕放不下的时候 到时候自动换行
    private var lineButton=UIButton()
    
    //防止复用cell总是选中
    private var isReCell:Bool = false
    //    //判断是否是换行后的第一个标签
    //    private var isFistTag:Bool=false
    
    //点击标签的回调
    var clickTagBlock : ((NSInteger)->())?
    
    
    //判断是否已经加载过一遍数据了
    private var isLoadData:Bool
    
    override init(frame: CGRect) {
//        self.showArray = []
        self.isLoadData = false
        self.seleteIndex = 0
        lineButton.frame = CGRect(x:10 ,y:10,width:70,height:25)
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(hexString: "292929")?.withAlphaComponent(0.6)
        layoutViews()
        
    }
    
    func layoutViews(){
        self.addSubview(self.collect)
        self.headView.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.mas_top)?.setOffset(0)
            make?.left.right().mas_equalTo()(self)?.setOffset(0)
            make?.height.setOffset(39.9)
        }
        

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let allTouches:NSSet = event!.allTouches! as NSSet //返回与当前接收者有关的所有的触摸对象
        let touch:UITouch = allTouches.anyObject() as! UITouch  //视图中的所有对象
        //只有点击空白处才隐藏
        if NSStringFromClass((touch.view?.classForCoder)!).isEqual(NSStringFromClass((self.headView.classForCoder)))||NSStringFromClass((touch.view?.classForCoder)!).isEqual(NSStringFromClass((self.collect.classForCoder))) {
            self.isHidden = false
        }else{
            self.isHidden = true
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
//        showArray = []
        self.isLoadData = false
        self.seleteIndex = 0
        lineButton.frame = CGRect(x:10 ,y:10,width:70,height:25)
        super.init(coder: aDecoder)
        
    }
    //MARK: --UICollectionDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSouceArray.count+1;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collect.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as!YYLCommentCollectionViewCell
        cell.backgroundColor = UIColor.init(hexString: "f7f7f7")
        if indexPath.row == self.seleteIndex && self.isReCell == false {
            cell.isSelected = true
        }
        if indexPath.row == 0 {
            cell.localPicUrl = "column_all_live"
            cell.Name = "全部"
        }else{
        let columDetail = self.dataSouceArray[indexPath.row-1] as! YYLLivingColumnDetailModel
        cell.picUrl = columDetail.icon_name
        cell.Name = columDetail.tag_name
        }
        cell.rightLineImage = "column_vline"
        cell.bottomLineImage = "column_hline"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = IndexPath.init(row: self.seleteIndex, section: 0)
        let cell = self.collect.cellForItem(at: index) as? YYLCommentCollectionViewCell
        if  cell != nil {
            if indexPath.row != self.seleteIndex {
                self.isReCell = true
                cell!.isSelected = false
            }else{
                cell!.isSelected = true
            }
        }else{
            self.isReCell = true
        }
        if self.selectBlock != nil{
        self.selectBlock!(indexPath.row)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:KScreenWith/3,height:120)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    //MARK: SETTER
    var seleteIndex:NSInteger = 0{
        didSet{
//            perButton.setTitleColor(UIColor.init(hexString: "a1a1a1"), for: UIControlState.normal)
//            perButton.layer.borderColor = UIColor.init(hexString: "aaaaaa")?.cgColor
//            
//            let button = self.viewWithTag(seleteIndex) as! UIButton
//            button.setTitleColor(RGB(235, 97, 7), for: UIControlState.normal)
//            button.layer.borderColor = RGB(235, 97, 7).cgColor
//            perButton = button
//            let indexPath = IndexPath.init(row: seleteIndex, section: 0)
//            let cell = self.collect.cellForItem(at: indexPath) as! YYLCommentCollectionViewCell
//            cell.isSelected = true
            //重置状态
              self.isReCell = false
        }
    }
    var dataSouceArray: NSArray = [] {
        didSet {
      self.collect.reloadData()
            
        }
    }
//    var showArray: NSArray {
//        didSet {
    
//                let lineView = UIView()
//                lineView.frame = CGRect(x:0 ,y:self.showView.height - 0.5,width:KScreenWith,height:0.5)
//                lineView.backgroundColor = UIColor.init(hexString: "bbbbbb")
//                self.showView.addSubview(lineView)
//                
//                lineView.mas_makeConstraints { (make) in
//                    make?.bottom.mas_equalTo()(self.showView.mas_bottom)?.setOffset(0)
//                    make?.left.right().mas_equalTo()(self)?.setOffset(0)
//                    make?.height.setOffset(0.5)
//                }
//                
//                self.headView.mas_makeConstraints { (make) in
//                    make?.top.mas_equalTo()(self.showView.mas_bottom)?.setOffset(0)
//                    make?.left.right().mas_equalTo()(self.animateView)?.setOffset(0)
//                    make?.height.setOffset(40.0)
//                }
                //                animateView.height = lineButton.bottomY+10+40
                //                showView.height = lineButton.bottomY+10
                //                headView.y = showView.bottomY
//            }
//        }
//    }
    
    //MARK: 赖加载
    private lazy var collect: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let collect = UICollectionView.init(frame:CGRect(x:0,y:40.0,width:KScreenWith,height:KScreenHight-64-49-70), collectionViewLayout:layout)
        //        collect.bounces = true
        collect.register(YYLCommentCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "CommentCell")
        //        collect.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "living")
        collect.backgroundColor = UIColor.init(hexString: "f7f7f7")
        collect.delegate = self
        collect.dataSource = self
        return collect
    }()
    private  lazy var headView: YYLLivingHeadView = {
        
        let headView = YYLLivingHeadView()
        weak var weakself = self
        headView.clickTagButton = {
            
            weakself?.isHidden = true
        }
        headView.backgroundColor = UIColor.init(hexString: "f7f7f7")
        headView.tagTitleArray = ["筛选栏目"]
        headView.imageTitle = "column_up_icon"
        self.addSubview(headView)
        return headView
    }()
    //MARK: 点击标签
    @objc fileprivate  func clickTag(_ button:UIButton){
        perButton.setTitleColor(UIColor.init(hexString: "a1a1a1"), for: UIControlState.normal)
        perButton.layer.borderColor = UIColor.init(hexString: "aaaaaa")?.cgColor
        button.setTitleColor(RGB(235, 97, 7), for: UIControlState.normal)
        button.layer.borderColor = RGB(235, 97, 7).cgColor
        perButton = button
        if self.clickTagBlock != nil{
            self.clickTagBlock!(perButton.tag-1666+1000)
        }
        self.isHidden = true
    }

}

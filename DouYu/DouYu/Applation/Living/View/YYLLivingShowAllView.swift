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
    
    //创建标签button 当屏幕放不下的时候 到时候自动换行
    private var lineButton=UIButton()
    
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
//        let lineView = UIView()
//        lineView.frame = CGRect(x:0 ,y:self.headView.height - 0.5,width:KScreenWith,height:0.5)
//        lineView.backgroundColor = UIColor.init(hexString: "bbbbbb")
//        self.addSubview(lineView)
//        
//        lineView.mas_makeConstraints { (make) in
//            make?.bottom.mas_equalTo()(self.showView.mas_bottom)?.setOffset(0)
//            make?.left.right().mas_equalTo()(self)?.setOffset(0)
//            make?.height.setOffset(0.5)
//        }
        

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
        return 40;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collect.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
    //MARK: SETTER
    var seleteIndex:NSInteger{
        didSet{
            perButton.setTitleColor(UIColor.init(hexString: "a1a1a1"), for: UIControlState.normal)
            perButton.layer.borderColor = UIColor.init(hexString: "aaaaaa")?.cgColor
            
            let button = self.viewWithTag(seleteIndex) as! UIButton
            button.setTitleColor(RGB(235, 97, 7), for: UIControlState.normal)
            button.layer.borderColor = RGB(235, 97, 7).cgColor
            perButton = button
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
        headView.tagTitleArray = ["aaaaa"]
        headView.imageTitle = "three_column_view_close"
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

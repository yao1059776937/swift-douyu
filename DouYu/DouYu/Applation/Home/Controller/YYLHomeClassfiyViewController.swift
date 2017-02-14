//
//  YYLHomeClassfiyViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/5.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit
import MJRefresh

class YYLHomeClassfiyViewController: YYLViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //动画隐藏导航栏回调
    var hiddleNavBlock:(()->())?
    //动画显示导航栏回调
    var showNavBlock:(()->())?
    //滑动时的点的坐标
    private var slidePoint:CGFloat = 0.0
    
    let layout111 = UICollectionViewFlowLayout()
    
    
    var customHeadView = UIView()
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
    override func viewWillAppear(_ animated: Bool) {
        if (self.navigationController?.navigationBar.isHidden)! {
            self.hiddleNavBlock!()
            self.collect.height = KScreenHight - 49 - 12-45
        }else{
         self.collect.height = KScreenHight - 49 - 64-45
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
//        if showNavBlock != nil && self.navigationController?.navigationBar.isHidden == true {
//            self.showNavBlock!()
//        }
    }
//MARK: --UICollectionDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = self.collect.dequeueReusableCell(withReuseIdentifier: "recomment", for: indexPath)
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
        return CGSize(width:KScreenWith,height:self.customHeadView.height+40)
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
            let rect = CGRect(x:0,y:self.customHeadView.height+10,width:KScreenWith,height:30)
            let contentView = YYLCollectHeadView.init(frame:rect)
            contentView.backgroundColor = UIColor.init(hexString: "ffffff")
            contentView.moreLiving = {
                self.navigationController?.tabBarController?.selectedIndex = 1
//                let more = YYLLivingClassfiyViewController()
//                more.NavTitle = "英雄联盟"
//                self.navigationController?.pushViewController(more, animated: true)
            }
            headView.addSubview(contentView)
            headView.addSubview(self.customHeadView)
            return headView
        }else{
            for view in headView.subviews {
                view.removeFromSuperview()
            }
            headView.backgroundColor = UIColor.init(hexString: "f7f7f7")
            let rect = CGRect(x:0,y:10,width:KScreenWith,height:30)
            let contentView = YYLCollectHeadView.init(frame:rect)
            contentView.moreLiving = {
                let more = YYLLivingClassfiyViewController()
                more.NavTitle = "英雄联盟"
                self.navigationController?.pushViewController(more, animated: true)
            }
            contentView.backgroundColor = UIColor.init(hexString: "ffffff")
            headView.addSubview(contentView)
            return headView
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0||scrollView.contentOffset.y>=(scrollView.contentSize.height - KScreenHight){

        }else if scrollView.contentOffset.y > self.slidePoint && self.slidePoint>=0.0{
            if hiddleNavBlock != nil && self.navigationController?.navigationBar.isHidden == false {
                self.hiddleNavBlock!()
                self.collect.height = KScreenHight - 49 - 12-45
            }
        }else if scrollView.contentOffset.y < self.slidePoint && self.slidePoint>0.0{
            if showNavBlock != nil && self.navigationController?.navigationBar.isHidden == true {
                self.showNavBlock!()
//                self.collect.height = KScreenHight - 49 - 52-38
            }
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.slidePoint = scrollView.contentOffset.y
    }
    //赖加载collect
    private lazy var collect: YYLCollectionView = {
        
        let collect = YYLCollectionView.init(frame:CGRect(x:0,y:0,width:KScreenWith,height:KScreenHight - 49 - 64-50), collectionViewLayout: self.layout111)
        collect.bounces = true
        collect.register(YYLHomeCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "recomment")
        collect.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "head")
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

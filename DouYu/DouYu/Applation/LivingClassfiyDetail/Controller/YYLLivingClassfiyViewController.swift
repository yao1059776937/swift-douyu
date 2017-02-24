//
//  YYLLivingClassfiyViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/24.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLLivingClassfiyViewController: YYLViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var NavTitle:String = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backItem = true
        self.navigationItem.title = NavTitle
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collect)
        self.view.addSubview(self.headView)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.y = 20
       UIApplication.shared .setStatusBarStyle(.lightContent, animated: true)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
          self.tabBarController?.tabBar.isHidden = false
    }
    //MARK: --UICollectionDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = self.collect.dequeueReusableCell(withReuseIdentifier: "hot", for: indexPath)
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

    //赖加载collect
    private lazy var collect: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let collect = UICollectionView.init(frame:CGRect(x:0,y:40,width:KScreenWith,height:KScreenHight-20-40), collectionViewLayout: layout)
        collect.bounces = true
        collect.register(YYLHomeCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "hot")
        collect.backgroundColor = UIColor.init(hexString: "f7f7f7")
        collect.delegate = self
        collect.dataSource = self

        return collect
    }()
  private  lazy var headView: YYLLivingHeadView = {
        let headView = YYLLivingHeadView.init(frame: CGRect(x:0 ,y:0,width:KScreenWith,height:40.0))
    
    weak var weakself = self
    headView.clickTagButton = {

     weakself?.AllTagView.seleteIndex = headView.perButton.tag-1000 + 1666
//        weakself?.AllTagView.showArray = ["实力偶像","实力偶像","实力偶像","实力偶像","实力偶像","实力偶像","实力偶像","实力偶像","实力AD"]
        weakself?.AllTagView.isHidden = false
        weakself?.view.bringSubview(toFront:(weakself?.AllTagView)!)
    }
          headView.tagTitleArray =  ["全部","妹纸主播","荣耀上单","野区霸主","全部","中路杀神","最强AD","神级辅助","赛事直播"]
//              headView.tagTitleArray =  ["全部","妹纸主播","野区霸主","全部","中路杀神"]
         headView.imageTitle = "three_column_view_open"
        return headView
    }()
    private lazy var AllTagView: YYLShowAllHeadView = {
        let AllTagView = YYLShowAllHeadView.init(frame: CGRect(x:0 ,y:0,width:KScreenWith,height:KScreenHight))
        weak var weakself = self
        AllTagView.clickTagBlock = {(select:NSInteger) in Void()
            weakself?.headView.perSelete = select
        }
         AllTagView.showArray = ["全部","妹纸主播","荣耀上单","野区霸主","全部","中路杀神","最强AD","神级辅助","赛事直播"]
//                 AllTagView.showArray = ["全部","妹纸主播","野区霸主","全部","中路杀神"]
        self.view.addSubview(AllTagView)
        return AllTagView
    }()
}

//
//  YYLHomeClassfiyViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/5.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLHomeClassfiyViewController: YYLViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.view.backgroundColor = RGB(CGFloat(arc4random()%255) , CGFloat(arc4random()%255), CGFloat(arc4random()%255))
        // Do any additional setup after loading the view.
        self.view.addSubview(self.collect)
    }
//MARK: --UICollectionDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collect.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
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
    private lazy var collect: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let collect = UICollectionView.init(frame:CGRect(x:0,y:0,width:KScreenWith,height:KScreenHight - 49 - 64-38), collectionViewLayout: layout)
        collect.register(YYLHomeCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        collect.backgroundColor = UIColor.white
        collect.delegate = self
        collect.dataSource = self
        return collect
    }()

}

//
//  YYLCollectionView.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/19.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLCollectionView: UICollectionView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
        super.touchesBegan(touches, with: event)
    }
}

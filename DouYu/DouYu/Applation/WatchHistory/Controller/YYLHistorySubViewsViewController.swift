//
//  YYLHistorySubViewsViewController.swift
//  DouYu
//
//  Created by mac--yaoyinglong on 17/1/23.
//  Copyright © 2017年 mac--yyl. All rights reserved.
//

import UIKit

class YYLHistorySubViewsViewController: YYLViewController,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuID = "MenuID"
        var cell = self.tableView.dequeueReusableCell(withIdentifier: menuID)
        if cell == nil{
            cell = YYLMenuTableViewCell.init(style: .default, reuseIdentifier: menuID)
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    fileprivate lazy var tableView: UITableView = {
        
        let tableView = UITableView.init(frame: CGRect(x:0,y:0,width:KScreenWith,height:KScreenHight-64-44), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()

}

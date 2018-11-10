//
//  TableViewStastic.swift
//  learn-ios
//
//  Created by lvshutao on 2018/11/2.
//  Copyright © 2018 lvshutao. All rights reserved.
//
/*
 // https://medium.com/@andycherkashyn/everything-you-need-to-know-about-ios-uitableview-79b766bf1a42
 自定义 Cell 的要点
 1. 注册
 2. 在 tableView:cellForRowAtIndexPath 中强制转型
 
 */
import UIKit

class TableViewStastic: UIViewController {
    
    var tableView:UITableView!
    
    // 1. Identify your sections/rows properly
    enum ProfileSections: Int {
        case Profile = 0,
        Info,
        Friends
    }
    
    let dataSources: Array<UITableViewDataSource> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        self.view.addSubview(tableView)
//        tableView.dataSource = self
        
        // 2. Using cell’ classname as Reuse Identifier
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        tableView.register(ProfileInfoCell.self, forCellReuseIdentifier: "\(ProfileInfoCell.self)")
        tableView.register(ProfileContactCell.self, forCellReuseIdentifier: "\(ProfileContactCell.self)")
        
        // 默认的，实际中不需要
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
    }
    
}



extension TableViewStastic: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == ProfileSections.Profile.rawValue {
            return 1
        }
        if section == ProfileSections.Info.rawValue {
            return 3
        }
        if section == ProfileSections.Friends.rawValue {
            return 5
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == ProfileSections.Profile.rawValue {
            return profileInfoCell(tableView:tableView, indexPath:indexPath)
        }
        if indexPath.section == ProfileSections.Info.rawValue {
            return profileInfoCell(tableView:tableView, indexPath:indexPath)
        }
        if indexPath.section == ProfileSections.Friends.rawValue {
            return profileContactCell(tableView:tableView, indexPath:indexPath)
        }
        return tableView.dequeueReusableCell(withIdentifier: "default",for:indexPath)
    }

    // 下面的自定义行都需要强制转义
    func profileInfoCell(tableView:UITableView, indexPath:IndexPath) -> ProfileInfoCell {
        let profileInfoCell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileInfoCell.self)", for: indexPath) as! ProfileInfoCell

        return profileInfoCell
    }

    func profileCell(tableView:UITableView, indexPath:IndexPath) -> ProfileCell {
        let profileCell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileCell.self)", for: indexPath) as! ProfileCell

        return profileCell
    }

    func profileContactCell(tableView:UITableView, indexPath:IndexPath) -> ProfileContactCell {
        let profileContactCell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileContactCell.self)", for: indexPath) as! ProfileContactCell

        return profileContactCell
    }
}

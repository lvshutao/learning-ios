//
//  TabBarSimple.swift
//  learn-ios
//
//  Created by lvshutao on 2018/11/2.
//  Copyright © 2018 lvshutao. All rights reserved.
//
// https://www.jianshu.com/p/2f74a5d93faa
import UIKit

class TabBarSimple: UITabBarController {
    
    override func viewDidLoad() {

        // 子控制器
        let vc01 = UIViewController()
        vc01.tabBarItem.title = "精华"
        vc01.view.backgroundColor = UIColor.yellow
        self.addChild(vc01)
        
        // 设置文字属性、文字的前景色
        vc01.tabBarItem.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 26.0)!,
                NSAttributedString.Key.foregroundColor: UIColor.green
            ],for: .normal)
        
        vc01.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 20.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.red
            ],for: .highlighted)
        // 图片、渲染模式
//        vc01.tabBarItem.image = UIImage(named: "tabBar_icon")
//        vc01.tabBarItem.selectedImage = UIImage(named: "tabBar_click_icon")
        
        
        let vc02 = UIViewController()
        vc02.tabBarItem.title = "新帖"
        vc02.view.backgroundColor = UIColor.red
        self.addChild(vc02)
        
        let vc03 = UIViewController()
        vc03.tabBarItem.title = "关注"
        vc03.view.backgroundColor = UIColor.blue
        self.addChild(vc03)
        
        let vc04 = UIViewController()
        vc04.tabBarItem.title = "我"
        vc04.view.backgroundColor = UIColor.green
        self.addChild(vc04)
    }

}

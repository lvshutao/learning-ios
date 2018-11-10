//
//  ViewController.swift
//  learn-ios
//
//  Created by lvshutao on 2018/11/1.
//  Copyright © 2018 lvshutao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 如何为按钮添加事件
        view.backgroundColor = .green
    }
    
    func openViewController() {
        let vc = ContactsViewController()
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true, completion: nil)
    }
    
}


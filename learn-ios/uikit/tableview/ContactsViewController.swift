//
//  ContactsViewController.swift
//  learn-ios
//
//  Created by lvshutao on 2018/11/1.
//  Copyright © 2018 lvshutao. All rights reserved.
//

import UIKit

// https://softauthor.com/ios-uitableview-programmatically-in-swift/
/*
 let vc = ContactsViewController()
 let nc = UINavigationController(rootViewController: vc)
 self.present(nc, animated: true, completion: nil)
 
 STEP #1: Create a New Xcode Project
 STEP #2: Get Rid of  Storyboard
 STEP #3: Set Root View Controller to the window object
 STEP #4: Create Data Model Struct and Class files [MVC]
 STEP #5: Add UITableView to the ContactViewController
 STEP #6: Add AutoLayout Constraints to the UITableView
 STEP #7: Implement UITableView DataSource Protocol Methods
 STEP #8: Add UINavigationController to the view controller
 STEP #9: Custom UITableViewCell
 STEP #10: Implement UITableViewDelegate Protocol Method
 */
class ContactsViewController: UIViewController {
    
    private let contacts = ContactAPI.getContacts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contactsTableView = UITableView()
        self.view.addSubview(contactsTableView)
        // 布局 Auto Layout，并且在 safeAreaLayoutGuide 内
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            contactsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            contactsTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
            contactsTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
            contactsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            contactsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            contactsTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
            contactsTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
            contactsTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        }
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        // 注册 Cell
        //        contactsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "contactCell")
        contactsTableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "contactCell")
        
        
        // 设置导航栏
        navigationItem.title = "Contacts"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        //        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:_ColorLiteralType(red: 1, green: 1, blue: 1, alpha: 1)]
    }
}

// mark: 数据源
extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 因为上面注册了，所以这里才能强制转换
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        cell.contact = contacts[indexPath.row]
        //        cell.textLabel?.text = contacts[indexPath.row].name 如果不注释掉这一行，那么会影响最终效果
        return cell
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

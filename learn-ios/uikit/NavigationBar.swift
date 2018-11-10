/*
 // 黑屏
 let vc = NavigationBar()
 self.present(vc, animated: true, completion: nil)
 */

import UIKit

// 导航栏
class NavigationBar:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        create()
    }
    
    func create() {
        let screenSize:CGRect = UIScreen.main.bounds
        // 创建
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 22, width: screenSize.width, height: 44))
        view.addSubview(navBar)
        navBar.delegate = self
        
        // 样式： default, black
        navBar.barStyle = .default
        // 是否透明
        navBar.isTranslucent = true
        // 标题样式
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
//        UINavigationBar.appearance().titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: UIColor.white
//        ]
        // 设置 UINavigationItem
        let navItem = UINavigationItem(title: "Nav Bar")
        // 右侧
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneAction))
        navItem.rightBarButtonItem = doneItem
        // 左侧
        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addAction))
        navItem.leftBarButtonItem = addItem
        
        navBar.setItems([navItem], animated: false)
    }
    
    @objc func addAction() {
        print("click add btn")
    }
    
    @objc func doneAction() {
        self.dismiss(animated: true, completion: nil)
    }
}


extension NavigationBar:UINavigationBarDelegate {
    func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        print("shouldPush")
        return true
    }
    
    func navigationBar(_ navigationBar: UINavigationBar, didPush item: UINavigationItem) {
        print("didPush")
    }
    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        print("shouldPop")
        return true
    }
    
    func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) {
        print("didPop")
    }
}

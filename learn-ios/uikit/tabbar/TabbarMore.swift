import UIKit

/*
 层级
 |-- tab bar Controller
 |--|-- Navigation Controller
 |--|--|-- View Controller 只要第一次出现时 view did load
 颜色
 UITabBar - TintColor, BarTintColor, BackgroundColor
 UINavigationBar - BarTintColor, TintColor, BarStyle
 
 主要功能
 1. 在 View Controller 中修改 Tab Bar Item Title and Icon
 self.title = "More"
 self.tabBarItem.image
 self.tabBarItem.selectedImage
 */

class TabBarMore: UITabBarController {
    
    var firstTabNavigationController: UINavigationController!
    var secondTabNavigationController: UINavigationController!
    var thirdTabNavigationController: UINavigationController!
    var fourthTabNavigationController: UINavigationController!
    var fifthTabNavigationController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        firstTabNavigationController = UINavigationController.init(rootViewController: TabBarMoreViewController())
        secondTabNavigationController = UINavigationController.init(rootViewController: TabBarMoreViewController())
        thirdTabNavigationController = UINavigationController.init(rootViewController: TabBarMoreViewController())
        fourthTabNavigationController = UINavigationController.init(rootViewController: TabBarMoreViewController())
        fifthTabNavigationController = UINavigationController.init(rootViewController: TabBarMoreViewController())
        
        self.viewControllers = [
            firstTabNavigationController,
            secondTabNavigationController,
            thirdTabNavigationController,
            fourthTabNavigationController,
            fifthTabNavigationController
        ]
        
        let item1 = UITabBarItem(title: "Home", image: nil, tag: 0)
        let item2 = UITabBarItem(title: "Contest", image: nil, tag: 1)
        let item3 = UITabBarItem(title: "Post a Picture", image: nil, tag: 2)
        let item4 = UITabBarItem(title: "Prizes", image: nil, tag: 3)
        let item5 = UITabBarItem(title: "Profile", image: nil, tag: 4)
        
        firstTabNavigationController.tabBarItem = item1
        secondTabNavigationController.tabBarItem = item2
        thirdTabNavigationController.tabBarItem = item3
        fourthTabNavigationController.tabBarItem = item4
        fifthTabNavigationController.tabBarItem = item5
        
        UITabBar.appearance().tintColor = UIColor(red: 0, green: 146/255.0, blue: 248/255.0, alpha: 1)
        
        // UITabBarController with custom color selection
        // 通常无此需求
    }
    
}

class TabBarMoreViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.random()
        print("view did load")
    }
}

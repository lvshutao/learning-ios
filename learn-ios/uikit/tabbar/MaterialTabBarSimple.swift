/*
 https://material.io/develop/ios/components/bottomnavigation/
 记住这句话：MDCBottomNavigationBar can be added to a view hierarchy like any UIView
 
 https://www.yudiz.com/material-design-components-for-ios/
 */

import UIKit

import MaterialComponents.MaterialBottomNavigation

import MaterialComponents.MaterialBottomNavigation_ColorThemer
import MaterialComponents.MaterialColorScheme

// 颜色
import MaterialComponents.MaterialPalettes

class MaterialTabBarSimple: UITabBarController {
    
    let bottomNavBar = MDCBottomNavigationBar()
    var colorScheme = MDCSemanticColorScheme()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: 布局
    func layoutBottomNavBar() {
        let size = bottomNavBar.sizeThatFits(view.bounds.size)
        let bottomNavBarFrame = CGRect(x: 0, y: view.bounds.height - size.height, width: size.width, height: size.height)
        bottomNavBar.frame = bottomNavBarFrame
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutBottomNavBar()
    }

    #if swift(>=3.2)
    @available(iOS 11, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        layoutBottomNavBar()
    }
    #endif
    // --- 必须，否则不会出现
    
    override func viewDidLoad() {
        view.backgroundColor = MDCPalette.grey.tint300
        view.addSubview(bottomNavBar)
        
        // Always show bottom navigation bar item titles.
        bottomNavBar.titleVisibility = .always
        // Cluster and center the bottom navigation bar items.
        bottomNavBar.alignment = .centered
        
        // Add items to the bottom navigation bar.
        let tabBarItem1 = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)
        let tabBarItem2 =
            UITabBarItem(title: "Messages", image: UIImage(named: "Email"), tag: 1)
        let tabBarItem3 =
            UITabBarItem(title: "Favorites", image: UIImage(named: "Favorite"), tag: 2)
        bottomNavBar.items = [ tabBarItem1, tabBarItem2, tabBarItem3 ]
        
        // Select a bottom navigation bar item.
        bottomNavBar.selectedItem = tabBarItem1;
        bottomNavBar.delegate = self
        
        // 应用主题颜色
//        MDCBottomNavigationBarColorThemer.applySemanticColorScheme(colorScheme,
//                                                                   toBottomNavigation: bottomNavBar)
        // 可选，修改标签文本
//        bottomNavBar.selectedItemTintColor = MDCPalette.blue.tint300
//        bottomNavBar.unselectedItemTintColor = MDCPalette.yellow.tint300
        
        
        let statusVc = TabBarMoreViewController()
        statusVc.title = "Status"
        
        let eventsVc = TabBarMoreViewController()
        eventsVc.title = "Events"
        
        let contactsVc = TabBarMoreViewController()
        contactsVc.title = "Contacts"
        
        self.viewControllers = [statusVc, eventsVc, contactsVc]
    }
}

extension MaterialTabBarSimple: MDCBottomNavigationBarDelegate {
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        print("did select item \(item.tag)")
        self.selectedViewController = self.viewControllers![item.tag]
    }
}

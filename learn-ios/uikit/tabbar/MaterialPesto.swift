/*
 
 仿官方示例 Pesto
 */

import UIKit

import MaterialComponents.MaterialBottomNavigation

import MaterialComponents.MaterialBottomNavigation_ColorThemer
import MaterialComponents.MaterialColorScheme

// 颜色
import MaterialComponents.MaterialPalettes

class MaterialPesto: UITabBarController {
    var vcs: [ViewController] = [];
   
    
    override func viewDidLoad() {
        
        let vc01 = TabBarMoreViewController()
        vc01.tabBarItem.title = "Vc01"
        
        let vc02 = TabBarMoreViewController()
        vc02.tabBarItem.title = "Vc02"
        
        let vc03 = TabBarMoreViewController()
        vc03.tabBarItem.title = "Vc03"
        
        self.viewControllers = [
            vc01, vc02, vc03
        ]
        
        self.tabBar.tintColor = UIColor(red: 0, green: 0.67, blue: 0.55, alpha: 1)
        self.tabBar.isTranslucent = false
    }
    
}

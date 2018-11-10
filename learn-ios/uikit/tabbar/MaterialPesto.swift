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
        
        let vc01 = ViewController()
        vc01.view.backgroundColor = UIColor.red
        vc01.tabBarItem.title = "Vc01"
        
        let vc02 = ViewController()
        vc02.view.backgroundColor = UIColor.yellow
        vc02.tabBarItem.title = "Vc02"
        
        let vc03 = ViewController()
        vc03.view.backgroundColor = UIColor.blue
        vc03.tabBarItem.title = "Vc03"
        
        self.viewControllers = [
            vc01, vc02, vc03
        ]
        
        self.tabBar.tintColor = UIColor(red: 0, green: 0.67, blue: 0.55, alpha: 1)
        self.tabBar.isTranslucent = false
    }
    
}

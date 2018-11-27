import UIKit

class Navigation {
    
    var nav:UINavigationController
    
    init(first: UIViewController) {
//        let main = NavDemoFirstGreen()
        self.nav = UINavigationController(rootViewController: first)
    }
    
    
}

// https://my.oschina.net/wangyongtao/blog/524249

class NavDemoFirstGreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("NavDemoFirstGreen - viewDidLoad")
        
        self.view.backgroundColor = UIColor.green
        
        // 设置右导航按钮
        let rightBarItem = UIBarButtonItem(title: "第二页", style: .plain,
                                           target: self, action: #selector(self.gotoNextView))
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc func gotoNextView() {
        let nextVC = NavDemoSecondYellow()
        self.navigationController?.show(nextVC, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        print("NavDemoFirstGreen - didReceiveMemoryWarning")
        super.didReceiveMemoryWarning()
    }
}

class NavDemoSecondYellow: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("NavDemoSecondYellow - viewDidLoad")
        
        self.view.backgroundColor = UIColor.yellow
        
        // 设置右导航
        let rightBarItem = UIBarButtonItem(title: "第三页", style: .plain,
                                           target: self, action: #selector(self.gotoNextView))
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        // 添加按钮以返回上一个视图
        let btn = UIButton(type: .system)
        btn.frame = CGRect(origin: self.view.center, size: CGSize(width: 100, height: 30))
        btn.backgroundColor = UIColor.red
        btn.setTitle("返回", for: .normal)
        btn.addTarget(self, action: #selector(self.popView), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func gotoNextView() {
        let nextVC = NavDemoThridRed()
        self.navigationController?.show(nextVC, sender: self)
    }
    // 返回上一页
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        print("NavDemoSecondYellow - didReceiveMemoryWarning")
        super.didReceiveMemoryWarning()
    }
}

class NavDemoThridRed: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("NavDemoThridRed - viewDidLoad")
        
        self.view.backgroundColor = UIColor.red
        
        // 设置右导航
        let rightBarItem = UIBarButtonItem(title: "第一页", style: .plain, target: self, action: #selector(self.gotoNextView))
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        // 添加按钮以返回根视图
        let btn = UIButton(type: .system)
        btn.frame = CGRect(origin: self.view.center, size: CGSize(width: 100, height: 30))
        btn.backgroundColor = UIColor.green
        btn.setTitle("根视图", for: .normal)
        btn.addTarget(self, action: #selector(self.popRootView), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func gotoNextView() {
        let nextVC = NavDemoFirstGreen()
        self.navigationController?.show(nextVC, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        print("NavDemoThridRed - didReceiveMemoryWarning")
        super.didReceiveMemoryWarning()
    }
    // 返回根视图
    @objc func popRootView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

/* https://softauthor.com/ios-ui-design-programmatically-xcode-9-swift-4/
 使用代码来创建 UI
 1. 弃用 Storyboard
 移除默认的 Storyboard.View, 从配置中清除 Main Interface
 
 2. AppDelegate.swift didFinishLaunchingWithOptions()
 window = UIWindow(frame:UIScreen.main.bounds)
 window?.makeKeyAndVisible()
 window?.rootViewController = ViewController()
 
 3. 创建组件
 （常见错误）组件里必须设置 view.translatesAutoresizingMaskIntoConstraints = false，否则自动布局约束不会生效
 自动布局 https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ProgrammaticallyCreatingConstraints.html
 */

import UIKit


class UIProgram: UIViewController {
    
    // MARK: 1. 组件
    
    private let loginContentView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let usernameTextField: UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor = UIColor.white
        txtField.borderStyle = .roundedRect
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    private let passwordTextField: UITextField = {
        let txtField = UITextField()
        txtField.borderStyle = .roundedRect
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()

    let btnLogin: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.blue
        btn.setTitle("Login", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景色
        view.backgroundColor = .green
        
        // 2. 组合组件
        loginContentView.addSubview(usernameTextField)
        loginContentView.addSubview(passwordTextField)
        loginContentView.addSubview(btnLogin)
        view.addSubview(loginContentView)
        
        // 3. 组件约束 : 组件约束想要生效，是有前提条件的 —— 看上面的常见错误
        loginContentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loginContentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loginContentView.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
        loginContentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        usernameTextField.topAnchor.constraint(equalTo:loginContentView.topAnchor, constant:40).isActive = true
        usernameTextField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        usernameTextField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant:50).isActive = true
        passwordTextField.topAnchor.constraint(equalTo:usernameTextField.bottomAnchor, constant:20).isActive = true
        
        btnLogin.topAnchor.constraint(equalTo:passwordTextField.bottomAnchor, constant:20).isActive = true
        btnLogin.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        btnLogin.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        btnLogin.heightAnchor.constraint(equalToConstant:50).isActive = true
    }
}

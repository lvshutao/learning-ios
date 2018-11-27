import UIKit

class Switch: UIViewController {
    
    var mySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // width, height 设置为 0 不影响显示
        mySwitch = UISwitch(frame: CGRect(x: 10, y: 30, width: 0, height: 0))
        self.view.addSubview(mySwitch)
        
        mySwitch.setOn(true, animated: false)
        
        // 背景颜色
//        mySwitch.backgroundColor = UIColor.yellow
        
        // 关闭
        mySwitch.tintColor = UIColor.blue
        // 开启
        mySwitch.onTintColor = UIColor.cyan
        
        mySwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    }
    
    @objc func switchChanged( switch: UISwitch ) {
        print("v: \(mySwitch.isOn)")
    }
}

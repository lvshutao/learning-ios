import UIKit

class AlertController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        createBtn(title: "Simple", selector: #selector(simpleDemo), x: 20, y: 20)
        createBtn(title: "删除", selector: #selector(destructiveDemo), x: 20, y: 80)
        createBtn(title: "ActionSheet", selector: #selector(actionSheets), x: 20, y: 140)
        createBtn(title: "输入框", selector: #selector(promptBox), x: 20, y: 200)
        createBtn(title: "高亮按钮", selector: #selector(highlightingActionButton), x: 20, y: 240)
    }
}

extension AlertController {
    
    func createBtn(title:String, selector:Selector, x:CGFloat, y:CGFloat) {
        let simpleBtn = UIButton(type: .custom)
        simpleBtn.setTitle(title, for: .normal)
        simpleBtn.setTitleColor(UIColor.blue, for: .normal)
        simpleBtn.frame = CGRect(x: x, y: y, width: 100, height: 20)
        simpleBtn.addTarget(self, action:selector, for: .touchUpInside)
        self.view.addSubview(simpleBtn)
    }
    
    @objc func simpleDemo() {
        let alert = UIAlertController(
            title: "是否删除",
            message: "内容",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { _ in
            print("Cancel")
        }))
        
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
            print("OK")
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func destructiveDemo() {
        let alert = UIAlertController(title: "删除", message: "应用场景未确认", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Destructive", style: .destructive, handler: { (_) in
            print("Destructive")
        }))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            print("OK")
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func actionSheets() {
        let alert = UIAlertController(title: "Demo", message: "A demo with two buttons", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("Cancel")
        }))
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (_) in
            print("OK")
        }))
        
        let destructiveAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            print("Delete")
        }
        alert.addAction(destructiveAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func promptBox() {
        let alert = UIAlertController(title: "Hello", message: "Welcome to the world of iOS", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default) { (_) in
            print("default action")
        }
        defaultAction.isEnabled = true
        alert.addAction(defaultAction)
        
        alert.addTextField { (textField) in
            textField.delegate = self
            textField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func highlightingActionButton() {
        let alter = UIAlertController(title: "Cancel edit", message: "Are you really want to cancel you edit?", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            print("Cancel")
        }
        
        let no = UIAlertAction(title: "No", style: .default) { (_) in
            print("Highlighted button is pressed")
        }
        
        alter.addAction(cancel)
        alter.addAction(no)
        
        alter.preferredAction = no
        
        self.present(alter, animated: true, completion: nil)
    }
}

// https://stackoverflow.com/questions/24710041/adding-uitextfield-on-uiview-programmatically-swift/32602425
extension AlertController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ sender:UITextField) {
        print("文本内容:\(String(describing: sender.text))")
    }
    
    // 输入框是否可以被修改
    // false 无法修改，不出现键盘；true 可以修改，默认值
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    // 当点击键盘的返回q键（右下角）时，执行该方法，一般用来隐藏键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    // 当输入框获得焦点时，执行该方法
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    // 指定是滞允许本字段结束编辑，允许的话，文本字段会失去 first response
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    // 指明是否允许根据用户请求清除内容
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    // 文本框的文本，是否能被修改
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

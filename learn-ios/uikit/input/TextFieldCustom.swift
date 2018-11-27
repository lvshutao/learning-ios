import UIKit

class TextFieldCustom: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.bounds.size.width
        let numberTextField = NUmberTextField(frame: CGRect(x: 10, y: 30, width: width - 20, height: 30))
        numberTextField.backgroundColor = UIColor.green
        self.view.addSubview(numberTextField)
        
        
    }
}
// 只接受数字，不接受其它任何字符
class NUmberTextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init NSCoder")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init frame")
        registerForTextFieldNotifications()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("init awakeFromNib")
        keyboardType = .numberPad // useful for iphone only
    }
    
    private func registerForTextFieldNotifications() {
        self.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func textDidChange(_ textField: UITextField) {
        text = filteredText()
        print("text:\(String(describing: text))")
    }
    
    private func filteredText() -> String {
        let inverseSet = CharacterSet(charactersIn: "0123456789").inverted
        let components = text!.components(separatedBy: inverseSet)
        return components.joined(separator: "")
    }
    
    // 禁用所有的操作：复制、粘贴等
    var enableLongPressActions = false
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return enableLongPressActions
    }
}

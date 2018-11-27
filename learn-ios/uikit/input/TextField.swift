import UIKit

/**
 常见问题
 1. 第一响应者、隐藏/显示键盘
 textField.becomeFirstResponder()
 textField.resignFirstResponder()
 2. 输入内容的过滤
 3. 键盘工具栏的定制（键盘定制查看 Keyboard）
 4. 文字输入选择
 */

class TextField: UIViewController {
    
    var textF:UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        textF.frame = CGRect(x: 20, y: 50, width: 200, height: 30)
        textF.backgroundColor = UIColor.yellow
        textF.delegate = self
        // 自动处理：.no, .words 每个单词大写开头, .sentences 每个句子第一个大写开头, .all 全部
        textF.autocorrectionType = .no
        
        view.addSubview(textF)
        
        accessoryToolbar();
    }
    
    let allowedCharacters = CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxyz").inverted
}

extension TextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 如果有多个 textField ，则可以使用下面的方式进行区分
        if textF == textField {
            print("textF didBeginEditing")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textF == textField {
            print("textF didEndEditing")
        }
    }
    
    // 对用户的输入进行验证
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let components = string.components(separatedBy: allowedCharacters)
        let filtered = components.joined(separator: "")
        
        if string == filtered {
            return true
        } else {
            return false
        }
    }
    
    // 点击 `return` 时隐藏键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // 隐藏定位光标 (swift 3)
    // https://developer.apple.com/documentation/uikit/uitextinput/1614518-caretrect
    // UITextInput 的
//    override func caretRect(for position: UITextPosition) -> CGRect {
//        return CGRect.zero
//    }
}

// 选择位置相关
// https://stackoverflow.com/questions/34922331/getting-and-setting-cursor-position-of-uitextfield-and-uitextview-in-swift/34922332#34922332
// 如何范围选择：https://stackoverflow.com/questions/34940033/get-character-before-cursor-in-swift/34940034#34940034
// 创建 Range: https://stackoverflow.com/questions/30093688/how-to-create-range-in-swift/35193481#35193481
extension TextField {
    func getCursorPosition() {
        let startPosition: UITextPosition = textF.beginningOfDocument
//        let endPosition: UITextPosition = textF.endOfDocument
        if let selectedRange = textF.selectedTextRange {
            let cursorPosition = textF.offset(from: startPosition, to: selectedRange.start)
            print("\(cursorPosition)")
        }
    }
    
    func setToTheBegin() {
        let newPosition = textF.beginningOfDocument
        textF.selectedTextRange = textF.textRange(from: newPosition, to: newPosition)
    }
    
    func setToTheEnd() {
        let newPosition = textF.endOfDocument
        textF.selectedTextRange = textF.textRange(from: newPosition, to: newPosition)
    }
    
    func selectRange() {
        // Range: 3 - 7
        let startPosition = textF.position(from: textF.beginningOfDocument, in: .right, offset: 3)
        let endPosition = textF.position(from: textF.beginningOfDocument, in: .right, offset: 7)
        if startPosition != nil && endPosition != nil {
            textF.selectedTextRange = textF.textRange(from: startPosition!, to: endPosition!)
        }
    }
    func selectAll() {
        textF.selectedTextRange = textF.textRange(from: textF.beginningOfDocument, to: textF.endOfDocument)
    }
    func insertText() {
        textF.insertText("Hello World!")
    }
}

extension TextField {
    // Input accessory view (toolbar)
    // 工具栏
    func accessoryToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 0))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // 这个 done 不是原始键盘右下角的 done
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        let items = [flexibleSpace, doneButton]
        toolbar.setItems(items, animated: false)
        toolbar.sizeToFit()
        
        textF.inputAccessoryView = toolbar
    }
    
    @objc func done() {
        print("click done")
    }
}

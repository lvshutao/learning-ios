import UIKit
/*
 基础的使用在 TextField 中
 
 常见问题
 * 不要让键盘遮住输入控件 keyboard covers uitextfield
 https://developer.apple.com/library/archive/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html 官方文档提到：The simplest way to manage text objects with the keyboard is to embed them inside a UIScrollView object or one of its subclasses
 1. Get the size of the keyboard.
 2. Adjust the bottom content inset of your scroll view by the keyboard height.
 3. Scroll the target text field into view.
 https://stackoverflow.com/questions/13056004/how-to-make-a-uiscrollview-auto-scroll-when-a-uitextfield-becomes-a-first-respon/33256560
 https://stackoverflow.com/questions/28813339/move-a-view-up-only-when-the-keyboard-covers-an-input-field
 
 +++++++++ 网上有专门的库用于一次性解决这种问题 ++++++++++
 https://github.com/hackiftekhar/IQKeyboardManager
 
 
 */

class Keyboard: UIViewController {
    
    var textViewBottom: UITextView!
    var textViewMiddle: UITextView!
    var textViewTop: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.bounds.size.width - 20
        let height = self.view.bounds.size.height
        
        // 位于顶部，不会被遮住 (自定义键盘)
        textViewTop = UITextView(frame: CGRect(x: 10, y: 30 + 22, width: width, height: 30))
        textViewTop.backgroundColor = UIColor.yellow
        // ---------- 自定义键盘 ---------
        createToolbar()
        
        // 中间，可能需要根据屏幕进行计算
        textViewMiddle = UITextView(frame: CGRect(x: 10, y: height/2 - 15, width: width, height: 30))
        textViewMiddle.backgroundColor = UIColor.blue
        // 修改键盘的类型，内置有很多类型: defautl, ascIICapable, numbersAndPunctuation,
        // url (显示 . / .com), numberPath (0-9, 用于 PIN)
        // phonePath (1-9, * 0 #), namePhonePad(电话号码人名等）
        // emailAdress, decimallPath, webSearch
        textViewMiddle.keyboardType = .numbersAndPunctuation
        
        // 位于视图底部的 TextView
        textViewBottom = UITextView(frame: CGRect(x: 10, y:  height - 40, width: width, height: 30))
        textViewBottom.backgroundColor = UIColor.red
        
        // 如果直接添加到 view，那么弹出来的键盘就会完全遮住它
        self.view.addSubview(textViewMiddle)
        self.view.addSubview(textViewBottom)
        self.view.addSubview(textViewTop)
        
        // 隐藏键盘
        hideKeyboardWhenTappedAround()
    }
    
    // UIPickerView
    var picker:UIPickerView?
    var data:[String]?
    var textFieldBeginEdited: UITextField? // 当臆编辑的 UITextField
    // 默认 picker 没有像常规键盘那个的 Return/Done 来关闭键盘，所以添加自定义工具栏，用于关闭
    // 但是 dismissKeyboard 能够正常起作用
    var pickerAccessory: UIToolbar?
}
// https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
// https://github.com/goktugyil/EZSwiftExtensions/tree/master/Sources
// 点击视图时隐藏键盘
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// 键盘 UIPickerView
extension Keyboard: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func createToolbar() {
        picker = UIPickerView()
        picker?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        picker?.backgroundColor = UIColor.white
        picker?.dataSource = self
        picker?.delegate = self
        picker?.reloadAllComponents()
        picker?.selectRow(3, inComponent: 0, animated: false)
        
        self.data = ["One", "Two", "Three", "Four", "Five"]
        
        // 添加一个关闭 pickView 的工具栏
        pickerAccessory = UIToolbar()
        pickerAccessory?.autoresizingMask = .flexibleHeight
        pickerAccessory?.barStyle = .default
        pickerAccessory?.barTintColor = UIColor.red
        pickerAccessory?.backgroundColor = UIColor.red
        pickerAccessory?.isTranslucent = false
        
        var frame = pickerAccessory?.frame
        frame?.size.height = 44.0
        pickerAccessory?.frame = frame!
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnClicked))
        cancelButton.tintColor = UIColor.white
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClicked))
        doneButton.tintColor = UIColor.white
        
        pickerAccessory?.items = [cancelButton, flexSpace, doneButton]
        
        textViewTop.inputView = picker
        textViewTop.inputAccessoryView = pickerAccessory
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if data != nil {
            return data!.count
        } else {
            return 0
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if data != nil {
            return data![row]
        } else {
            return ""
        }
    }
    
    @objc func cancelBtnClicked(_ button: UIBarButtonItem?) {
        textViewTop.resignFirstResponder()
    }
    @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        textViewTop.resignFirstResponder()
    }
}

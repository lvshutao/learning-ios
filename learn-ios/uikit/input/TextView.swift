import UIKit

class TextView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // 修改文字属性
        changeAttributeText()
        
        // 修改字体
        changeFont()
        
        // 内容识别
        detectContent()
        
        noPadding()
        
        cursorPosition()
        
        withHtml()
        
        // 检查内容是否为空
//        if let text = self.textView.text where !text.isEmpty {
//            // do stuff fot text
//        } else {
//            // do stuff for nil text or empty string
//        }
    }
    
    func changeAttributeText() {
        let textView = UITextView()
        self.view.addSubview(textView)
        textView.frame = CGRect(x: 10, y: 30, width: 200, height: 40)
        textView.text = "Hello, tinted and highlighted is here"
        // 修改某个属性
        let attributexText = NSMutableAttributedString(attributedString: textView.attributedText!)
        
        // 内容范围
        let text = textView.text! as NSString
        
        // find the range of each element to modify
        let tintedRange = text.range(of: NSLocalizedString("tinted", comment: ""))
        let highlightedRange = text.range(of: NSLocalizedString("highlighted", comment: ""))
        
        attributexText.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor.blue, range: tintedRange)
        attributexText.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.yellow, range: highlightedRange)
        
        textView.attributedText = attributexText
    }
    
    func changeFont() {
        let textView = UITextView(frame: CGRect(x: 10, y: 80, width: 200, height: 60))
        textView.font = UIFont.systemFont(ofSize: 24)
        textView.text = "Change Font"
        textView.backgroundColor = UIColor.green
        self.view.addSubview(textView)
        
        // 设置键盘属性
        textView.keyboardType = .default
        textView.returnKeyType = .go
    }
    
    // 文字识别
    // 识别：PhoneNumber, Link, Address, CalendarEvent, None, All
    func detectContent() {
        let textView = UITextView(frame: CGRect(x: 10, y: 150, width: 200, height: 30))
        textView.backgroundColor = UIColor.gray
        textView.text = "请输入内容: 0755-88886666"
        textView.dataDetectorTypes = .all
        self.view.addSubview(textView)
        
        // 属性
        // 是否可编辑
        textView.isEditable = false
        // 是否可选择
        textView.isSelectable = false
        // 交互
        textView.isUserInteractionEnabled = false // 默认为 true
    }
    
    func noPadding() {
        let textView = UITextView(frame: CGRect(x: 10, y: 250, width: 200, height: 30))
        textView.backgroundColor = UIColor.gray
        textView.text = "没有 padding"
        self.view.addSubview(textView)
        
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
    }
    
    // 获取位置
    func cursorPosition() {
        let textView = UITextView(frame: CGRect(x: 10, y: 300, width: 200, height: 30))
        textView.backgroundColor = UIColor.gray
        textView.text = "获取位置"
        self.view.addSubview(textView)
        textView.delegate = self
    }
    
    func withHtml() {
        let html = "<p>This is an <i>HTML</i><br/> text</p>"
        let textView = UITextView(frame: CGRect(x: 10, y: 350, width: self.view.bounds.width - 200, height: 30))
        textView.backgroundColor = UIColor.gray
        textView.text = html.htmlToString
        self.view.addSubview(textView)
    }
    
}

extension String {
    // 带 html 内容
    // https://stackoverflow.com/questions/37048759/swift-display-html-data-in-a-label-or-textview
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension TextView: UITextViewDelegate {
    // 编辑通知
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("textViewShouldBeginEditing")
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing")
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        print("textViewShouldEndEditing")
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing")
    }
    
    // 文本变化
    func textViewDidChange(_ textView: UITextView) {
        print("didChange:\(String(describing: textView.text))")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("shouldChangeTextIn:\(String(describing: textView.text))")
        return true
    }
    // 获取位置索引
    func textViewDidChangeSelection(_ textView: UITextView) {
        if let selectedRange = textView.selectedTextRange {
            let cursorPosition = textView.offset(from: textView.beginningOfDocument, to: selectedRange.start)
            print("cursorPosition:\(cursorPosition)")
        }
        // 其它
        /*
         // 到开头
         let newPosition = textView.beginningOfDocument
         textView.selectedTextRange = textView.textRangeFromPosition(newPosition, toPosition: newPosition)
         
         // 到结尾
         let newPosition = textView.endOfDocument
         textView.selectedTextRange = textView.textRangeFromPosition(newPosition, toPosition: newPosition)
         
         // 偏移位置
         // only if there is a currently selected range
         if let selectedRange = textView.selectedTextRange {
         // and only if the new position is valid
         if let newPosition = textView.positionFromPosition(selectedRange.start, inDirection: UITextLayoutDirection.Left, offset: 1) {
         // set the new position
            textView.selectedTextRange = textView.textRangeFromPosition(
                newPosition,
                toPosition:newPosition)
         } }
         
         // select all text
         // select a range of text
         // insert text at the current cursor position
         */
    }
}

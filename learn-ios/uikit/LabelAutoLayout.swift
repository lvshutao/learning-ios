import UIKit

/*
 小结：
 1. 自动布局必须设置 translatesAutoresizingMaskIntoConstraints = false
 2. leftAnchor/rightAnchor 和 leadingAnchor/trailingAnchor 的区别
 前者是跟屏幕相关，后者是跟书写顺序相关（如果某个地区的书写顺序是由右往左，那么后台就会与常规相反）
 https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853
 
 3. 有关 NSLayoutConstraint.activate
 https://stackoverflow.com/questions/8796862/uilabel-auto-size-label-to-fit-text/36348985#36348985
 只需要设置 UILabel 的左上约束，Label 本身有宽度高度会自动计算
 https://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights/36422189#36422189
 在 UITableViewCell 中自动计算 UILabel 的高度
 */
class LabelAutoLayout : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        
        // 使用 Frame
        let frame = CGRect(x: 0, y: 50, width: 200, height: 21)
        let label = UILabel(frame: frame)
        label.text = "Label with Frame"
        view.addSubview(label)
        
        // 自动布局
        let labelAuto = UILabel()
        labelAuto.backgroundColor = .red
        labelAuto.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelAuto)
        
        NSLayoutConstraint.activate([
            labelAuto.topAnchor.constraint(equalTo: label.bottomAnchor),
            labelAuto.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            labelAuto.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelAuto.widthAnchor.constraint(equalToConstant: 100)
            ])
        
        // numberOfLines
        let text = "If the label has a height constraint, the constraint will be respected. In this case, label.numberOfLines = 0 may not work as expected.";
        let labelLongText = UILabel()
        labelLongText.text = text
        labelLongText.backgroundColor = .gray
        view.addSubview(labelLongText)
        
        labelLongText.translatesAutoresizingMaskIntoConstraints = false
        // 如果不设置为 0，那么当写不完时，就使用省略号表示
        labelLongText.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            labelLongText.leftAnchor.constraint(equalTo: labelAuto.rightAnchor),
            labelLongText.rightAnchor.constraint(equalTo: view.rightAnchor),
            labelLongText.topAnchor.constraint(equalTo: label.bottomAnchor),
            ])
        
        // 字体
        label.font = UIFont.systemFont(ofSize: 24)
        labelAuto.text = text
        
        labelAuto.numberOfLines = 0
        // 加粗
        labelAuto.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        // 动态（继承）
        labelLongText.font = UIFont.preferredFont(forTextStyle: .body)
        
        // 颜色
        labelLongText.textColor = UIColor.white
        
        // 彩色字体
        let labelColor = UILabel(frame: CGRect(x: 0, y: 150, width: view.bounds.width, height: 42))
        view.addSubview(labelColor)
        labelColor.numberOfLines = 2
        let simpleString = "The grass is green; the sky is blue."
        let attributeString = NSMutableAttributedString(string: simpleString)
        
        // https://stackoverflow.com/questions/48762758/swift-4-conversion-error-type-nsattributedstringkey-has-no-member-foregroun
        // 注意，不要多写了 addAttributes 最后的 s
        // https://stackoverflow.com/questions/24666515/how-do-i-make-an-attributed-string-using-swift
        attributeString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value:UIColor.green,
            range: NSRange(location: 13, length: 5)
        )
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSRange(location: 31, length: 4))
        labelColor.attributedText = attributeString
        labelColor.font = UIFont.systemFont(ofSize: 17)
        
        // size to fit
        labelColor.backgroundColor = UIColor.lightGray
        // 如果没有 sizeToFit 那么整行都是背景色，并且会有 padding 效果
        // 如果设置了下面的 sizeToFit，那么背景色只会出现在文字宽度上（不会整行），并且没有 padding 效果
        labelColor.sizeToFit()
        print("view bounds：\(view.bounds)")
        print("labelColor frame：\(labelColor.frame)")
        print("labelColor bounds：\(labelColor.bounds)")

        // 对齐
        label.textAlignment = .right
        labelAuto.sizeToFit() // 垂直顶上对齐，只能使用 sizeTo Fit —— 没有效果
        
        
        // 计算字符串的高度、宽度
        print("宽度:\(simpleString.widthWithStringAttributes(attributes: nil))")
        print("+字体宽度\(simpleString.widthWithFont(font: UIFont.systemFont(ofSize: 17)))")
        
        // 具有响应能力的 Label
        // 但是通常使用 UIButton
        let labelAction = UILabel()
        labelAction.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(labelClicked(_:)))
        labelAction.addGestureRecognizer(gesture)
        view.addSubview(labelAction)
        labelAction.text = "点我"
        labelAction.frame = CGRect(x: 0, y: 200, width: 100, height: 21)
        
        // 阴影
        labelColor.layer.shadowOffset = CGSize(width: 2, height: 2)
        labelColor.layer.shadowOpacity = 0.7
        labelColor.layer.shadowRadius = 2
        
        // Justify Text —— 两端对齐
        let sampleText = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        // Create label
        let justifyLabel = UILabel(frame: CGRect(x: 100, y: 200, width: view.frame.size.width - 110, height: 400))
        justifyLabel.numberOfLines = 0
        justifyLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        // Justify text through paragraph style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.baselineOffset: NSNumber(value: 0)]
        let attributedString = NSAttributedString(string: sampleText, attributes: attributes);
        justifyLabel.attributedText = attributedString
        view.addSubview(justifyLabel)
        
        // 获取 label 实际的高度
        // 1. numberOfLines = 0
        let maximumLabelSize = CGSize(width: 280, height: 9999) // 设置一个很大的块
        let expectedLabelSize = justifyLabel.sizeThatFits(maximumLabelSize)
        var newFrame = justifyLabel.frame
        newFrame.size.height = expectedLabelSize.height
        print("实际宽度:\(newFrame)")
    }
    
    @objc func labelClicked(_ sender: UILabel) {
        print("你点击了 UILabel")
    }
}

extension String {
    // 计算
    // boundingRectWithSize:options:attributes:context:
    // https://www.cnblogs.com/YouXianMing/p/5823893.html
    
    /**
     计算字符串的高度
     - parameter attributes: 字符串的属性
     - parameter fixedWidth: 固定的宽度
     - returns: 高度
     */
    func heightWithStringAttributes(attributes: [NSAttributedString.Key : Any], fixedWidth: CGFloat) -> CGFloat {
        guard self.count > 0 else {
            return 0
        }
        
        let size = CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return ceil (rect.size.height)
    }
    
    /**
     获取字符串的高度
     - parameter font: 字体
     - parameter fixedWidth: 固定的宽度
     - returns: 计算的高度
     */
    func heightWithFont(font: UIFont = UIFont.systemFont(ofSize: 18), fixedWidth:CGFloat) -> CGFloat {
        guard self.count > 0 && fixedWidth > 0 else {
            return 0
        }
        let size = CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:font], context: nil)
        return ceil (rect.size.height)
    }
    /**
     获取字符串的宽蔗
     - parameter attributes: 字符串的属性，如果设置为 nil，结果可能会不正确
     - returns: 宽度
     */
    func widthWithStringAttributes(attributes:  [NSAttributedString.Key : Any]?) -> CGFloat {
        guard self.count > 0 else {
            return 0
        }
        
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return ceil(rect.size.width)
    }
    /**
     获取字符串的宽度
     - parameter font: 字体
     - returns: 字符串宽度
     */
    func widthWithFont(font:UIFont = UIFont.systemFont(ofSize: 18)) -> CGFloat {
        guard  self.count > 0 else {
            return 0
        }
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:font], context: nil)
        return ceil( rect.size.width )
    }
}

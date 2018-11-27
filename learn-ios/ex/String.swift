import UIKit


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

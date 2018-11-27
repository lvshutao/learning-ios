import UIKit

// https://www.appcoda.com/learnswift/auto-layout-intro.html
/*
 iPhone 5/5s/SE         -> 320 * 568 point,     640 * 1136 px
 iPhone 6/6s/7/8        -> 375 * 667 point,     750 * 1334 px
 iPhone 6/6s/7/8 Plus   -> 414 * 1242 point,    736 * 2208 px
 iPhone X               -> 375 * 812 point ,    1125 * 2436 px
 iPhone 4s              -> 320 * 480 point,     640 * 960 px
 */

/**
 * Safe Areas: 整个界面 = Status bar + Safe area;
 contactsTableView.translatesAutoresizingMaskIntoConstraints = false
 if #available(iOS 11.0, *) {
    contactsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
 } else {
    contactsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
 }
 Safe Area 会自动根据其父元素（navigation bar 或者其它内容）来更新自己
 * 与父视图的约束
 * 与兄弟视图的约束
 自身完成约束
 1. center horizontaslly + center vertically （父视图） —— inCenter
 2.
 the left edge should be 30 points from the left edge of its containing view
 button.left = (container.left + 30)
 */

class AutoLayout: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view frame: \(view.frame); bounds: \(view.bounds)")
        inCenter()
    }
    
    // https://stackoverflow.com/questions/27624133/programmatically-add-centerx-centery-constraints
    func inCenter() {
        // 自身完成约束
        let alignCenter = UIView(frame: CGRect.zero) // 这里设置为 zero，通过约束来设置 宽度、高度
        alignCenter.backgroundColor = UIColor.red
        alignCenter.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(alignCenter)
        
        alignCenter.widthAnchor.constraint(equalToConstant: 100).isActive = true
        alignCenter.heightAnchor.constraint(equalToConstant: 100).isActive = true
        alignCenter.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alignCenter.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    // 正确： 使用下面的 inCenterBetterDemo 代替
    func inCenterDemo() {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Nothing to show"
        label.textAlignment = .center
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        let widthConstraint = NSLayoutConstraint(item: label,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1.0,
                                                 constant: 250)
        let heightConstraint = NSLayoutConstraint(item: label,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1.0,
                                                  constant: 100)
        let xConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([widthConstraint, heightConstraint, xConstraint, yConstraint])
    }
    
    func inCenterBetterDemo() {
        
        let label = UILabel(frame: CGRect.zero)
        label.text = "Nothing to show"
        label.textAlignment = .center
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        label.widthAnchor.constraint(equalToConstant: 250).isActive = true
        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

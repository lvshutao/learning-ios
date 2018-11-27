import UIKit

class ViewSimple: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        makeTheViewRounded()
        
        easyViewRound()
        
        // 截图
//        withSnapshot()
        
        // 视图的添加、插入、移除
        // parentView.addSubview(subView)
        // parentView.insertSubview(subView, belowSubview: subView2)
        // parentView.insertSubview(subView, aboveSubview: subView2)
        // parentView.bringSubviewToFront(subView)
        // subView.removeFromSuperview()
        
        // 其它
        withAddWithFixedHeight()
        // Function add full resize constraint for created UIView.
        
        animatingWithView()
    }
    
    func makeTheViewRounded() {
        if let image = UIImage(named: "Kim Yu") {
            let imageView = UIImageView(frame:CGRect(x: 50, y: 50, width: 50, height: 50))
            imageView.image = image
            imageView.layoutIfNeeded()
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 25
            
            self.view.addSubview(imageView)
        }
    }
    
    func easyViewRound() {
        let eview = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        eview.backgroundColor = UIColor.red
        eview.setAsCircle()
        self.view.addSubview(eview)
    }
    
    // 截图
    func withSnapshot() {
        if let snapshot = view.snapshotView(afterScreenUpdates: true) {
            let frame = CGRect(x: 150, y: 150, width: snapshot.frame.size.width, height: snapshot.frame.size.height)
            snapshot.frame = frame
            self.view.addSubview(snapshot)
        }
    }
    
    // Function to add view with fixed height using autolayout constraints
    func addViewWithFixedHeight(subView:UIView, parentView:UIView, withHeight:CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        /* 有错误
        let trailing = NSLayoutConstraint(
            item: subView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: parentView,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 10.0)
        
        let top = NSLayoutConstraint(
            item: subView,
            attribute: .top,
            relatedBy: .equal,
            toItem: parentView,
            attribute: .top,
            multiplier: 1.0,
            constant: 10.0)
        
        let leading = NSLayoutConstraint(
            item: subView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: parentView,
            attribute: .leading,
            multiplier: 1.0,
            constant: 10.0)
        
        parentView.addConstraint(trailing)
        parentView.addConstraint(top)
        parentView.addConstraint(leading)
        
        let height = NSLayoutConstraint(
            item: subView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 0.0,
            constant: withHeight)

        subView.addConstraint(height)
        */
    }
    // 有错误
    func withAddWithFixedHeight() {
        let subView = UIView(frame: CGRect(x: 200, y: 200, width: 10, height: 20))
        subView.backgroundColor = UIColor.green
        
        addViewWithFixedHeight(subView: subView, parentView: self.view, withHeight: 50)
    }
    
    // https://medium.com/ios-os-x-development/uiview-animation-in-swift-3-2b499abb58c5
    func animatingWithView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = UIColor.orange
        self.view.addSubview(view)
        
        UIView.animate(withDuration: 0.75, delay: 0.5, options: .curveEaseIn, animations: {
            print("animations")
            
            view.backgroundColor = UIColor.blue
            view.frame.origin.x += 50
            view.frame.origin.y += 50
        }) { (finished) in
            print("finished:\(finished)")
        }
    }
}

extension UIView {
    // 如果宽高一样，则可以使用下面的方法
    @discardableResult
    public func setAsCircle() -> Self {
        self.clipsToBounds = true
        let frameSize = self.frame.size
        self.layer.cornerRadius = min(frameSize.width, frameSize.height) / 2.0
        return self
    }
    
    // 通过晃动进行截图
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction =  CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -7.0, 7.0, -5.0, 5.0, 0.0]
        layer.add(animation, forKey: "shake")
    }
    
    func screenshot() -> UIImage? {
        UIGraphicsBeginImageContext(self.bounds.size)
        
        let context = UIGraphicsGetCurrentContext()
        self.layer.render(in: context!)
        
        let screenShot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return screenShot
    }
}

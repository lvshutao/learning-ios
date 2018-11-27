import UIKit

protocol ViewControllerCommunicationDelegate: class {
    func myTrackingBegan()
    func myTrackingContinuing(location: CGPoint)
    func myTrackingEnded()
}

/*
 beginTrackingWithTouch : called when the finger first touches down within the control's bounds
 continueTrackingWithTouch : called repeatedly as the finger slides across the control and even outside of the control's bounds
 endTrackingWithTouch : when finger lifts off the screen
 */
class MyCustomControl : UIControl {
    weak var delegate: ViewControllerCommunicationDelegate?
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        delegate?.myTrackingBegan()
        // returning true means that future events (like continueTrackingWithTouch and
        // endTrackingWithTouch) will continue to be fired
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let point = touch.location(in: self)
        
        delegate?.myTrackingContinuing(location: point)
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event:UIEvent?) {
        delegate?.myTrackingEnded()
    }
}


class ViewControllerCustom: UIViewController, ViewControllerCommunicationDelegate {
    var myCustomControl: MyCustomControl!
    
    var trackingBeganLabel: UILabel!
    var trackingEndedLabel: UILabel!
    var xLabel: UILabel!
    var yLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let width = self.view.bounds.size.width
        
        trackingBeganLabel = UILabel(frame: CGRect(x: 10, y: 22, width: width - 20, height: 30))
        trackingBeganLabel.backgroundColor = UIColor.green
        self.view.addSubview(trackingBeganLabel)
        
        trackingEndedLabel = UILabel(frame: CGRect(x: 10, y: 60, width: width - 20, height: 30))
        trackingEndedLabel.backgroundColor = UIColor.blue
        self.view.addSubview(trackingEndedLabel)
        
        xLabel = UILabel(frame: CGRect(x: 10, y: 100, width: width - 20, height: 30))
        xLabel.backgroundColor = UIColor.gray
        self.view.addSubview(xLabel)
        
        yLabel = UILabel(frame: CGRect(x: 10, y: 140, width: width - 20, height: 30))
        yLabel.backgroundColor = UIColor.gray
        self.view.addSubview(yLabel)
        
        myCustomControl = MyCustomControl()
        myCustomControl.delegate = self // 没起作用
    }
}
extension ViewControllerCustom {
    func myTrackingBegan() {
        trackingBeganLabel.text = "Tracking began"
    }
    
    func myTrackingContinuing(location: CGPoint) {
        xLabel.text = "x:\(location.x)"
        yLabel.text = "y:\(location.y)"
    }
    
    func myTrackingEnded() {
        trackingEndedLabel.text = "Tracking ended"
    }
}

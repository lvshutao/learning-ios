import UIKit

/**
 https://stackoverflow.com/questions/4660371/how-to-add-a-touch-event-to-a-uiview/32480721#32480721
 
 Tap: UITapGestureRecognizer
 Long Touch: UILongPressGestureRecognizer
 Pan: UIPanGestureRecognizer : moveing your finger across the screen
 Swipe: UISwipeGestureRecognizer : moving finger quickly
 Pinch: UIPinchGestureRecognizer : moving two fingers together or apart - usually to zoom
 Rotate: UIRotationGestureRecognizer : moving two fingers in a circular direction
 */
class Gesture: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(recognizer)
        
        // 双击
        let doubleTaspGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTaspGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTaspGesture)
        
        // 长按
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        view.addGestureRecognizer(longPressGesture)
        
        // pan
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
//        view.addGestureRecognizer(panGesture) // 太频繁了
        
        // swipe
        let swipeRightGuest = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRightGuest.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(swipeRightGuest)
        
        let swipeLeftGuest = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeftGuest.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(swipeLeftGuest)
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        print("tap working")
        
        // 获取点击位置
        if recognizer.state == UIGestureRecognizer.State.recognized {
            print( recognizer.location(in: recognizer.view ))
        }
    }
    
    @objc func handleDoubleTap() {
        print("double tap")
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            print("long press")
        }
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        print("pan")
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        print("swipe recognized")
        
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            print("swipe right")
        } else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            print("swipe left")
        }
    }
}

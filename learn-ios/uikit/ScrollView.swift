import UIKit

/**
 重要的概念
 1. UIScrollView should only use one subview, it hold erverthing you wish to scroll
 2. Make the content view and the scroll view's parent have equal heights for horizontal scrolling
 (Equal widths for vertical scrolling)
 3. Make sure that all of the scrollable content has a set width and is pinned on all sides
 
 步骤
 1. 将 UIScrollView 订到 root view 的四边
 2. 为 uIScrollView 添加一个子 UIView —— 只能添加1个 —— 设置 Equal Width/Height
 
 |-- View Controller
 |-- Main View
 |-- Scroll View
 |-- Content View —— Equal Widths - ContentView - Main View
 |-- 其它组件
 */
// https://www.appcoda.com/uiscrollview-introduction/
// 1. 缩放时居中显示
// 2. 双击时自动放大缩小

class ScrollView: UIViewController {
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "big"))
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = imageView.bounds.size // 必须大于 view.bounds，否则内部不可拖动
        scrollView.autoresizingMask = .flexibleWidth // .flexibleHeight
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // 默认情况下，origin (0, 0)，可通过 contentOffset 修改
        scrollView.contentOffset = CGPoint(x: 100, y: 200)
        
        useZoom()
        
        setupGestureRecognizer()
    }
}

// 缩放
extension ScrollView: UIScrollViewDelegate {
    
    // 代理方法
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // 提供缩放功能，同时解决缩放宽高比例
    func useZoom() {
        scrollView.delegate = self
        
        // 如果只是简单地使用下面的緂和方式，则可能会造成缩放后，图像太小，背景黑色都出来了
        //        scrollView.minimumZoomScale = 0.1
        //        scrollView.maximumZoomScale = 4.0
        //        scrollView.zoomScale = 1.0
        
        // 计算缩放因子，确保最小缩到合适的一边
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        print("widthScale:\(widthScale); heightScale:\(heightScale)")
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.zoomScale = 1.0
    }
    
    // 代理方法：解决缩放后位置中间 —— called after every zoom action
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        // 居中
        let verticalPadding = imageViewSize.height < scrollViewSize.height
            ? ( scrollViewSize.height - imageViewSize.height ) / 2
            : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width
            ? ( scrollViewSize.width - imageViewSize.width ) / 2
        : 0
        
        scrollView.contentInset = UIEdgeInsets(
            top: verticalPadding,
            left: horizontalPadding,
            bottom: verticalPadding,
            right: horizontalPadding)
    }
}
// 双击（双指）实现 zoom in and out，通常有两种行为
// 1. 双击放大到指定的最大比例，再双需缩小到最小比例

extension ScrollView {
    func setupGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }
    
    @objc func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
}

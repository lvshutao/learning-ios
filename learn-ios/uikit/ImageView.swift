import UIKit

class ImageView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        maskLayer()
        
        maskWithLabel()
        
        maskCircle()
        // 另外的示例，在 ImageView 中
        
        withAnimating()
        
        withColor()
        
        withResizeImage()
        
        withScaleAndCrop()
    }
}

extension ImageView {
    
    func createImageView(x:CGFloat, y:CGFloat) -> UIImageView? {
        if let image = UIImage(named: "01") {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: x, y: y, width: image.size.width / 2, height: image.size.height / 2)
            self.view.addSubview(imageView)
            return imageView
        } else {
            print("01 image not found")
            return nil
        }
    }
    
    // 遮罩
    func maskWithLabel() {
        // https://stackoverflow.com/questions/36758946/reverse-layer-mask-for-label
        if let imageView = createImageView(x: 10, y: 30) {
            let label = UILabel()
            label.text = "Some Text"
            label.frame = imageView.bounds
            
            imageView.mask = label
            imageView.clipsToBounds = true
        }
        
    }
    // https://stackoverflow.com/questions/4735623/uilabel-layer-cornerradius-negatively-impacting-performance/6254531#6254531
    // 因为图片本来就不是正方形，所以显示效果不会是圆形
    func maskCircle() {
        if let imageView = createImageView(x: 20, y: 180) {
            imageView.layer.cornerRadius = imageView.frame.height / 2
            imageView.layer.shouldRasterize = true
            imageView.clipsToBounds = true
        }
    }
    
    // 背景图，应用原理跟 maskCircle 一样
    // https://www.jianshu.com/p/493b4813e62d
    func maskLayer() {
        if let image = UIImage(named: "01") {
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: 0, width:self.view.bounds.size.width, height: self.view.bounds.size.height)
            layer.contents = image.cgImage
            
            self.view.layer.addSublayer(layer)
        }
    }
    
    // https://stackoverflow.com/questions/4804649/what-is-the-mode-property-in-interface-builder-which-offers-scale-to-fill/32151862#32151862
    // 图片的适应模式
    
    
    // 图片动画
    // Please note that this's not a very efficient way to create animations: it's quite slow and resource-consuming.
    // Consider using Layers or Sprites for better results
    // 搜索：ios calayer
    func withAnimating() {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 240, width: 70, height: 70))
        self.view.addSubview(imageView)
        
        imageView.animationImages = [
            UIImage(named: "af")!,
            UIImage(named: "al")!,
            UIImage(named: "ar")!,
            UIImage(named: "au")!,
            UIImage(named: "az")!,
            UIImage(named: "be")!,
            UIImage(named: "bo")!,
            UIImage(named: "br")!
        ]
        
        imageView.animationDuration = 16
        imageView.animationRepeatCount = 1
        imageView.startAnimating();
        //        imageView.stopAnimating();
    }
    
    // 修改图片的颜色 —— 变成红色的图片了？原图消失
    func withColor() {
        if let imageView = createImageView(x: 50, y: 300) {
            
            imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = UIColor.red
        }
    }
    
    func withResizeImage() {
        if let image = UIImage(named: "01") {
            // https://stackoverflow.com/questions/17285103/what-is-cginterpolationquality
            let newImage = image.resizeImage(size: CGSize(width: 50, height: 80), quality: .low)
            
            let imageView = UIImageView(frame: CGRect(x: 50, y: 400, width: 50, height: 80))
            imageView.image = newImage
            self.view.addSubview(imageView)
        }
    }
    
    func withScaleAndCrop() {
        if let image = UIImage(named: "01") {
            let newImage = image.circleScaleAndCropImage(frame: CGRect(origin: .zero, size: CGSize(width: image.size.width / 3, height: image.size.height / 3)))
            
            let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 80, y: 420), size: newImage!.size))
            imageView.image = newImage
            self.view.addSubview(imageView)
        }
    }
}

extension UIImage {
    // 缩放
    // https://stackoverflow.com/questions/39950125/how-do-i-draw-on-an-image-in-swift
    // https://stackoverflow.com/questions/32612760/resize-image-without-losing-quality
    func resizeImage(size:CGSize, quality:CGInterpolationQuality) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = quality
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
        
    }
    
    // https://medium.com/ymedialabs-innovation/resizing-techniques-and-image-quality-that-every-ios-developer-should-know-e061f33f7aba
    func resizeUI(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
    
    // cut a UIImage into a circle
    func circleScaleAndCropImage(frame: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: frame.size.width, height: frame.size.height), false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        // get the width and heights
        let imageWidth = self.size.width
        let imageHeight = self.size.height
        let rectWidth = frame.size.width
        let rectHeight = frame.size.height
        
        // 计算缩放因子
        let scaleFactorX = rectWidth / imageWidth
        let scaleFactorY = rectHeight / imageHeight
        
        // 计算圆心
        let imageCenterX = rectWidth / 2
        let imageCenterY = rectHeight / 2
        // 创建路径
        let radius = rectWidth / 2
        context?.beginPath()
        context?.addArc(center: CGPoint(x: imageCenterX, y: imageCenterY), radius: radius, startAngle: 0, endAngle: CGFloat(2 * Float.pi), clockwise: false)
        context?.closePath()
        context?.clip()
        
        context?.scaleBy(x: scaleFactorX, y: scaleFactorY)
        
        // draw image
        let myRect = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        self.draw(in: myRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

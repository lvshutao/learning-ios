import UIKit

class Image: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        withImageName()
        
        withUIColor()
        
        withContentFile()
        
        // 图片的比较，使用 image1.isEqual(image2)
        
        // 渐变色
        withGradient()
        
        // 快照：可以用来对地图进行截图
        takeSnapshotOfUIView()
        
        // 为图片添加颜色（将图片转为另外一种色调）
        maskWithColor()
        
        withBase64()
        
        // 在图片上应用颜色，然后贴到其它的视图上
        withUIColorToView()
        
        // 按钮图片
        resizableImageWithCaps()
        
        // 字符串转图片（很少用、略）
    }
}

extension Image {
    func withImageName() {
        let image = UIImage(named: "af")
        // 在 OC 中，imageName 会缓存图片，因此使用它加载大图片时要注意，很空间就造成低内存
        // 大图片需要使用 imageWithContentsOfFile 加载图片
        let imageView = UIImageView(frame: CGRect(x: 30, y: 30, width: image!.size.width, height: image!.size.height))
        imageView.image = image
        self.view.addSubview(imageView)
    }
    
    func withUIColor() {
        let color = UIColor.red
        let size = CGSize(width: 200, height: 200)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(origin: .zero, size: size))
        
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageView = UIImageView(frame: CGRect(x: 20, y: 80, width: 200, height: 200))
        imageView.image = colorImage
        self.view.addSubview(imageView)
    }
    
    // 将图片应用到 UIImageView.tintColor, UIButton
    func withUIColorToView() {
        if let image = UIImage(named: "bdlogo") {
            image.withRenderingMode(.alwaysTemplate)
            
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: 150, y: 10, width: image.size.width / 3, height: image.size.height / 3)
            btn.setImage(image, for: .normal)
            btn.imageView?.tintColor = UIColor.green // change image color of UIButton to green ------ 没有效果
            
//            if let imageView = btn.imageView {
//                imageView.image = image
//                imageView.tintColor = UIColor.green
//            } else {
//                print("not found image view")
//            }
            
            self.view.addSubview(btn)
        } else {
            print("bdlogo not found")
        }
        
    }
    
    func withContentFile() {
        // 使用无缓存的
        if let uncacheImage = getUncachedImage("az.png") {
            let imageView = UIImageView(frame: CGRect(
                x: 10,
                y: 150,
                width: uncacheImage.size.width / 2,
                height: uncacheImage.size.height / 2))
            imageView.image = uncacheImage
            self.view.addSubview(imageView)
        } else {
            print("image not found")
        }
    }
    
    // 无法获取 Assets 下的图片文件
    // 可能需要在 build Parse 中将资源文件复制过去
    func getUncachedImage(_ name:String) -> UIImage? {
        //        let stringPath = Bundle.main.path(forResource: "input", ofType: "txt")
        //        let urlPath = Bundle.main.url(forResource: "input", withExtension: "txt")
        if let imgPath = Bundle.main.path(forResource: name, ofType: nil) {
            return UIImage(contentsOfFile: imgPath)
        }
        return nil
    }
    
    func withGradient() {
        let image = UIImage.gradientImageWithBounds(
            CGRect(x: 0, y: 0, width: 200, height: 200),
            colors:[
                UIColor.yellow.cgColor, UIColor.blue.cgColor
            ])
        let imageView = UIImageView(frame: CGRect(x: 15, y: 280, width: 200, height: 200))
        imageView.image = image
        self.view.addSubview(imageView)
    }
    
    func takeSnapshotOfUIView() {
        let image = view.takeScreenshot()
        let imageView = UIImageView(frame: CGRect(x: 20, y: 500, width: 100, height: 100))
        imageView.image = image
        self.view.addSubview(imageView)
    }
    
    func maskWithColor() {
        let image = UIImage(named: "01")
        let testImage = image?.maskWithColor(color: UIColor.blue)
        let imageView = UIImageView(frame: CGRect(x: 30, y: 600, width: 50, height: 50))
        imageView.image = testImage
        self.view.addSubview(imageView)
    }
    
    func withBase64() {
        let google64 = "data:image/png;base64,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"
        
        if let image = ConvertBase64StriungToImage(imageBase64String: google64) {
            let imageView = UIImageView(frame: CGRect(x: 80, y: 80, width: 100, height: 30))
            imageView.image = image
            self.view.addSubview(imageView)
        } else {
            print("google image 64 fail")
        }
    }
    // base64 字符串转图片
    // https://stackoverflow.com/questions/52674591/base64-string-to-uiimage
    func ConvertBase64StriungToImage(imageBase64String:String) -> UIImage? {
        if let url = URL(string: imageBase64String) {
            do {
                let imageData = try Data(contentsOf: url)
                let image = UIImage(data: imageData)
                return image
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    // 图片局部拉伸，类似微信右上角的按钮组
    // https://www.cnblogs.com/yffswyf/p/6841254.html
    func resizableImageWithCaps() {
        
        if let image = UIImage(named: "btncap") {
            // 取中间一个点
            let midX = image.size.width / 2
            let midY = image.size.height / 2
            let newImage = image.resizableImage(withCapInsets: UIEdgeInsets(top: midY, left: midX, bottom: midY, right: midX), resizingMode: .stretch)
            
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: 200, y: 110, width: 80, height: 300 )
            btn.setBackgroundImage(newImage, for: .normal)
            btn.setTitle("点我", for: .normal)
            self.view.addSubview(btn)
        } else {
            print("btncap not found")
        }
    }
    
}


extension UIImage {
    // 渐变色
    static func gradientImageWithBounds(_ bounds: CGRect, colors:[CGColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    // UIImage Color
    // https://stackoverflow.com/questions/31803157/how-can-i-color-a-uiimage-in-swift
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = self.cgImage!
        let width = self.size.width
        let height = self.size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let bitmapContext = CGContext(
            data: nil,
            width: Int(width),
            height: Int(height),
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue)!

        bitmapContext.clip(to: bounds, mask: maskImage)
        bitmapContext.setFillColor(color.cgColor)
        bitmapContext.fill(bounds)
        
        if let cgImage = bitmapContext.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
}

// 快照
// https://stackoverflow.com/questions/31582222/swift-take-sceenshot-of-a-uiview
extension UIView {
    func takeScreenshot() -> UIImage {
        if #available(iOS 10.0, *) {
            return UIGraphicsImageRenderer(size: bounds.size).image(actions: { _ in
                drawHierarchy(in: CGRect(origin: .zero, size: bounds.size), afterScreenUpdates: true)
            })
        }
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // and finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil) {
            return image!
        }
        return UIImage()
    }
}

import UIKit

// https://developer.apple.com/documentation/uikit/uicolor
// https://www.materialui.co/colors
/*
 ----- RGB alpha
 black  0, 0, 0, 1
 blue   0, 0, 1, 1
 brown  0.6, 0.4, 0,2 1
 clear  0, 0, 0, 0
 cyan   0, 1, 1, 1
 darkGray   1/3, 1/3, 1/3 , 1
 gray   0.5, 0.5, 0.5, 1
 green  0, 1, 0, 1
 lightGray  2/3, 2/3, 2/3, 1
 magenta    1, 0, 1, 1
 orange 1, 0.5, 0, 1.0
 purple 0.5, 0, 0.5, 1
 red    1.0, 0, 0, 1
 white  1, 1, 1, 1
 yellow 1, 1, 0, 1
 */
class Color: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        
        let hsba = UIColor(hue: 0.4, saturation: 0.3, brightness: 0.7, alpha: 1)
        createRectange(x: 20, y: 30, color: hsba, text: "hsba")
        // RGBA
        let rgba = UIColor(red: 30.0/255, green: 70.0/255, blue: 200.0/255, alpha: 1.0)
        createRectange(x: 20, y: 60, color: rgba,text:  "rgba")
        
        // patter image
        let pattern = UIColor(patternImage: UIImage(named: "01")!)
        createRectange(x: 20, y: 90, color: pattern, text:  "pattern")
        
        // hexadecimal number
        let hex = UIColor(hex: 0xff00cc, alpha: 1.0)
        createRectange(x: 20, y: 120, color: hex, text: "hex")
        
        let hexa1 = UIColor(hexCode:"#80F1FF33")
        createRectange(x: 20, y: 150, color: hexa1, text: "hexa1")
        
        let hexa2 = UIColor(hexCode: "#A13D6F")
        createRectange(x: 150, y: 150, color: hexa2, text:"hexa2")
        
        let hexa3 = UIColor(hexCode: "#F12")
        createRectange(x: 280, y: 150, color: hexa3, text: "hexa3")
        
        // with alpha component
        let alphacomponent = UIColor.red.withAlphaComponent(0.5)
        createRectange(x: 20, y: 180, color: alphacomponent, text: "a com")
        
        createRectange(x: 20, y: 210, color: rgba, text: "origin")
        if let darkerColor = rgba.darkerColorForColor() {
            createRectange(x: 150, y: 210, color: darkerColor, text: "darker")
        }
        if let lighterColor = rgba.lighterColorForColor() {
            createRectange(x: 280, y: 210, color: lighterColor, text: "lighter")
        }
    }
    
    func createRectange(x:CGFloat, y:CGFloat, color:UIColor, text:String) {
        let view = UIView(frame: CGRect(x: x, y: y, width: 80, height: 20))
        view.backgroundColor = color
        let label = UILabel(frame: view.bounds)
        label.text = text
        view.addSubview(label)
        self.view.addSubview(view)
    }
}


extension UIColor {
    // hexadecimal
    convenience init(hex: Int, alpha:CGFloat = 1.0) {
        let r = CGFloat((hex >> 16) & 0xff) / 255
        let g = CGFloat((hex >> 08) & 0xff) / 255
        let b = CGFloat((hex >> 00) & 0xff) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hexCode:String) {
        let hex = hexCode.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        print("hexCode:\(hexCode); hex:\(hex)")
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        print("count:\(hex.count),\(a):\(r):\(g):\(b)")
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha:
            CGFloat(a) / 255)
    }
    // 更深的颜色
    func darkerColorForColor() -> UIColor? {
        var r = CGFloat(), g = CGFloat(), b = CGFloat(), a = CGFloat()
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: max(r-0.2, 0.0), green: max(g - 0.2, 0.0), blue: max(b-0.2, 0.0), alpha: a)
        }
        return nil
    }
    
    // 更浅的颜色
    func lighterColorForColor() -> UIColor? {
        var r = CGFloat(), g = CGFloat(), b = CGFloat(), a = CGFloat()
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: min(r+0.2, 1.0), green: min(g+0.2, 1.0), blue: min(b+0.2, 1.0), alpha: a)
        }
        return nil
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: CGFloat(arc4random()) / CGFloat(UInt32.max),
            green: CGFloat(arc4random()) / CGFloat(UInt32.max),
            blue: CGFloat(arc4random()) / CGFloat(UInt32.max),
            alpha:  1.0)
    }
}

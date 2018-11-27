import UIKit

/* 常见问题
 1. 圆角
 2. 文字宽度自适应
 */
class Button: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        
        /*
         UIButtonType.system：前面不带图标，默认文字颜色为蓝色，有触摸时的高亮效果
         UIButtonType.custom：定制按钮，前面不带图标，默认文字颜色为白色，无触摸时的高亮效果 (特别注意：文字颜色默认为白色)
         UIButtonType.contactAdd：前面带“+”图标按钮，默认文字颜色为蓝色，有触摸时的高亮效果
         UIButtonType.detailDisclosure：前面带“!”图标按钮，默认文字颜色为蓝色，有触摸时的高亮效果
         UIButtonType.infoDark：为感叹号“!”圆形按钮
         UIButtonType.infoLight：为感叹号“!”圆形按钮
         */
        let btnSystem = UIButton(type: .system)
        self.view.addSubview(btnSystem)
        btnSystem.frame = CGRect(x: 30, y: 40, width: 180, height: 40)
        btnSystem.setTitle("System 点我", for: .normal)
        
        
        // 默认白色文字看不见， 需要设置背景色
        // 默认 .center:居中对齐, .letf: 左对齐, .right:右对齐, .justified: 充满 view 来显示
        let btnCustom = UIButton(type: .custom)
        self.view.addSubview(btnCustom)
        btnCustom.frame = CGRect(x: 30, y: 80, width: 180, height: 40)
        btnCustom.setTitle("Custom", for: .normal)
        btnCustom.backgroundColor = UIColor.blue // 背景色（通常必须）
        
        
        
        let btnContactAdd = UIButton(type: .contactAdd)
        self.view.addSubview(btnContactAdd)
        btnContactAdd.frame = CGRect(x: 30, y: 120, width: 180, height: 40)
        btnContactAdd.setTitle("ContactAdd", for: .normal)
        btnContactAdd.backgroundColor = UIColor.green // 方便查看
        btnContactAdd.contentHorizontalAlignment = .left
        
        
        // 默认居中对齐
        let btnDetailDisclosure = UIButton(type: .detailDisclosure)
        self.view.addSubview(btnDetailDisclosure)
        btnDetailDisclosure.frame = CGRect(x: 30, y: 160, width: 180, height: 40)
        btnDetailDisclosure.setTitle("DetailDisclosure", for: .normal)
        btnDetailDisclosure.backgroundColor = UIColor.yellow
        
        
        let btnInfoDark = UIButton(type: .infoDark)
        self.view.addSubview(btnInfoDark)
        btnInfoDark.frame = CGRect(x: 30, y: 200, width: 180, height: 40)
        btnInfoDark.setTitle("InfoDark", for: .normal)
        btnInfoDark.backgroundColor = UIColor.lightGray
        // 水平方向上对齐：center, letf, right, fill；还有个垂直方向上
//        btnInfoDark.contentHorizontalAlignment = .fill // 这里只有图标 .infoDark 被拉伸，文字并没有被拉伸，可以跟 .infoLight 对比
        // 图片文字太长的处理方式
        // button.titleLabel?.lineBreakMode
        //        byTruncatingHead：省略头部文字，省略部分用...代替
        //        byTruncatingMiddle：省略中间部分文字，省略部分用...代替（默认）
        //        byTruncatingTail：省略尾部文字，省略部分用...代替
        //        byClipping：直接将多余的部分截断
        //        byWordWrapping：自动换行（按词拆分）
        //        byCharWrapping：自动换行（按字符拆分）
        
        let btnInfoLight = UIButton(type: .infoLight)
        self.view.addSubview(btnInfoLight)
        btnInfoLight.frame = CGRect(x: 30, y: 240, width: 180, height: 40)
        btnInfoLight.setTitle("InfoLight", for: .normal)
        btnInfoLight.backgroundColor = UIColor.yellow
        
        
        // 添加事件
        btnSystem.addTarget(self, action: #selector(someButtonAction), for: .touchUpInside)
        // 多状态 .normal 普通状态， highlighted 触摸状态， disabled 禁用状态
        btnSystem.setTitle("按住我", for: .highlighted)
        btnSystem.setTitleColor(UIColor.red, for: .highlighted) // 颜色
        btnSystem.setTitleShadowColor(UIColor.gray, for: .highlighted) // 阴影
        btnSystem.titleLabel?.font.withSize(20) // 字体大小
        
        // 图标按钮
        let btnIcon = UIButton(type: .custom)
        self.view.addSubview(btnIcon)
        btnIcon.backgroundColor = UIColor.green
        
        btnIcon.frame = CGRect(x: 30, y: 280, width: 180, height: 40)
        btnIcon.setImage(UIImage(named: "activity"), for: .normal)
        btnIcon.setImage(UIImage(named: "activity_active"), for: .highlighted)
        
        btnIcon.setTitleColor(UIColor.black, for: .normal) // custom 文字默认为白色，需要设置
        btnIcon.setTitle("旗帜", for: .normal)
        btnIcon.setTitle("旗帜", for: .highlighted)
        // 图标文字偏移量
        // 方法1：偏移图标
        btnIcon.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        // 方法2：偏移文字
        btnIcon.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        // 文字图片位置调换
        // 获取图标的 CGRect
        let imageSize = btnIcon.imageRect(forContentRect: btnIcon.frame)
        let titleFont = btnIcon.titleLabel?.font // 获取字体
        let titleSize = btnIcon.currentTitle!.size(withAttributes: [NSAttributedString.Key.font:titleFont!])
        btnIcon.titleEdgeInsets = UIEdgeInsets(top: 0, left:  -(imageSize.width * 2), bottom:0, right: 0)
        btnIcon.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width*2 + 10))
        
        print("按钮内部文本尺寸：\(btnIcon.intrinsicContentSize)")
        
        // 圆角 + 阴影
        let myBtn = UIButton(type: .custom)
        self.view.addSubview(myBtn)
        myBtn.layer.cornerRadius = 5.0
//        myBtn.layer.masksToBounds = true // 如果给 btn 设置了背景色，如果没有这句，那么 layer 就没有效果
        // masksToBounds 会影响渲染
        myBtn.layer.shadowColor = UIColor.black.cgColor
        myBtn.layer.shadowRadius = 2
        myBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        myBtn.layer.shadowOpacity = 0.3
        myBtn.layer.backgroundColor = UIColor.blue.cgColor
        myBtn.layer.shouldRasterize = true
        
        let btnTitle = "圆角+阴影"
        myBtn.setTitle(btnTitle, for: .normal)
        // https://stackoverflow.com/questions/6178545/adjust-uibutton-font-size-to-width
        // -------- 根据文字自适应
        myBtn.titleLabel?.numberOfLines = 1
        myBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        myBtn.titleLabel?.lineBreakMode = .byClipping
        // ---------
        myBtn.frame = CGRect(x: 30, y: 330, width: 100, height: 40)
        
    }
    
    @objc func someButtonAction() {
        print("btn action")
    }
}

class AutoPaddingButton: UIButton {
    override var intrinsicContentSize: CGSize {
        get {
            let baseSize = super.intrinsicContentSize
            return CGSize(width: baseSize.width + 20, height: baseSize.height + 10)
        }
    }
}

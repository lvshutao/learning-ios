import UIKit

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
        btnSystem.frame = CGRect(x: 30, y: 40, width: 180, height: 40)
        btnSystem.setTitle("System 点我", for: .normal)
        self.view.addSubview(btnSystem)

        // 默认白色文字看不见， 需要设置背景色
        let btnCustom = UIButton(type: .custom)
        btnCustom.frame = CGRect(x: 30, y: 80, width: 180, height: 40)
        btnCustom.setTitle("Custom", for: .normal)
        self.view.addSubview(btnCustom)

        let btnContactAdd = UIButton(type: .contactAdd)
        btnContactAdd.frame = CGRect(x: 30, y: 120, width: 180, height: 40)
        btnContactAdd.setTitle("ContactAdd", for: .normal)
        self.view.addSubview(btnContactAdd)

        let btnDetailDisclosure = UIButton(type: .detailDisclosure)
        self.view.addSubview(btnDetailDisclosure)
        btnDetailDisclosure.frame = CGRect(x: 30, y: 160, width: 180, height: 40)
        btnDetailDisclosure.setTitle("DetailDisclosure", for: .normal)

        let btnInfoDark = UIButton(type: .infoDark)
        btnInfoDark.frame = CGRect(x: 30, y: 200, width: 180, height: 40)
        btnInfoDark.setTitle("InfoDark", for: .normal)
        self.view.addSubview(btnInfoDark)

        let btnInfoLight = UIButton(type: .infoLight)
        btnInfoLight.frame = CGRect(x: 30, y: 240, width: 180, height: 40)
        btnInfoLight.setTitle("InfoLight", for: .normal)
        self.view.addSubview(btnInfoLight)
        
        // 添加事件
        btnSystem.addTarget(self, action: #selector(someButtonAction), for: .touchUpInside)
        // 多状态 .normal 普通状态， highlighted 触摸状态， disabled 禁用状态
        btnSystem.setTitle("按住我", for: .highlighted)
        // 颜色
        btnSystem.setTitleColor(UIColor.red, for: .highlighted)
        // 阴影
        btnSystem.setTitleShadowColor(UIColor.gray, for: .highlighted)
        // 背景色
        btnCustom.backgroundColor = UIColor.blue
        // 字体大小
        btnSystem.titleLabel?.font.withSize(20)

//         图标按钮
        let btnIcon = UIButton(type: .custom)
        self.view.addSubview(btnIcon)
        
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
        
        // 对齐
        btnContactAdd.contentHorizontalAlignment = .left
        btnInfoDark.contentHorizontalAlignment = .fill
        
        // 图片文字太长的处理方式
        // button.titleLabel?.lineBreakMode
//        byTruncatingHead：省略头部文字，省略部分用...代替
//        byTruncatingMiddle：省略中间部分文字，省略部分用...代替（默认）
//        byTruncatingTail：省略尾部文字，省略部分用...代替
//        byClipping：直接将多余的部分截断
//        byWordWrapping：自动换行（按词拆分）
//        byCharWrapping：自动换行（按字符拆分）
    }

    @objc func someButtonAction() {
        print("btn action")
    }
}

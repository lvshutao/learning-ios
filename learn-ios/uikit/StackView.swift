import UIKit
// http://www.hangge.com/blog/cache/detail_1749.html
// http://www.hangge.com/blog/cache/detail_1758.html
/*
 UIStackView 是 UIView 的子类，它不能用来呈现自身的内容，而是用来约束子控件的一个控件
 UIStackView 提供了一个高效的接口用于平铺一行或一列的视图组合。
 对于嵌入到 StackView 的视图，我们不用再添加自动布局的约束了。
 Stack View 会管理这些子视图的布局，并帮我们自动布局约束。
 也就是说，这些子视图能够适应不同的屏幕尺寸。
 
 UIStackView 支持嵌套，我们可以将一个 Stack View 嵌套到另一个 Stack View 中，从而实现更为复杂的用户界面。
 使用 UIStackView 并不意味这不需要处理自动布局了。
 我们仍旧要定义一些布局约束来约束 Stack View。它只是帮我们节约了为每个 UI 元素创建约束的时间，同时它更容易的从布局中添加/删除一个视图。
 
 方法
 init(frame:CGRect)
 init(arrangedSubviews views:[UIView])
 arrangedSubviews: [UIViews] { get } 获得所有的子视图
 addArrangedSubview(view: UIView) 添加一个子视图
 removeArrangedSubview(view: UIView) 删除一个子视图
 insertArrangedSubjectView(view:UIView, at stackIndex:Int) 在指定的位置插入一个子视图
 
 属性
 * axis: 子视图的布局方式（水平、垂直）
 vertical 垂直
 horizontal 水平
 * alignment: 子视图的对齐方式
 fill 子视图填充
 leading 靠左对齐
 trailing 靠右对齐
 center 子视图中以中线为基准对齐
 top 顶部对齐
 bottom 底部对齐
 first Baseling 按第一个子视图中文字的第一行对齐
 last Baseline 按最后一个子视图中文字的最后一行对齐
 * distribution: 子视图的分布比例
 fill 默认分布方式
 fill Equally 每个子视图的高度或宽度保持一致
 fill Proportionally: StackView 自己计算它认为合适和的分布方式
 Equal Spacing: 每个子视图保持同等间隔的分布方式
 Equal Centering: 每个子视图中心线之间保持一致的分布方式
 * spacing: 子视图间的间距
 * isBaselineRelativeArrangement: 视图间的垂直间隙是否根据基线测量得到，默认 false
 * isLayoutMarginsRelativeArrangement: 平铺其管理的视图时是否要参照它的布局边距，默认 false
 */
class StackView: UIViewController {
    
    var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stackView = UIStackView()
        self.view.addSubview(stackView)
        
        stackView.spacing = 10 // 视图间隔
        stackView.distribution = .fillEqually // 子视图的高度或者宽度保持一致
        // 创建并添加内部视图
        let imageView1 = UIImageView(image: UIImage(named: "hzw01"))
        imageView1.contentMode = .scaleAspectFit
        imageView1.clipsToBounds = true
        stackView.addArrangedSubview(imageView1)
        
        let imageView2 = UIImageView(image: UIImage(named: "hzw02"))
        imageView2.contentMode = .scaleAspectFit
        imageView2.clipsToBounds = true
        stackView.addArrangedSubview(imageView2)
        
        let imageView3 = UIImageView(image: UIImage(named: "hzw03"))
        imageView3.contentMode = .scaleAspectFit
        imageView3.clipsToBounds = true
        stackView.addArrangedSubview(imageView3)
        
        self.stackView = stackView
    }
    
    // 将要对子视图布局时调用
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let padding:CGFloat = 10
        
        // 横坚屏判断
        let orientation = UIApplication.shared.statusBarOrientation
        
        // 如果是竖屏
        if UIInterfaceOrientation.portrait == orientation {
            stackView.frame = CGRect(
                x: padding,
                y: 64 + padding,
                width: view.frame.width - padding * 2,
                height: view.frame.height - 64 - padding * 2)
            stackView.axis = .vertical // 垂直排序
        } else {
            stackView.frame = CGRect(
                x: padding,
                y: 32 + padding,
                width: view.frame.width - padding * 2,
                height: view.frame.height - 32 - padding * 2)
            stackView.axis = .horizontal
        }
    }
}

import UIKit

/*
 WKWebView 相比于 UIWebView, 将原本的设计拆分成14个类，和3个代理协议
 
 * WKWebView的内存远远没有UIWebView的开销大,而且没有缓存
 * 拥有高达60FPS滚动刷新率及内置手势
 * 支持了更多的HTML5特性
 * 高效的app和web信息交换通道
 * 允许JavaScript的Nitro库加载并使用,UIWebView中限制了
 * WKWebView目前缺少关于页码相关的API
 * 提供加载网页进度的属性
 
 https://tomoya92.github.io/2018/07/05/swift-webview-javascript/
 */
import WebKit
class WebView: UIViewController {
    
    lazy var webView: WKWebView = {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        // 给 webView 与 swift 交互起一个名字：AppModel, webview 给 swift 发消息的时候会用f到时
        configuration.userContentController.add(self, name: "AppModel")
        
        var webView = WKWebView(frame: self.view.frame, configuration: configuration)
        // 翻动有回弹效果
        webView.scrollView.bounces = true
        // 只允许上下滚动
        webView.scrollView.alwaysBounceVertical = true
        webView.navigationDelegate = self
        
        return webView
    }()
    
    // 确保 demo.html 已经在 copy bundles 中
    let HTML = try! String(contentsOfFile: Bundle.main.path(forResource: "demo", ofType: "html")!, encoding: .utf8)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "WebViewJS 交互 Demo"
        view.addSubview(webView)
        
        webView.loadHTMLString(HTML, baseURL: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// 判断页面加载完成，只有在页面加载完成了，才能在 swift 中调用 webview 中的 js 方法
extension WebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("sayHello('你好，世界!')") { (result, err) in
            print(result ?? "result default", err ?? "err default")
        }
    }
}

// 在 webview 中给 swift 发消息时，要用到的协议中的一个方法来接收
extension WebView: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }
}

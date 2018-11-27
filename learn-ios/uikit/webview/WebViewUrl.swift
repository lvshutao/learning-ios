import UIKit
import WebKit

/*
 https://gist.github.com/acallaghan/f9529ec4252a8bbb0579
 https://zhuanlan.zhihu.com/p/25154278
 
 https://moxo.io/blog/2017/04/19/ios-and-javascript-3-wkwebview/
 */
class WebViewUrl: UIViewController, WKNavigationDelegate {
    var webView: WKWebView?
    
    override func loadView() {
        super.loadView()
        
        self.webView = WKWebView(frame: self.view.frame)
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFromUrl()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension WebViewUrl {
    func loadFromUrl() {
        self.webView!.load(URLRequest(url: URL(string: "https://www.baidu.com")!))
    }
    
    // 问题：可能乱码
    // https://www.jianshu.com/p/dc9b14240acf
    func loadDocument() {
        // 加载 Document files like .pdf, .txt, .doc etc
        if let localFilePath = Bundle.main.path(forResource: "demo", ofType: "txt") {
            print("load demo.txt")
            let fileURL = URL(fileURLWithPath: localFilePath)
            webView?.loadFileURL(fileURL, allowingReadAccessTo: fileURL)
        } else {
            print("txt not found")
        }
    }
    
//    func loadData() {
//        if let localFilePath = Bundle.main.path(forResource: "demo", ofType: "txt") {
//            let url = URL(fileURLWithPath: localFilePath)
//            let data = NSData(contentsOf: url)
//
//            webView?.load(data! as Data, mimeType: "application/txt", characterEncodingName: "UTF-8", baseURL: URL())
//        }
//    }
}

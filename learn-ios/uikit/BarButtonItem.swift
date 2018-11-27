import UIKit
/**
 Parameter  Description
 title      标题
 style      样式
            custom
            Add, Edit, Done, Cancel, Save, Undo, Redo
            Compose, Reply, Action, Organize, Trash
            Bookmarks, Search, Refresh, Stop
            Camera
            Play, Pause, Rewing, Fast Forward
            Page Curl
 target     接收操作的对象
 action     点击事件
 */

// 添加在 Navigation Controller 上

class BarButtonItem: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a UIBarButtonItem
        let bbi = UIBarButtonItem(title: "Greetings!", style: .plain, target: self, action: #selector(itemTap))
        self.navigationItem.rightBarButtonItem = bbi
    }
    
    @objc func itemTap(barButtonItem: UIBarButtonItem) {
        print("tap")
    }
}

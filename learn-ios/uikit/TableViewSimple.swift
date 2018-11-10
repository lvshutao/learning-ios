// 往视图添加一个简单的 UITableView

import UIKit


class TableViewSimple : UIViewController {
    private let myArray:NSArray = ["First", "Second", "Third"]
    // 定义 UITableView
    private var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let barHeight:CGFloat = UIApplication.shared.statusBarFrame.size.height
//        let displayWidth: CGFloat = self.view.frame.width
//        let displayHeight:CGFloat = self.view.frame.height
//        
//        myTableView = UITableView(frame: CGRect(
//            x: 0,
//            y: barHeight,
//            width: displayWidth,
//            height: displayHeight - barHeight
//        ))
        
        myTableView = UITableView(frame: self.view.frame)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
}

extension TableViewSimple: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        return cell
    }
}



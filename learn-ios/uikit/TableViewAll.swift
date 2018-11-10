import UIKit

// 综合
class TableViewAll : UIViewController {
    private var myArray:[[String]] = [
        ["First", "Second", "Third"],
        ["First 2", "Second 2", "Third 2"]
    ]

    // 定义 UITableView
    private var myTableView: UITableView!
    
    // 添加上拉下拉刷新
    // https://cocoacasts.com/how-to-add-pull-to-refresh-to-a-table-view-or-collection-view
    // https://github.com/CRAnimation/CRRefresh
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView = UITableView(frame: self.view.frame)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        
        // 取消全部的分隔线
//        myTableView.separatorStyle = .none
        // 隐藏空单元格的分隔线，只需要为它们设置一个空 UIView 即可
        myTableView.tableFooterView = UIView()
        
        addRefresh()
    }
}

// 分隔线
extension TableViewAll: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return myArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)

        cell.textLabel!.text = "\(myArray[indexPath.section][indexPath.row])"

        // 修改指定单元格的分隔线
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
        }
        return cell
    }
}

extension TableViewAll {
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 88.0
        default:
            return 44.0
        }
    }
    
    // 修改分隔线的宽度（全屏）
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 1 {
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
}

// 头、脚
extension TableViewAll {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Header 0"
        default:
            return "Header"
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Footer 0"
        default:
            return "Footer"
        }
    }
    // 自定义表头视图，会覆盖掉 titleForHeaderInSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: myTableView.frame.size.width, height: 22))
        view.backgroundColor = UIColor.groupTableViewBackground
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        
        switch section {
        case 1:
            label.text = "Title"
            label.frame =  CGRect(
                x: 0,
                y: 0,
                width: view.frame.width / 2,
                height: view.frame.height)
            
            
            let more = UIButton(frame: CGRect(
                x: view.frame.width / 2,
                y: 0,
                width: view.frame.width / 2,
                height: view.frame.height))
            more.setTitle("More", for: .normal)
            view.addSubview(more)
        default:
            label.frame = CGRect.zero
        }
        
        view.addSubview(label)
        return view
    }
    // 表头高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 33
    }
}

// 编辑属性
extension TableViewAll {
    // 能否被删除或编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // 禁止选中效果
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // 无法选中（但是仍然能够被编辑）
        if indexPath.section == 0 && indexPath.row == 0 {
            return nil
        } else {
            return indexPath
        }
    }
    // 选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath)")
    }
    // 如何处理编辑或删除时的数据
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("\(indexPath)")
        switch editingStyle {
        case .insert:
            myArray[indexPath.section].append("Insert \(indexPath.row)")
            myTableView.insertRows(at: [indexPath], with: .automatic)
        case .delete:
            // 下面两行必须的，否则会 crash
            myArray[indexPath.section].remove(at:indexPath.row)
            myTableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            return
        }
    }
    // 编辑按钮样式: 会覆盖 editingStyle 的行为
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "编辑", handler: { [unowned self] action, indexPath in
            print("编辑:\(indexPath);\(self)")
        })
        editAction.backgroundColor = UIColor.blue
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "删除", handler: { [unowned self] action, indexpath in
            print("删除:\(indexPath);\(self)")
        })
        
        return [deleteAction, editAction]
    }
}

// UIRefreshContro

extension TableViewAll {
    
    func addRefresh() {
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            myTableView.refreshControl = refreshControl
        } else {
            myTableView.addSubview(refreshControl)
        }
        
        refreshControl.tintColor = UIColor(red: 0.25, green: 0.72, blue: 0.85, alpha: 1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetch Data...")
        refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        // 如果没有设置，则会产生 bug, refreshControl 会穿透 tableView
        // https://stackoverflow.com/questions/35391236/refreshcontrol-bugs-first-cell-of-tableview-after-using-back-on-navbar
        myTableView.backgroundView = refreshControl
    }
    
    @objc func pullToRefresh(_ sender:UIRefreshControl) {
        // 获取数据
        
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.myArray[1].append("Gogo...")
            self.myTableView.reloadData()
        }
    }
}

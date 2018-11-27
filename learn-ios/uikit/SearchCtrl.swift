import UIKit

/*
 UISearchController 参数
 .searchBar read-only
 .searchResultsUpdater
 .isActive
 .obscuresBackgroundDuringPresentation
 .dimsBackgroundDuringPresentation
 .hidesNavigationBarDuringPresentation
 .definesPresentationContext
 .navigationItem.titleView
 .tableView.tableHeaderView : Returns an accessory view that is displayed above the table in which a search bar can be placed
 */
/* Search Bar in Navigation Bar Title
 |-- navigation bar
 |-- search controller
 |-- table view
 */

// 1. 实现两个协议
class SearchCtrl: UITableViewController, UISearchResultsUpdating {
    
    let entries = [
        (title:"aaa", image:"hzw01"),
        (title:"abb", image:"hzw02"),
        (title:"abc", image:"hzw03")
    ]
    var searchResults: [(title:String, image:String)] = []
    // 2. 添加 search controller 属性
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // 3. 添加 search bar
        searchController.searchResultsUpdater = self
        // https://www.jianshu.com/p/0b3e18f58b33
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        // https://www.jianshu.com/p/b065413cbf57
        // 搜索框不与新推入的控制器（如果有）产生重叠
        self.definesPresentationContext = true
        
        // Place the search bar in the navigation item's title view
        self.tableView.tableHeaderView = searchController.searchBar
        // 偏移，默认不要显示搜索栏
        self.tableView.contentOffset = CGPoint(x: 0, y: searchController.searchBar.frame.height)
    }
    
    func filterContent(for searchText: String) {
        searchResults = entries.filter ({ (title:String, image:String) -> Bool in
            let match = title.range(of: searchText, options: .caseInsensitive)
            return match != nil
        })
    }
    // MARK: - UISearchResultsUpdating method
    // 4. 最后一步，实现此方法
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    // MARK: - UITableViewController methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchResults.count : entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if the search bar is active, use the searchResults data.
        let entry = searchController.isActive
            ? searchResults[indexPath.row]
            : entries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = entry.title
        cell.imageView?.image = UIImage(named: entry.image)
        return cell
    }
}

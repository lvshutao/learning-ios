import UIKit

/*
 ICollectionView是一种新的数据展示方式，简单来说可以把他理解成多列的UITableView(请一定注意这是UICollectionView的最最简单的形式)。
 https://www.jianshu.com/p/33b6fa5dc3da
 
 https://stackoverflow.com/questions/31735228/how-to-make-a-simple-collection-view-with-swift/31735229#31735229
 
 UICollectionView Tutorial Part 1: Getting Started
 https://www.raywenderlich.com/975-uicollectionview-tutorial-getting-started
 UICollectionView Tutorial Part 2: Reusable Views and Cell Selection
 http://www.raywenderlich.com/78551/beginning-ios-collection-views-swift-part-2
 */
class CollectionView: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    
    // 多个 collectionView
    var firstCollectionView:UICollectionView!
    let firstResueIdentifier = "horizontal"
    
    var secondCollectionView:UICollectionView!
    let secondResueIdentifier = "vertical"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = true
                makeVeritalCollectionView()
        makeHorizontalCollectionView()
    }
    
    func makeVeritalCollectionView() {
        // 设置 layout
        let verticalLayout = UICollectionViewFlowLayout()
        verticalLayout.scrollDirection = .vertical // 滚动方向
        // 统计设计每个 item 的大小，如果需要定制，则使用 sizeForItemAtIndexPath:indexPath:
        verticalLayout.itemSize = CGSize(width: (screenWidth - 30)/2, height: 80)
        
        // 其它
        // headerReferenceSize: CGSize
        // footerReferenceSize: CGSize
        // sectionInset: UIEdgeInsets
        
        // 设置 CollectionView
        secondCollectionView = UICollectionView(
            frame: CGRect(x: 0, y: 150, width: screenWidth, height: screenHeight - 150),
            collectionViewLayout: verticalLayout)
        
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        secondCollectionView.backgroundColor = UIColor.white
        // 注册
        secondCollectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: secondResueIdentifier)
        self.view.addSubview(secondCollectionView)
    }
    
    func makeHorizontalCollectionView() {
        let horizontalLayout = UICollectionViewFlowLayout()
        horizontalLayout.scrollDirection = .horizontal
        horizontalLayout.itemSize = CGSize(width: (screenWidth - 30)/3, height: 80)
        
        firstCollectionView = UICollectionView(
            frame: CGRect(x: 0, y: 22, width: screenWidth, height: 120),
            collectionViewLayout: horizontalLayout)
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        firstCollectionView.backgroundColor = UIColor.gray
        
        firstCollectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: firstResueIdentifier)
        self.view.addSubview(firstCollectionView)
    }
    
    // 执行批量更新
    // https://medium.com/flawless-app-stories/a-better-way-to-update-uicollectionview-data-in-swift-with-diff-framework-924db158db86
    func batchUpdates() {
        firstCollectionView.performBatchUpdates({
            var items:[String] = ["g", "h"] // 这里只是为了代码说明
            let indexPaths = Array(6...8).map { IndexPath(item: $0, section: 0)}
            firstCollectionView.insertItems(at: indexPaths)
            
            // 删除
            items.removeLast()
            items.removeLast()
            items.removeLast()
            let removeIndexPaths = Array(3...5).map { IndexPath(item: $0, section: 0)}
            firstCollectionView.deleteItems(at: removeIndexPaths)
            
            // 更新
            items[2] = "update"
            let updateIndexPath = IndexPath(item: 2, section: 0)
            firstCollectionView.reloadItems(at: [updateIndexPath])
            
            // 移动
            items.remove(at: 2)
            items.append("c")
            firstCollectionView.moveItem(at: IndexPath(item: 2, section: 0), to: IndexPath(item: 5, section: 0))
        }, completion: nil)
    }
}

extension CollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if  collectionView == firstCollectionView  {
//            print("bool: \(collectionView == firstCollectionView)")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: firstResueIdentifier, for: indexPath)
                as! MyCollectionViewCell
            let indexString = String(60 - indexPath.row)
            cell.myLabel.text = "水平小标题_" + indexString
            cell.myImageView.backgroundColor = UIColor.random()
            return cell;
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondResueIdentifier, for: indexPath)
            as! MyCollectionViewCell
        let indexString = String(indexPath.row)
        cell.myLabel.text = "垂直小标题_" + indexString
        cell.myImageView.backgroundColor = UIColor.random()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("you selected cell #\(indexPath.item)")
    }
    
    
    // 选中样式
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.red
    }
    // 取消选中
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.cyan
    }
}

extension CollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 1
    //    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 1
    //    }
}

class MyCollectionViewCell: UICollectionViewCell {
    var myLabel: UILabel = {
        let label =  UILabel()
        label.text = "我的小标题"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.myLabel.frame = CGRect(x: 10, y: 60, width: frame.size.width - 20, height: 20)
        self.myImageView.frame = CGRect(x: 10, y: 0, width: frame.size.width - 20, height: 60)
        
        //        self.contentView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.contentView.addSubview(self.myLabel)
        self.contentView.addSubview(self.myImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

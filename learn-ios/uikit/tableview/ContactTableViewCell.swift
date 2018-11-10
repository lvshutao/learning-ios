//
//  ContactTableViewCell.swift
//  learn-ios
//
//  Created by lvshutao on 2018/11/1.
//  Copyright © 2018 lvshutao. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    // MARK: 数据
    // 通常使用 didSet 来传递数据
    var contact:Contact? {
        didSet {
            guard let contactItem = contact else { return }
            if let name = contactItem.name {
                profileImageView.image = UIImage(named: name)
                nameLabel.text = name
            }
            if let jobTitle = contactItem.jobTitle {
                jobTitleDetailedLabel.text = " \(jobTitle)"
            }
            
            if let country = contactItem.country {
                countryImageView.image = UIImage(named: country)
            }
        }
    }
    
    // MARK: 组件
    // 左：头像
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    // 名称
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(red: 0.25, green: 0.27, blue: 0.3, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobTitleDetailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 1, green: 1, blue:1, alpha: 1)
        label.backgroundColor = UIColor(red: 0.243, green: 0.764, blue: 0.839, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // 中间：容器，用来包裹 nameLabel 和 jobTitleDetailedLabel
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // 子元素不要超过当前容器范围
        return view
    }()
    // 右边
    let countryImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 13
        img.clipsToBounds = true
        return img
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    // MARK: 初始化方法co
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 将各部分都存放到当前视图中
        self.contentView.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(jobTitleDetailedLabel)
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(countryImageView)
        
        // MARK: 组件约束
        // 头像：垂直
        profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        // 内容
        containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // nameLabel
        nameLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        
        jobTitleDetailedLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor).isActive = true
        jobTitleDetailedLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
//        jobTitleDetailedLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
//        jobTitleDetailedLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        
        countryImageView.widthAnchor.constraint(equalToConstant:26).isActive = true
        countryImageView.heightAnchor.constraint(equalToConstant:26).isActive = true
        countryImageView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-20).isActive = true
        countryImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

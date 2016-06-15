//
//  HomeViewCell.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/18.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {

    var titleImageView: UIImageView!
    var titleLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0;
        titleImageView = UIImageView()
        let btmLine = UIView()
        btmLine.backgroundColor = UIColor(red: 228/255.0, green: 228/255.0, blue: 228/255.0, alpha: 1)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleImageView)
        titleImageView.snp_makeConstraints { (make) in
            make.right.equalTo(self.snp_right).offset(-15)
            make.top.equalTo(self.snp_top).offset(10)
            make.bottom.equalTo(self.snp_bottom).offset(-10)
            make.width.equalTo(80)
        }
        
        self.contentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(15)
            make.right.equalTo(titleImageView.snp_left).offset(-10)
            make.top.equalTo(self.snp_top).offset(10)
        }
        
        self.contentView.addSubview(btmLine)
        btmLine.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(15)
            make.bottom.equalTo(self.snp_bottom).offset(-1)
            make.width.equalTo(ScreenWidth - 30)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

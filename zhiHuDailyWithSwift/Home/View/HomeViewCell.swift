//
//  HomeViewCell.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/18.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {

    @IBOutlet weak var titleImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let btmLine = UIView(frame: CGRectMake(15, 89, UIScreen.mainScreen().bounds.width - 30, 1))
        btmLine.backgroundColor = UIColor(red: 228/255.0, green: 228/255.0, blue: 228/255.0, alpha: 1)
        self.contentView.addSubview(btmLine)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

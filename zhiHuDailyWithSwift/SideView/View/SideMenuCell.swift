//
//  SideMenuCell.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/6/1.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit
import SnapKit

class SideMenuCell: UITableViewCell {

    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func congfigSileMenu(text: String, showLeftIcon: Bool) {
        contentLabel.text = text;
        leftImageView.hidden = !showLeftIcon
        if showLeftIcon {
            contentLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.snp_left).offset(10);
            })
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

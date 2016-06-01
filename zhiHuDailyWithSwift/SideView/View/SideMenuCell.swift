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
        
        //设置Cell UI的初始状态
        self.contentView.backgroundColor = UIColor(red: 12/255.0, green: 19/255.0, blue: 25/255.0)
        self.contentLabel.textColor = UIColor.whiteColor()
        self.leftImageView.image = UIImage(named: "home")!.imageWithRenderingMode(.AlwaysTemplate)
        self.leftImageView.tintColor = UIColor.whiteColor()
        self.rightImageView.image = UIImage(named: "switch")!.imageWithRenderingMode(.AlwaysTemplate)
        self.rightImageView.tintColor = UIColor(red: 66/255.0, green: 72/255.0, blue: 77/255.0)
        //设置Cell被选中的背景view及字体颜色
        let selectedView = UIView(frame: self.contentView.frame)
        selectedView.backgroundColor = UIColor(red: 12/255.0, green: 19/255.0, blue: 25/255.0)
        self.selectedBackgroundView = selectedView
        self.contentLabel.highlightedTextColor = UIColor.whiteColor()
    }
    
    func congfigSileMenu(text: String, indexPath:NSIndexPath) {
        let isShowLeftIcon = indexPath.row == 0 ? false : true;
        leftImageView.hidden = isShowLeftIcon
        if isShowLeftIcon {
            //设置未选中状态下的Cell UI
            self.contentView.backgroundColor = UIColor(red: 19/255.0, green: 26/255.0, blue: 32/255.0)
            self.contentLabel.textColor = UIColor(red: 136/255.0, green: 141/255.0, blue: 145/255.0)
            
            contentLabel.snp_updateConstraints(closure: { (make) in
                make.left.equalTo(self.snp_left).offset(15);
            });
        }
        contentLabel.text = text;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

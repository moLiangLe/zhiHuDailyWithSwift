//
//  MLCollectionViewCell.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/19.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

public class MLCollectionViewCell: UICollectionViewCell {
    
    // MARK: Stored Properties
    public let imageView: UIImageView = UIImageView()
    public var titleLabelHeight: CGFloat = 0
    public var hasConfigured: Bool = false
    private let titleLabel: UILabel = UILabel()
    
    // MARK: Computed Properties
    public var title: String {
        set { titleLabel.text = "   \(newValue)"}
        get { return titleLabel.text!}
    }
    public var titleLabelTextColor: UIColor {
        set { titleLabel.textColor = newValue }
        get { return titleLabel.textColor }
    }
    public var titleLabelTextFont: UIFont {
        set { titleLabel.font = newValue}
        get { return titleLabel.font}
    }
    public var titleLabelBackgroundColor: UIColor {
        set { titleLabel.backgroundColor = newValue }
        get { return titleLabel.backgroundColor! }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
        let titleLabelW = self.width;
        let titleLabelH = self.titleLabelHeight;
        let titleLabelX: CGFloat = 0;
        let titleLabelY = self.heiht - titleLabelH;
        titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
        titleLabel.hidden = titleLabel.text != nil ? false : true;
    }
    
    func congfigCell(titleLabelTextColor: UIColor?, titleLabelTextFont: UIFont?, titleLabelBackgroundColor: UIColor?, titleLabelHeight: CGFloat = 0) {
        self.titleLabel.textColor = titleLabelTextColor
        self.titleLabel.font = titleLabelTextFont
        self.titleLabel.backgroundColor = titleLabelBackgroundColor
        self.titleLabelHeight = titleLabelHeight
        self.hasConfigured = true
    }
    
}



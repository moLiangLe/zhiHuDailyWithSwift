//
//  MLGradientView.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/22.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

enum MLGradientViewType {
    case Transparent
    case Color
    case TransparentTwice
    case TransparentOther
}

class MLGradientView: UIView {
    
    var type: MLGradientViewType? {
        didSet{
            if let type = type  {
                switch type {
                case .Transparent:
                    insertTransparentGradient()
                    break
                case .Color:
                    insertColorGradient()
                    break
                case .TransparentTwice:
                    insertTwiceTransparentGradient()
                    break
                case .TransparentOther:
                    insertAnotherTransparentGradient()
                    break
                }
            }
        }
    }
    
    convenience init(frame: CGRect, type:MLGradientViewType) {
        self.init(frame: frame)
        self.type = type
    }
    
    func insertTransparentGradient() {
        let colorOne = UIColor(red: (0/255.0), green: (0/255.0), blue: (0/255.0), alpha: 0.0)
        let colorTwo = UIColor(red: (0/255.0), green: (0/255.0), blue: (0/255.0), alpha: 1.0)
        let colors = [colorOne.CGColor, colorTwo.CGColor]
        let stopOne = NSNumber(float: 0.0)
        let stopTwo = NSNumber(float: 1.0)
        let locations = [stopOne, stopTwo]
        
        gradient(colors, locations:locations)
    }
    
    func insertColorGradient() {
        let colorOne = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 1.0)
        let colorTwo = UIColor(red: (33/255.0), green: (33/255.0), blue: (33/255.0), alpha: 1.0)
        let colors = [colorOne.CGColor, colorTwo.CGColor]
        
        let stopOne = NSNumber(float: 0.0)
        let stopTwo = NSNumber(float: 1.0)
        let locations = [stopOne, stopTwo]
        
        gradient(colors, locations:locations)
    }
    
    func insertTwiceTransparentGradient() {
        let colorOne = UIColor(red: (0/255.0), green: (0/255.0), blue: (0/255.0), alpha: 0.70)
        let colorTwo = UIColor(red: (0/255.0), green: (0/255.0), blue: (0/255.0), alpha:0.15)
        let colorThree = UIColor(red: (0/255.0), green: (0/255.0), blue: (0/255.0), alpha:0.15)
        let colorFour = UIColor(red: (0/255.0), green: (0/255.0), blue: (0/255.0), alpha:0.75)
        let colors = [colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, colorFour.CGColor]
        
        let stopOne = NSNumber(float: 0.0)
        let stopTwo = NSNumber(float: 0.20)
        let stopThree = NSNumber(float: 0.50)
        let stopFour = NSNumber(float: 1.0)
        let locations = [stopOne, stopTwo, stopThree, stopFour]
        
        gradient(colors, locations:locations)
    }
    
    func insertAnotherTransparentGradient() {
        let colorOne = UIColor(red: (19/255.0), green: (26/255.0), blue: (32/255.0), alpha: 0.0)
        let colorTwo = UIColor(red: (19/255.0), green: (26/255.0), blue: (32/255.0), alpha: 1.0)
        let colors = [colorOne.CGColor, colorTwo.CGColor]
        let stopOne = NSNumber(float: 0.0)
        let stopTwo = NSNumber(float: 1.0)
        let locations = [stopOne, stopTwo]
        
        gradient(colors, locations:locations)
    }
    
    private func gradient(colors: [CGColor], locations: [NSNumber]) {
        let headerLayer = CAGradientLayer()
        headerLayer.colors = colors;
        headerLayer.locations = locations;
        headerLayer.frame = self.bounds;
        
        self.layer.insertSublayer(headerLayer, atIndex: 0)
    }
    
}

//
//  UITableViewExtension.swift
//  MLExtension
//
//  Created by LCL on 16/4/24.
//  Copyright © 2016年 lclpro. All rights reserved.
//

import UIKit

extension UITableView {
    
    typealias UITableViewUpdateBlock = (UITableView) -> Void
    
    func updateWithBlock(block: UITableViewUpdateBlock) {
        beginUpdates()
        block(self)
        endUpdates()
    }
    
    func scrollToRow(row: Int, section: Int, scrollPosition: UITableViewScrollPosition, animated: Bool) {
        let indexPath = NSIndexPath(forRow: row, inSection: section)
        scrollToRowAtIndexPath(indexPath, atScrollPosition: scrollPosition, animated: animated)
    }
    
    func insertRowAtIndexPath(indexPath: NSIndexPath, rowAnimation:UITableViewRowAnimation) {
        insertRowsAtIndexPaths([indexPath], withRowAnimation: rowAnimation)
    }
    
    func insertRow(row: Int, section: Int, rowAnimation:UITableViewRowAnimation) {
        let indexPath = NSIndexPath(forRow: row, inSection: section)
        insertRowAtIndexPath(indexPath, rowAnimation: rowAnimation)
    }
    
    func reloadRowAtIndexPath(indexPath: NSIndexPath, rowAnimation:UITableViewRowAnimation) {
        reloadRowsAtIndexPaths([indexPath], withRowAnimation: rowAnimation)
    }
    
    func reloadRow(row: Int, section: Int, rowAnimation:UITableViewRowAnimation) {
        let indexPath = NSIndexPath(forRow: row, inSection: section)
        reloadRowAtIndexPath(indexPath, rowAnimation: rowAnimation)
    }
    
    func deleteRowAtIndexPath(indexPath: NSIndexPath, rowAnimation:UITableViewRowAnimation) {
        deleteRowsAtIndexPaths([indexPath], withRowAnimation: rowAnimation)
    }
    
    func deleteRow(row: Int, section: Int, rowAnimation:UITableViewRowAnimation) {
        let indexPath = NSIndexPath(forRow: row, inSection: section)
        deleteRowAtIndexPath(indexPath, rowAnimation: rowAnimation)
    }
    
    func insertSection(section: Int, rowAnimation:UITableViewRowAnimation) {
        let sections = NSIndexSet(index: section)
        insertSections(sections, withRowAnimation: rowAnimation)
    }
    
    func reloadSection(section: Int, rowAnimation:UITableViewRowAnimation) {
        let sections = NSIndexSet(index: section)
        reloadSections(sections, withRowAnimation: rowAnimation)
    }
    
    func deleteSection(section: Int, rowAnimation:UITableViewRowAnimation) {
        let sections = NSIndexSet(index: section)
        deleteSections(sections, withRowAnimation: rowAnimation)
    }

    func clearSelectedRows(animated: Bool) {
        if let indexs = indexPathsForSelectedRows {
            for index in indexs {
                deselectRowAtIndexPath(index, animated: animated)
            }
        } 
    }
    
}


//
//  DGTemplateLayoutCell.swift
//
//  Created by zhaodg on 11/24/15.
//  Copyright © 2015 zhaodg. All rights reserved.
//

import UIKit

// MARK: - UITableViewCell Extension
extension UITableViewCell {

    // MARK: - public
    /// Enable to enforce this template layout cell to use "frame layout" rather than "auto layout",
    /// and will ask cell's height by calling "-sizeThatFits:", so you must override this method.
    /// Use this property only when you want to manually control this template layout cell's height
    /// calculation mode, default to false.
    ///
    public var dg_isTemplateLayoutCell: Bool? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.DGisTemplateLayoutCell) as? Bool
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.DGisTemplateLayoutCell, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    /// Indicate this is a template layout cell for calculation only.
    /// You may need this when there are non-UI side effects when configure a cell.
    /// Like:
    ///   func configureCell(cell: DGFeedCell, atIndexPath indexPath: NSIndexPath) {
    ///       cell.loadData(item...)
    ///       if cell.fd_isTemplateLayoutCell == false {
    ///           self.notifySomething() // non-UI side effects
    ///       }
    ///   }
    ///
    public var dg_enforceFrameLayout: Bool? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.DGenforceFrameLayout) as? Bool
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.DGenforceFrameLayout, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    // MARK: - private
    private struct AssociatedKey {
        static var DGisTemplateLayoutCell = "DGisTemplateLayoutCell"
        static var DGenforceFrameLayout = "DGenforceFrameLayout"
    }
}
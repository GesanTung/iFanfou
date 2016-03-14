//
//  DGKeyedHeightCache.swift
//
//  Created by zhaodg on 11/25/15.
//  Copyright © 2015 zhaodg. All rights reserved.
//

import UIKit

// MARK: - DGHeightsDictionary
class DGHeightsDictionary {

    private var heights: [String: CGFloat] = [:]

    init() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceOrientationDidChange", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
    }

    // MARK: - public
    subscript(key: String) -> CGFloat? {
        get {
            return heights[key]
        }
        set {
            heights[key] = newValue
        }
    }

    internal func invalidateHeightForKey(key: String) -> CGFloat? {
        return self.heights.removeValueForKey(key)
    }

    internal func invalidateAllHeightCache() {
        return self.heights.removeAll()
    }

    internal func existsKey(key: String) -> Bool {
        return self[key] != nil
    }

    // MARK: - private
    @objc private func deviceOrientationDidChange() {
        self.invalidateAllHeightCache()
    }
}

// MARK: - UITableView Extension
extension UITableView {
    
    private struct AssociatedKey {
        static var DGkeyedHeightCache = "DGkeyedHeightCache"
    }

    /// Height cache by key. Generally, you don't need to use it directly.
    internal var dg_keyedHeightCache: DGHeightsDictionary {
        if let value: DGHeightsDictionary = objc_getAssociatedObject(self, &AssociatedKey.DGkeyedHeightCache) as? DGHeightsDictionary {
            return value
        } else {
            let cache: DGHeightsDictionary = DGHeightsDictionary()
            objc_setAssociatedObject(self, &AssociatedKey.DGkeyedHeightCache, cache, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return cache
        }
    }
}

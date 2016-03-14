//
//  DGIndexPathHeightCache.swift
//
//  Created by zhaodg on 11/25/15.
//  Copyright © 2015 zhaodg. All rights reserved.
//

import UIKit

// MARK: - DGIndexPathHeightCache
class DGIndexPathHeightCache {

    private var heights: [[CGFloat]] = []

    // Enable automatically if you're using index path driven height cache. Default is true
    internal var automaticallyInvalidateEnabled: Bool = true

    init() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceOrientationDidChange", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }

    deinit {
         NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
    }

    // MARK: - public
    subscript(indexPath: NSIndexPath) -> CGFloat? {
        get {
            if indexPath.section < heights.count && indexPath.row < heights[indexPath.section].count {
                return heights[indexPath.section][indexPath.row]
            }
            return nil
        }
        set {
            self.buildIndexPathIfNeeded(indexPath)
            heights[indexPath.section][indexPath.row] = newValue!
        }
    }

    internal func invalidateHeightAtIndexPath(indexPath: NSIndexPath) {
        self[indexPath] = -1
    }

    internal func invalidateAllHeightCache() {
        self.heights.removeAll()
    }

    internal func existsIndexPath(indexPath: NSIndexPath) -> Bool {
        return self[indexPath] != nil && self[indexPath] > -0.0000000001
    }

    internal func insertSections(sections: NSIndexSet) {
        sections.enumerateIndexesUsingBlock({ (index, stop) -> Void in
            self.buildSectionsIfNeeded(index)
            self.heights.insert([], atIndex: index)
        })
    }

    internal func deleteSections(sections: NSIndexSet) {
        sections.enumerateIndexesUsingBlock({ (index, stop) -> Void in
            self.buildSectionsIfNeeded(index)
            self.heights.removeAtIndex(index)
        })
    }

    internal func reloadSections(sections: NSIndexSet) {
        sections.enumerateIndexesUsingBlock({ (index, stop) -> Void in
            self.buildSectionsIfNeeded(index)
            self.heights[index] = []
        })
    }

    internal func moveSection(section: Int, toSection newSection: Int) {
        self.buildSectionsIfNeeded(section)
        self.buildSectionsIfNeeded(newSection)
        swap(&self.heights[section], &self.heights[newSection])
    }

    internal func insertRowsAtIndexPaths(indexPaths: [NSIndexPath]) {
        for indexPath in indexPaths {
            self.buildIndexPathIfNeeded(indexPath)
            self.heights[indexPath.section].insert(-1, atIndex: indexPath.row)
        }
    }

    internal func deleteRowsAtIndexPaths(indexPaths: [NSIndexPath]) {
        let indexPathSorted = indexPaths.sort { $0.section > $1.section || $0.row > $1.row }
        for indexPath in indexPathSorted {
            self.buildIndexPathIfNeeded(indexPath)
            self.heights[indexPath.section].removeAtIndex(indexPath.row)
        }
    }

    internal func reloadRowsAtIndexPaths(indexPaths: [NSIndexPath]) {
        for indexPath in indexPaths {
            self.buildIndexPathIfNeeded(indexPath)
            self.invalidateHeightAtIndexPath(indexPath)
        }
    }

    internal func moveRowAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
        self.buildIndexPathIfNeeded(indexPath)
        self.buildIndexPathIfNeeded(newIndexPath)
        swap(&self.heights[indexPath.section][indexPath.row], &self.heights[indexPath.section][indexPath.row])
    }

    // MARK: - private 
    private func buildSectionsIfNeeded(targetSection: Int) {
        if targetSection >= heights.count {
            for _ in heights.count...targetSection {
                self.heights.append([])
            }
        }
    }

    private func buildRowsIfNeeded(targetRow: Int, existSextion: Int) {
        if existSextion < heights.count && targetRow >= heights[existSextion].count {
            for _ in heights[existSextion].count...targetRow {
                self.heights[existSextion].append(-1)
            }
        }
    }

    private func buildIndexPathIfNeeded(indexPath: NSIndexPath) {
        self.buildSectionsIfNeeded(indexPath.section)
        self.buildRowsIfNeeded(indexPath.row, existSextion: indexPath.section)
    }

    @objc private func deviceOrientationDidChange() {
        self.invalidateAllHeightCache()
    }
}

// MARK: - UITableView Extension
extension UITableView {

    private struct AssociatedKey {
        static var DGIndexPathHeightCache = "DGIndexPathHeightCache"
    }

    /// Height cache by index path. Generally, you don't need to use it directly.
    internal var dg_indexPathHeightCache: DGIndexPathHeightCache {
        if let value: DGIndexPathHeightCache = objc_getAssociatedObject(self, &AssociatedKey.DGIndexPathHeightCache) as? DGIndexPathHeightCache {
            return value
        } else {
            let cache: DGIndexPathHeightCache = DGIndexPathHeightCache()
            objc_setAssociatedObject(self, &AssociatedKey.DGIndexPathHeightCache, cache, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return cache
        }
    }
}
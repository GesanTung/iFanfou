//
//  UIMediaCellView.swift
//  GTMobile
//
//  Created by tung on 16/2/18.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit

class UIMediaCellView: BaseTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override class func height(dict:AnyObject) -> CGFloat{
        return 170;
    }
    
}

//
//  NewsCellView.swift
//  GTMobile
//
//  Created by tung on 16/1/12.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit

class FanFouCellView: BaseTableViewCell {

    @IBOutlet weak var gViewTitle: UILabel!
    
    @IBOutlet weak var gViewImage: UIImageView!
    
    @IBOutlet weak var gViewUserName: UILabel!
    
    @IBOutlet weak var gViewTime: UILabel!
    
    @IBOutlet weak var gViewSource: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gViewImage.layer.cornerRadius = CGRectGetHeight(gViewImage.frame)/2
        gViewImage.layer.masksToBounds = true
    }
    
    override func initCellView(){
        let image = gDict.valueForKeyPath("user.profile_image_url") as! String
        gViewImage.kf_setImageWithURL(NSURL(string: image)!, placeholderImage: UIImage(named: "placeholder"))
        gViewTitle.text =  gDict.valueForKeyPath("text") as? String
        gViewUserName.text =  gDict.valueForKeyPath("user.name") as? String
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss +z yyyy"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let time = gDict.valueForKeyPath("created_at") as! String
        if let date = dateFormatter.dateFromString(time){
           gViewTime.text = NSDate.since(date)
        }
        
        gViewSource.text = NSString.getSource(gDict.valueForKeyPath("source") as! String)
    }

    override class func height(dict:AnyObject) -> CGFloat{
        return 90;
    }

}

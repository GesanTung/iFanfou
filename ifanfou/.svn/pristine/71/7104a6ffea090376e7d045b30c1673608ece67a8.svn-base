//
//  NewsCellView.swift
//  GTMobile
//
//  Created by tung on 16/1/12.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit

class FanFouImageCellView: BaseTableViewCell,SDPhotoBrowserDelegate {

    @IBOutlet weak var gViewTitle: UILabel!
    
    @IBOutlet weak var gViewImage: UIImageView!
    
    @IBOutlet weak var gViewUserName: UILabel!
    
    @IBOutlet weak var gViewTime: UILabel!
    
    @IBOutlet weak var gViewSource: UILabel!
    
    @IBOutlet weak var gViewFFImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gViewImage.layer.cornerRadius = CGRectGetHeight(gViewImage.frame)/2
        gViewImage.layer.masksToBounds = true
        gViewFFImage.layer.masksToBounds = true
    }
    
    override func initCellView(){
        let icon = gDict.valueForKeyPath("user.profile_image_url") as! String
        gViewImage.kf_setImageWithURL(NSURL(string: icon)!, placeholderImage: UIImage(named: "placeholder"))
        gViewTitle.text =  gDict.valueForKeyPath("text") as? String
        gViewUserName.text =  gDict.valueForKeyPath("user.name") as? String
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss +z yyyy"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let time = gDict.valueForKeyPath("created_at") as! String
        if let date = dateFormatter.dateFromString(time){
           gViewTime.text = NSDate.since(date)
        }
        
        let image = gDict.valueForKeyPath("photo.largeurl") as! String
        gViewFFImage.kf_setImageWithURL(NSURL(string: image)!, placeholderImage: UIImage(named: "placeholder"))
        gViewFFImage.userInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action:Selector("tapImageView:"))
        gViewFFImage.addGestureRecognizer(recognizer)
        gViewSource.text = NSString.getSource(gDict.valueForKeyPath("source") as! String)
    }
    
    func tapImageView(tap:UITapGestureRecognizer){
       let browser = SDPhotoBrowser()
        browser.sourceImagesContainerView = gViewFFImage
        browser.delegate = self
        browser.imageCount = 1
        browser.show()
    }
    
    func photoBrowser(browser: SDPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        return gViewFFImage.image
    }
    
    override class func height(dict:AnyObject) -> CGFloat{
        return 90;
    }

}

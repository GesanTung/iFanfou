//
//  ZLSwiftHeadView.swift
//  ZLSwiftRefresh
//
//  Created by 张磊 on 15-3-6.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

import UIKit

var KVOContext = ""
let imageViewW:CGFloat = 50
let labelTextW:CGFloat = 150

public class ZLSwiftHeadView: UIView {
    private var headLabel: UILabel = UILabel()
    var headImageView : UIImageView = UIImageView()
    var scrollView:UIScrollView = UIScrollView()
    var customAnimation:Bool = false
    var pullImages:[UIImage] = [UIImage]()
    var animationStatus:HeaderViewRefreshAnimationStatus?
    var activityView: UIActivityIndicatorView?
    
    var nowLoading:Bool = false{
        willSet {
            if (newValue == true){
                self.nowLoading = newValue
                self.scrollView.contentOffset = CGPointMake(0, -ZLSwithRefreshHeadViewHeight)//UIEdgeInsetsMake(ZLSwithRefreshHeadViewHeight, 0, self.scrollView.contentInset.bottom, 0)
            }
        }
    }
    
    var action: (() -> ())? = {}
    var nowAction: (() -> ()) = {}
    private var refreshTempAction:(() -> Void)? = {}
    
    
    convenience init(action :(() -> ()), frame: CGRect) {
        self.init(frame: frame)
        self.action = action
        self.nowAction = action
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var imgName:String {
        set {
            if(!self.customAnimation){
                // 默认动画
                if (self.animationStatus != .headerViewRefreshArrowAnimation){
                    self.headImageView.image = self.imageBundleWithNamed(named: "dropdown_anim__000\(newValue)")
                }else{
                    // 箭头动画
                    self.headImageView.image = self.imageBundleWithNamed(named: "arrow")
                }
            }else{
                let image = self.pullImages[Int(newValue)!]
                self.headImageView.image = image
            }
        }
        
        get {
            return self.imgName
        }
    }
    
    func setupUI(){
        let headImageView:UIImageView = UIImageView(frame: CGRectZero)
        headImageView.contentMode = .Center
        headImageView.clipsToBounds = true;
        self.addSubview(headImageView)
        self.headImageView = headImageView
        
        let headLabel:UILabel = UILabel(frame: self.frame)
        headLabel.text = ZLSwithRefreshHeadViewText
        headLabel.textAlignment = .Center
        headLabel.clipsToBounds = true;
        self.addSubview(headLabel)
        self.headLabel = headLabel
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        self.addSubview(activityView)
        self.activityView = activityView
    }
    
    func startAnimation(){
        
        if (self.activityView?.isAnimating() == true){
            return ;
        }
        
        if (!self.customAnimation){
            if (self.animationStatus != .headerViewRefreshArrowAnimation){
                var results:[AnyObject] = []
                for i in 1..<4{
                    let image:UIImage = self.imageBundleWithNamed(named: "dropdown_loading_0\(i)")
                    if image.size.height > 0 && image.size.width > 0 {
                        results.append(image)
                    }
                }
                self.headImageView.animationImages = results as? [UIImage]
                self.headImageView.animationDuration = 0.6
                self.activityView?.alpha = 0.0
            }else{
                self.activityView?.alpha = 1.0
                self.headImageView.hidden = true
            }
            self.activityView?.startAnimating()
        }else{
            let duration:Double = Double(self.pullImages.count) * 0.1
            self.headImageView.animationDuration = duration
        }
        
        self.headLabel.text = ZLSwithRefreshLoadingText
        if (self.animationStatus != .headerViewRefreshArrowAnimation){
            self.headImageView.animationRepeatCount = 0
            self.headImageView.startAnimating()
        }
    }
    
    func stopAnimation(){
        self.nowLoading = false
        self.headLabel.text = ZLSwithRefreshHeadViewText
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            if (abs(self.scrollView.contentOffset.y) >= self.getNavigationHeight() + ZLSwithRefreshHeadViewHeight){
                self.scrollView.contentInset = UIEdgeInsetsMake(self.getNavigationHeight(), 0, self.scrollView.contentInset.bottom, 0)
            }else{
                self.scrollView.contentInset = UIEdgeInsetsMake(self.getNavigationHeight(), 0, self.scrollView.contentInset.bottom, 0)
            }
        })
        
        if (self.animationStatus == .headerViewRefreshArrowAnimation){
            self.headImageView.hidden = false
            self.activityView?.alpha = 0.0
        }else{
            self.activityView?.alpha = 1.0
            self.headImageView.stopAnimating()
        }
        self.activityView?.stopAnimating()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        headLabel.sizeToFit()
        headLabel.frame = CGRectMake((self.frame.size.width - labelTextW) / 2, -self.scrollView.frame.origin.y, labelTextW, self.frame.size.height)
        
        headImageView.frame = CGRectMake(headLabel.frame.origin.x - imageViewW - 5, headLabel.frame.origin.y, imageViewW, self.frame.size.height)
        self.activityView?.frame = headImageView.frame
    }
    
    public override func willMoveToSuperview(newSuperview: UIView!) {
        superview?.removeObserver(self, forKeyPath: contentOffsetKeyPath, context: &KVOContext)
        if (newSuperview != nil && newSuperview.isKindOfClass(UIScrollView)) {
            self.scrollView = newSuperview as! UIScrollView
            newSuperview.addObserver(self, forKeyPath: contentOffsetKeyPath, options: .Initial, context: &KVOContext)
        }
    }
    
    //MARK: KVO methods
    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<()>) {
        
        if (self.action == nil) {
            return;
        }
        
        if (self.activityView?.isAnimating() == true){
            return ;
        }
        
        let scrollView:UIScrollView = self.scrollView
        // change contentOffset
        let scrollViewContentOffsetY:CGFloat = scrollView.contentOffset.y
        var height = ZLSwithRefreshHeadViewHeight
        if (ZLSwithRefreshHeadViewHeight > animations){
            height = animations
        }
        
        if (scrollViewContentOffsetY + self.getNavigationHeight() != 0 && scrollViewContentOffsetY <= -height - scrollView.contentInset.top + 20) {
            
            if (self.animationStatus == .headerViewRefreshArrowAnimation){
                UIView.animateWithDuration(0.15, animations: { () -> Void in
                    self.headImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                })
            }
            
            // 上拉刷新
            self.headLabel.text = ZLSwithRefreshRecoderText
            if scrollView.dragging == false && self.headImageView.isAnimating() == false{
                if refreshTempAction != nil {
                    refreshStatus = .Refresh
                    self.startAnimation()
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        if scrollView.contentInset.top == 0 {
                            scrollView.contentInset = UIEdgeInsetsMake(self.getNavigationHeight(), 0, scrollView.contentInset.bottom, 0)
                        }else{
                            scrollView.contentInset = UIEdgeInsetsMake(ZLSwithRefreshHeadViewHeight + scrollView.contentInset.top, 0, scrollView.contentInset.bottom, 0)
                        }
                        
                    })
                    
                    if (nowLoading == true){
                        nowAction()
                        nowAction = {}
                        nowLoading = false
                    }else{
                        refreshTempAction?()
                        refreshTempAction = {}
                    }
                }
            }
            
        }else{
            // 上拉刷新
            if (nowLoading == true){
                self.headLabel.text = ZLSwithRefreshLoadingText
            }else if(scrollView.dragging == true){
                self.headLabel.text = ZLSwithRefreshHeadViewText
            }
            
            if (self.animationStatus == .headerViewRefreshArrowAnimation){
                UIView.animateWithDuration(0.15, animations: { () -> Void in
                    self.headImageView.transform = CGAffineTransformIdentity
                })
            }
            
            refreshTempAction = self.action
        }
        
        // 上拉刷新
        if (nowLoading == true){
            self.headLabel.text = ZLSwithRefreshLoadingText
        }
        if (scrollViewContentOffsetY <= 0){
            var v:CGFloat = scrollViewContentOffsetY + scrollView.contentInset.top
            if ((!self.customAnimation) && (v < -animations || v > animations)){
                v = animations
            }
            
            if (self.customAnimation){
                v *= CGFloat(CGFloat(self.pullImages.count) / ZLSwithRefreshHeadViewHeight)
                
                if (Int(abs(v)) > self.pullImages.count - 1){
                    v = CGFloat(self.pullImages.count - 1);
                }
            }
            
            if ((Int)(abs(v)) > 0){
                self.imgName = "\((Int)(abs(v)))"
            }
        }
    }
    
    //MARK: getNavigaition Height -> delete
    func getNavigationHeight() -> CGFloat{
        var vc = UIViewController()
        if self.getViewControllerWithView(self).isKindOfClass(UIViewController) == true {
            vc = self.getViewControllerWithView(self) as! UIViewController
        }
        
        var top = vc.navigationController?.navigationBar.frame.height
        if top == nil{
            top = 0
        }
        // iOS7
        var offset:CGFloat = 20
        if((UIDevice.currentDevice().systemVersion as NSString).floatValue < 7.0){
            offset = 0
        }
        
        return offset + top!
    }
    
    func getViewControllerWithView(vcView:UIView) -> AnyObject{
        if( (vcView.nextResponder()?.isKindOfClass(UIViewController) ) == true){
            return vcView.nextResponder() as! UIViewController
        }
        
        if(vcView.superview == nil){
            return vcView
        }
        return self.getViewControllerWithView(vcView.superview!)
    }
    
    func imageBundleWithNamed(named named: String!) -> UIImage{
        let bundle = NSBundle(identifier: "xsdlr.ZLSwiftRefresh")
        let name = ZLSwiftRefreshBundleName.stringByAppendingFormat("/%@", named)
        return UIImage(named: name, inBundle: bundle, compatibleWithTraitCollection: nil)!
    }
    
    deinit{
        let scrollView = superview as? UIScrollView
        scrollView?.removeObserver(self, forKeyPath: contentOffsetKeyPath, context: &KVOContext)
    }
}


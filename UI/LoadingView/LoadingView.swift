//
//  LoadingView.swift
//  Breezer
//
//  Created by Admin on 18.04.17.
//  Copyright © 2017 grapes-studio. All rights reserved.
//

import UIKit


//
//  LoadingView.swift
//  Billie
//
//  Created by Admin on 22.03.16.
//  Copyright © 2016 Billie LLC. All rights reserved.
//

import Foundation
import UIKit

class LoadingView {
    
    /// shared instance
    class var shared: LoadingView {
        struct Static {
            static let instance: LoadingView = LoadingView()
        }
        return Static.instance
    }
    
    
    /// Show loading view static func
    public class func show() {
        let instance = LoadingView.shared
        instance.showLoading()
    }
    
    
    /// Hide loading view static func
    public class func hide() {
        let instance = LoadingView.shared
        instance.hideLoading()
    }
    
    var loadingView = UIView()
    var container = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var showed : Bool = false
    
    
    /// tag for main view
    private let loadingViewTag = 13394
    
    
    /// show loading view
    func showLoading() {
        if (self.showed == true)
        {
            return
        }
        let win:UIWindow = UIApplication.shared.delegate!.window!!
        self.loadingView = UIView(frame: win.frame)
        self.loadingView.tag = self.loadingViewTag
        self.loadingView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        
        win.addSubview(self.loadingView)
        
        container = UIView(frame: CGRect(x: 0, y: 0, width: win.frame.width/3, height: win.frame.width/3))
        container.backgroundColor = UIColor.darkGray.withAlphaComponent(0.6)
        container.layer.cornerRadius = 10.0
        container.layer.borderColor = UIColor.darkGray.cgColor
        container.layer.borderWidth = 0.5
        container.clipsToBounds = true
        container.center = self.loadingView.center
        
        
        activityIndicator.frame = CGRect(x: 0, y:0, width: win.frame.width/5, height: win.frame.width/5)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = self.loadingView.center
        
        
        self.loadingView.addSubview(container)
        self.loadingView.addSubview(activityIndicator)
        
        self.showed = true
        
        activityIndicator.startAnimating()
        
    }
    
    /// hide loading view
    func hideLoading(){
        if (self.showed == false)
        {
            return
        }
        UIView.animate(withDuration: 0.0, delay: 0.2, options: .curveEaseOut, animations: {
            self.container.alpha = 0.0
            self.loadingView.alpha = 0.0
        }, completion: { finished in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            self.container.removeFromSuperview()
            self.loadingView.removeFromSuperview()
            let win:UIWindow = UIApplication.shared.delegate!.window!!
            let removeView  = win.viewWithTag(self.loadingViewTag)
            removeView?.removeFromSuperview()
            self.showed = false
        })
    }
}

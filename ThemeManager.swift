//
//  ThemeManager.swift
//  Breezer
//
//  Created by Admin on 17.04.17.
//  Copyright © 2017 grapes-studio. All rights reserved.
//

import Foundation
import UIKit

enum Theme {
    case Dark, Red, Cyan, Gray, Violet
    
    
    /// Цвет бэкграунда UINavigationController
    var navigationBarColor: UIColor{
        switch self {
        case .Dark:
            return UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        case .Red:
            return UIColor.red
        case .Cyan:
            return UIColor(red: 86.0/255.0, green: 213.0/255.0, blue: 243.0/255.0, alpha: 1.0)
        case .Gray:
            return UIColor.gray
        case .Violet:
            return UIColor.purple
        }
    }
    
    /// Цвет бэкграунда UINavigationController
    var navigationBarTextColor: UIColor{
        switch self {
        case .Dark:
            return UIColor.white
        case .Red:
            return UIColor.white
        case .Cyan:
            return UIColor.white
        case .Gray:
            return UIColor.white
        case .Violet:
            return UIColor.white
        }
    }
    
    
    /// Цвет бэкграунда экранов
    var screenBackgroundColor: UIColor{
        return UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    }
    
    var navigationBarTitleFont: UIFont {
        return UIFont(name: "Roboto-Medium", size: 20)!
    }
    
}

struct ThemeManager{
    
    static func red() -> Theme {
        return .Red
    }
    
    static func dark() -> Theme {
        return .Dark
    }
    
    static func applyTheme(_ theme: Theme, forViewController vc: UIViewController) {
        vc.navigationController?.navigationBar.barTintColor = theme.navigationBarColor
        vc.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : theme.navigationBarTextColor,
                                                                      NSFontAttributeName : theme.navigationBarTitleFont]
        vc.navigationController?.navigationBar.tintColor = theme.navigationBarTextColor
        UIScrollView.appearance().backgroundColor = theme.screenBackgroundColor
        
    }
    
}
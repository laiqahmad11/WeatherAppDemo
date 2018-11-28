//
//  Utility.swift
//  WeatherApp
//
//  Created by EasyPay on 17/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    static func appDelegateInstance() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    static func barButtonItem(selector: Selector, controller: UIViewController, image: UIImage) -> UIBarButtonItem {
        let barButton = UIButton(type: .custom)
        barButton.setImage(image, for: .normal)
        barButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        barButton.addTarget(controller, action: selector, for: .touchUpInside)
        let barItem = UIBarButtonItem(customView: barButton)
        return barItem
    }
    
    @discardableResult static func showErrorAlertMessage(titleMessage: String, alertMsg: String) -> PMAlertController {
        let alertVC = PMAlertController(title: titleMessage, description: alertMsg, image: nil, style: .alert)
        alertVC.gravityDismissAnimation = false
        alertVC.accessibilityLabel = "Alert"
        alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
            
        }))
        
        if let controller = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController {
            controller.present(alertVC, animated: true, completion: nil)
        } else {
            UIApplication.shared.delegate?.window!!.rootViewController?.present(alertVC, animated: true, completion: nil)
        }
        return alertVC
    }
    
    static func leftViewForTextField() -> UIView {
        let vw = UIView (frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        return vw
    }
    
}


extension UIView {
    
    func lock() {
        if let _ = viewWithTag(10) {
            //View is already locked
        }
        else {
            let lockView = UIView(frame: bounds)
            lockView.backgroundColor = UIColor(white: 0.0, alpha: 0.75)
            lockView.tag = 10
            lockView.alpha = 0.0
            let activity = UIActivityIndicatorView(style: .white)
            activity.hidesWhenStopped = true
            activity.center = lockView.center
            lockView.addSubview(activity)
            activity.startAnimating()
            addSubview(lockView)
            
            UIView.animate(withDuration: 0.2, animations: {
                lockView.alpha = 1.0
            })
        }
    }
    
    func unlock() {
        if let lockView = viewWithTag(10) {
            UIView.animate(withDuration: 0.2, animations: {
                lockView.alpha = 0.0
            }, completion: { finished in
                lockView.removeFromSuperview()
            })
        }
    }
    
    func fadeOut(_ duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
    func fadeIn(_ duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
}

extension UIAlertAction {
    func makeActionWithTitle(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: handler)
    }
}


struct Device {
    // iDevice detection code
    static let IS_IPAD             = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE           = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_RETINA           = UIScreen.main.scale >= 2.0
    
    static let SCREEN_WIDTH        = Int(UIScreen.main.bounds.size.width)
    static let SCREEN_HEIGHT       = Int(UIScreen.main.bounds.size.height)
    static let SCREEN_MAX_LENGTH   = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
    static let SCREEN_MIN_LENGTH   = Int( min(SCREEN_WIDTH, SCREEN_HEIGHT) )
    
    static let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH  < 568
    static let IS_IPHONE_5         = IS_IPHONE && SCREEN_MAX_LENGTH == 568
    static let IS_IPHONE_6         = IS_IPHONE && SCREEN_MAX_LENGTH == 667
    static let IS_IPHONE_6P        = IS_IPHONE && SCREEN_MAX_LENGTH == 736
    static let IS_IPHONE_X         = IS_IPHONE && SCREEN_MAX_LENGTH == 812
}

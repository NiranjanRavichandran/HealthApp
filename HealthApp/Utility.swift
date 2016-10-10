//
//  Utility.swift
//  HealthApp
//
//  Created by Niranjan Ravichandran on 10/8/16.
//  Copyright © 2016 uncc. All rights reserved.
//

import UIKit

protocol ButtonResponderDelegate {
    func daysButtonDidPress(_ sender: UIButton, questionID: Int?)
    func agreebuttonPressed(_ sender: UIButton, questionID: Int?)
    func textFieldReturn(_ textfield: UITextField, questionID: Int?)
}

class Utility {
    
   class var labelColor: UIColor {
        return UIColor(red: 47/255, green: 50/255, blue: 86/255, alpha: 1.0)
    }
    
    class var dayButtonColor: UIColor {
        return UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
    }
    class var dayButtonHighlightColor: UIColor {
        return UIColor(red: 35/255, green: 185/255, blue: 237/255, alpha: 1.0)
    }
    
    class var agreeButtonColor: UIColor {
        return UIColor(red: 70/255, green: 186/255, blue: 219/255, alpha: 1.0)
    }
    
    class func calculateHeightForString(inString:String?) -> CGFloat
    {
        if let messageString = inString {
            let attrString:NSAttributedString? = NSAttributedString(string: messageString, attributes: [NSFontAttributeName: UIFont(name: "Helvetica", size: 15)!])
            let rect:CGRect = attrString!.boundingRect(with: CGSize(width: 300.0, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, context:nil )//you will get the aproximate height not the exact value
            let requredSize:CGRect = rect
            return requredSize.height

        }else {
            return 0
        }
        
    }
    
    class func showAlert(with title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
}

public struct ConstantStrings {
    static var allergyText: String = "I'm allergic to nuts."
    static var pillsText: String = "I have not been prescribed blood pressure pills."
}


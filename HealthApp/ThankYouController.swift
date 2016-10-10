//
//  ThankYouController.swift
//  HealthApp
//
//  Created by Niranjan Ravichandran on 10/9/16.
//  Copyright © 2016 uncc. All rights reserved.
//

import UIKit

class ThankYouController: UIViewController {

    var displayText: UILabel!
    var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.clipsToBounds = true
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"Logout.png"), style: .done, target: self, action: #selector(self.logoutUser))
        self.navigationItem.hidesBackButton = true
        displayText = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        displayText.text = "Thank You!"
        displayText.textColor = Utility.labelColor
        displayText.textAlignment = .center
        displayText.font = UIFont(name: "Helvetica", size: 25)
        displayText.center = self.view.center
        displayText.center.y -= 50
        
        logoutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        logoutButton.center = self.view.center
        logoutButton.backgroundColor = Utility.dayButtonHighlightColor
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.layer.cornerRadius = 15
        logoutButton.center.y += 30
        
        logoutButton.addTarget(self, action: #selector(self.logoutUser), for: .touchUpInside)
        self.view.addSubview(logoutButton)
        self.view.addSubview(displayText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Logout function
    func logoutUser() {
        self.dismiss(animated: true) {
            //Detroy token if any after logout
        }
    }

}

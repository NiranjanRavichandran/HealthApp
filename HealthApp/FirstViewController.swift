//
//  FirstViewController.swift
//  HealthApp
//
//  Created by Niranjan Ravichandran on 10/9/16.
//  Copyright © 2016 uncc. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        yesButton.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: .touchUpInside)
        noButton.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: .touchUpInside)
        
        yesButton.backgroundColor = Utility.dayButtonHighlightColor
        noButton.backgroundColor = Utility.dayButtonHighlightColor
        yesButton.setTitleColor(UIColor.white, for: .normal)
        noButton.setTitleColor(UIColor.white, for: .normal)
        yesButton.layer.cornerRadius = 25
        noButton.layer.cornerRadius = 25
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonPressed(sender: UIButton) {
        sender.backgroundColor = Utility.labelColor
        let questionVC = QuestionsViewController()
        if sender.tag == 501 {
            questionVC.currentIndex = 6
        }
        self.navigationController?.pushViewController(questionVC, animated: true)
    }

}

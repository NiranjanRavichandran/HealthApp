//
//  QuestionLabel.swift
//  HealthApp
//
//  Created by Niranjan Ravichandran on 10/8/16.
//  Copyright © 2016 uncc. All rights reserved.
//

import UIKit

class QuestionLabel: UILabel {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let padding = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }
 
    
    func configure() {
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.backgroundColor = Utility.labelColor
        self.textColor = UIColor.white
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.font = UIFont(name: "Helvetica", size: 15)
        self.textAlignment = .center

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

}

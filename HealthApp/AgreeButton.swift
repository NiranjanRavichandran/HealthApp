//
//  AgreeButton.swift
//  HealthApp
//
//  Created by Niranjan Ravichandran on 10/9/16.
//  Copyright © 2016 uncc. All rights reserved.
//

import UIKit

class AgreeButton: UIButton {

    func configure() {
        layer.cornerRadius = 5
        titleLabel?.numberOfLines = 0
        titleLabel?.lineBreakMode = .byWordWrapping
        
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

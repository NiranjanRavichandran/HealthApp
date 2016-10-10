//
//  DaysButton.swift
//  HealthApp
//
//  Created by Niranjan Ravichandran on 10/8/16.
//  Copyright © 2016 uncc. All rights reserved.
//

import UIKit

class DaysButton: UIButton {
    
    func configure() {
        self.layer.cornerRadius = 20
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

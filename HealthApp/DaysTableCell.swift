//
//  DaysTableCell.swift
//  HealthApp
//
//  Created by Niranjan Ravichandran on 10/7/16.
//  Copyright © 2016 uncc. All rights reserved.
//

import UIKit

class DaysTableCell: UITableViewCell {

    @IBOutlet weak var buttonZero: DaysButton!
    
    @IBOutlet weak var buttonSeven: DaysButton!
    @IBOutlet weak var buttonSix: DaysButton!
    @IBOutlet weak var buttonFive: DaysButton!
    @IBOutlet weak var buttonFour: DaysButton!
    @IBOutlet weak var buttonThree: DaysButton!
    @IBOutlet weak var buttonTwo: DaysButton!
    @IBOutlet weak var buttonOne: DaysButton!
    @IBOutlet weak var questionLabel: QuestionLabel!
    
    @IBOutlet var dayButtons: [DaysButton]!
    
    @IBOutlet weak var subQuestionView: UIView!
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var subQuestionLabel: UILabel!
    
    var selectedButton: UIButton?
    var buttonResponderDelegate: ButtonResponderDelegate?
    var subChecked: Bool = false
    var questionId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        buttonZero.tag = 100
        buttonOne.tag = 101
        buttonTwo.tag = 102
        buttonThree.tag = 103
        buttonFour.tag = 104
        buttonFive.tag = 105
        buttonSix.tag = 106
        buttonSeven.tag = 107
        checkBoxButton.tag = 150
        
        checkBoxButton.addTarget(self, action: #selector(self.checkBoxChecked(_:)), for: .touchUpInside)
        checkBoxButton.setImage(UIImage(named: "Unchecked.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        checkBoxButton.imageView?.tintColor = Utility.dayButtonHighlightColor
        
        for item in dayButtons {
            item.addTarget(self, action: #selector(self.buttonPressed(_ :)), for: .touchUpInside)
        }
        selectionStyle = .none
    }
    
    func configureCell() {
        checkBoxButton.setImage(UIImage(named: "Unchecked.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        for item in dayButtons {
            item.backgroundColor = Utility.dayButtonColor
            item.setTitleColor(Utility.labelColor, for: .normal)
            item.isUserInteractionEnabled = true
        }
        selectedButton = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func buttonPressed(_ sender: UIButton) {
        sender.backgroundColor = Utility.dayButtonHighlightColor
        sender.setTitleColor(UIColor.white, for: .normal)
        
        if let _ = selectedButton {
            selectedButton!.backgroundColor = Utility.dayButtonColor
            selectedButton!.setTitleColor(Utility.labelColor, for: .normal)
        }
        self.selectedButton = sender
        buttonResponderDelegate?.daysButtonDidPress(sender, questionID: self.questionId)
    }
    
    func checkBoxChecked(_ sender: UIButton) {
        if subChecked {
            subChecked = false
            for item in dayButtons {
                item.isUserInteractionEnabled = true
            }
            checkBoxButton.setImage(UIImage(named: "Unchecked.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }else {
            subChecked = true
            for item in dayButtons {
                item.isUserInteractionEnabled = false
            }
            checkBoxButton.setImage(UIImage(named: "Checked.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        buttonResponderDelegate?.daysButtonDidPress(sender, questionID: self.questionId)
    }
    
}

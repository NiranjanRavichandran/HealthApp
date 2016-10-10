//
//  OptionsTableCell.swift
//  HealthApp
//
//  Created by Niranjan Ravichandran on 10/9/16.
//  Copyright © 2016 uncc. All rights reserved.
//

import UIKit

class OptionsTableCell: UITableViewCell {

    @IBOutlet weak var questionLabel: QuestionLabel!
    
    @IBOutlet var agreeButtons: [AgreeButton]!
    
    var questionId: Int?
    
    var selectedButton: UIButton?
    var responderDelegate: ButtonResponderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for i in 0..<agreeButtons.count {
            agreeButtons[i].tag = 200 + i
            agreeButtons[i].addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchUpInside)
        }
        selectionStyle = .none
    }
    
    func configureView() {
        for item in agreeButtons {
            item.backgroundColor = Utility.dayButtonColor
            item.setTitleColor(Utility.labelColor, for: .normal)
        }
        self.selectedButton = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func buttonPressed(_ sender: UIButton) {
        sender.backgroundColor = Utility.dayButtonHighlightColor
        sender.setTitleColor(UIColor.white, for: .normal)
        if let _ = selectedButton {
            selectedButton?.backgroundColor = Utility.dayButtonColor
            selectedButton?.setTitleColor(Utility.labelColor, for: .normal)
        }
        responderDelegate?.agreebuttonPressed(sender, questionID: self.questionId)
        selectedButton = sender
        
    }
    
}

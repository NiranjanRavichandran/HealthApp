//
//  NumbersTableCell.swift
//  HealthApp
//
//  Created by Niranjan Ravichandran on 10/9/16.
//  Copyright © 2016 uncc. All rights reserved.
//

import UIKit

class NumbersTableCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var numbersField: UITextField!
    @IBOutlet weak var questionLabel: QuestionLabel!
    
    var questionId: Int?
    var responderDelegate: ButtonResponderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        numbersField.delegate = self
        selectionStyle = .none
        numbersField.addTarget(self, action: #selector(self.textChanged(sender:)), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    func textChanged(sender: UITextField) {
        responderDelegate?.textFieldReturn(sender, questionID: self.questionId)
        
    }
}

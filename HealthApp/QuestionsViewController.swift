//
//  QuestionsViewController.swift
//  HealthApp
//
//  Created by Niranjan Ravichandran on 10/8/16.
//  Copyright © 2016 uncc. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ButtonResponderDelegate {
    
    var tableView: UITableView!
    var currentQuestions: [String]?
    var currentDict: NSDictionary?
    var currentQuestionIds: [Int]?
    var mainArray: NSArray?
    var currentIndex: Int = 0
    var currentCount: Int = 0
    
    var crossedAllergy: Bool = false
    var currentAnswer = Answer()
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DaysTableCell", bundle: nil), forCellReuseIdentifier: "DaysCell")
        tableView.register(UINib(nibName: "OptionsTableCell", bundle: nil), forCellReuseIdentifier: "OptionsCell")
        tableView.register(UINib(nibName: "HeaderTableCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        tableView.register(UINib(nibName: "NumbersTableCell", bundle: nil), forCellReuseIdentifier: "NumbersCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        self.tableView.isScrollEnabled = false
        self.view.addSubview(tableView)
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.clipsToBounds = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"Logout.png"), style: .done, target: self, action: #selector(self.logoutUser))
        //Loading question from plist
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "Questions", ofType: "plist") {
            mainArray = NSArray(contentsOfFile: path)
        }
        currentDict = mainArray?[currentIndex] as? NSDictionary
        currentQuestions = currentDict?["questions"] as? [String]
        currentQuestionIds = currentDict?["questionsId"] as? [Int]
        tableView.reloadData()
        self.layoutTableView()
    }
    
    func layoutTableView() {
        let contentSize = self.tableView.contentSize
        let tableBoundSize = self.tableView.bounds
        var offset: CGFloat = 0
        if contentSize.height < tableBoundSize.height {
            offset = (tableBoundSize.height - contentSize.height) / 3
        }
        self.tableView.contentOffset = CGPoint(x: 0, y: -offset)
    }
    
    override func viewDidLayoutSubviews() {
        self.tableView.frame = self.view.bounds
        self.layoutTableView()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = currentQuestions?.count {
            if count > 1 {
                self.currentCount = 1
                return 1
            }else {
                self.currentCount = count
                return count
            }
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderTableCell
        headerView.headingLabel.text = currentDict?["heading"] as? String
        headerView.titleLabel.text = currentDict?["title"] as? String
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = currentDict!["options"] as! String
        if type == "days" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DaysCell", for: indexPath) as! DaysTableCell
            cell.questionLabel.text = currentQuestions?[indexPath.row]
            cell.buttonResponderDelegate = self
            cell.questionId = currentQuestionIds?[indexPath.row]
            cell.configureCell()
            if let subs = currentDict?["subQuestions"] as? Bool {
                if subs {
                    cell.subQuestionView.alpha = 1
                    if currentDict?["heading"] as? String == "Diet" {
                        if !crossedAllergy {
                            cell.subQuestionLabel.text = ConstantStrings.allergyText
                            crossedAllergy = true
                        }else {
                            cell.subQuestionView.alpha = 0
                        }
                    }else {
                        cell.subQuestionLabel.text = ConstantStrings.pillsText
                    }
                }else {
                    cell.subQuestionView.alpha = 0
                }
            }
            return cell
        }else if type == "agree"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath) as! OptionsTableCell
            cell.questionLabel.text = currentQuestions?[indexPath.row]
            cell.responderDelegate = self
            cell.questionId = currentQuestionIds?[indexPath.row]
            cell.configureView()
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NumbersCell", for: indexPath) as! NumbersTableCell
            cell.questionLabel.text = currentQuestions?[indexPath.row]
            cell.questionId = currentQuestionIds?[indexPath.row]
            cell.responderDelegate = self
            cell.numbersField.text = " "
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = currentDict!["options"] as! String
        if type == "days" {
            let size = Utility.calculateHeightForString(inString: currentQuestions?[indexPath.row]) + 130
            return  size > 150 ? size : 150
        }else if type == "agree" {
            let size = Utility.calculateHeightForString(inString: currentQuestions?[indexPath.row]) + 190
            return size > 200 ? size : 200

        }else {
            let size = Utility.calculateHeightForString(inString: currentQuestions?[indexPath.row]) + 80
            return size > 100 ? size : 100
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let size = Utility.calculateHeightForString(inString: currentDict?["title"] as? String) + 55
        return size > 65 ? size : 65
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        let nextButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 35))
        nextButton.backgroundColor = Utility.dayButtonHighlightColor
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(self.nextButtonPressed), for: .touchUpInside)
        nextButton.layer.cornerRadius = 18
        nextButton.center = footerView.center
        if currentIndex == mainArray!.count {
            nextButton.setTitle("Submit", for: .normal)
        }
        footerView.addSubview(nextButton)
        return footerView
    }
    
    func nextButtonPressed() {
        while currentCount > 0 {
            self.currentQuestions?.remove(at: 0)
            currentCount -= 1
        }
        
        if self.currentAnswer.questionId == 0 {
            Utility.showAlert(with: "Error", message: "Please answer the question to proceed to the next question", viewController: self)
        }else {
            self.postAnswerToServer()
            if let _ = currentQuestions?.count {
                if currentQuestions!.count > 0 {
                    self.tableView.reloadData()
                }else {
                    self.loadNextQuestions()
                }
            }else {
                self.loadNextQuestions()
            }
        }
    }
    
    func loadNextQuestions() {
        if currentIndex < mainArray!.count - 1 {
            self.currentIndex += 1
            currentDict = mainArray?[currentIndex] as? NSDictionary
            currentQuestions = currentDict?["questions"] as? [String]
            tableView.reloadData()
            self.layoutTableView()
        }else {
            self.navigationController?.pushViewController(ThankYouController(), animated: true)
        }
        
    }
    
    //MARK: - DaysButtonDelegate
    func daysButtonDidPress(_ sender: UIButton, questionID questionId: Int?) {
        switch sender.tag {
        case 100:
            self.currentAnswer.answer = 0
        case 101:
            self.currentAnswer.answer = 1
        case 102:
            self.currentAnswer.answer = 2
        case 103:
            self.currentAnswer.answer = 3
        case 104:
            self.currentAnswer.answer = 4
        case 105:
            self.currentAnswer.answer = 5
        case 106:
            self.currentAnswer.answer = 6
        case 107:
            self.currentAnswer.answer = 7
        default:
            if self.currentAnswer.didCheckBox! {
                self.currentAnswer.didCheckBox = false
            }else {
                self.currentAnswer.didCheckBox = true
            }
        }
        self.currentAnswer.questionId = questionId
    }
    
    func agreebuttonPressed(_ sender: UIButton, questionID questionId: Int?) {
        switch sender.tag {
        case 200:
            self.currentAnswer.answer = 1
        case 201:
            self.currentAnswer.answer = 2
        case 202:
            self.currentAnswer.answer = 3
        case 203:
            self.currentAnswer.answer = 4
        case 204:
            self.currentAnswer.answer = 5
        default:
            break
        }
        self.currentAnswer.questionId = questionId
    }
    
    func textFieldReturn(_ textfield: UITextField, questionID: Int?) {
        self.currentAnswer.questionId = questionID
        if let number = textfield.text {
            self.currentAnswer.answer = (number as NSString).integerValue
        }else {
            self.currentAnswer.answer = 0
        }
    }
    
    //MARK: - Logout function
    func logoutUser() {
        self.dismiss(animated: true) { 
            //Detroy token if any after logout
        }
    }
    
    func postAnswerToServer() {
        if self.currentAnswer.questionId != 0 {
            var subAnswer = " "
            if self.currentAnswer.didCheckBox! {
                subAnswer = "Yes"
            }
            if let token = appdelegate.currentUser?.token, let userId = appdelegate.currentUser?.userId {
                NetworkManager.sharedManager.postResponse(for: self.currentAnswer.questionId, with: self.currentAnswer.answer, subAnswer: subAnswer, userId: userId,token: token, onSuccess: { saveStatus in
                    if saveStatus {
                        print("@@@@ answered saved")
                    }else {
                        print("### save answer failed")
                    }
                })
            }
        }
        self.currentAnswer = Answer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

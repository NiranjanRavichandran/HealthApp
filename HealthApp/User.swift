//
//  User.swift
//  HealthApp
//
//  Created by Niranjan Ravichandran on 10/9/16.
//  Copyright © 2016 uncc. All rights reserved.
//

import Foundation

struct User {
    let userId: String!
    let token: String!
    let username: String!
    let name: String!
    
    init(jsonObject: NSDictionary, token: String?) {
        self.userId = jsonObject["Id"] as? String ?? " "
        self.token = token ?? " "
        self.username = jsonObject["username"] as? String ?? " "
        self.name = jsonObject["name"] as? String ?? " "
    }
}

struct Answer {
    var questionId: Int!
    var answer: Int!
    var didCheckBox: Bool!
    
    init() {
        questionId = 0
        answer = 0
        didCheckBox = false
    }
}

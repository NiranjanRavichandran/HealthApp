//
//  NetworkManager.swift
//  HealthApp
//
//  Created by Niranjan Ravichandran on 10/9/16.
//  Copyright © 2016 uncc. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let sharedManager = NetworkManager()
    
    private let APPENDPOINT = "http://52.89.68.106:8080/api"
    private let LOGIN = "/login"
    private let SAVEANSWER = "/saveResponse"
    
    func loginWithUsername(username: String, password: String, onsuccess success: @escaping (User)-> Void, onError error: ()-> Void) {
        Alamofire.request(APPENDPOINT + LOGIN, method: .post, parameters: ["username": username, "password": password], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if let jsonRespnose = response.result.value as? NSDictionary {
                print("@@@",jsonRespnose)
                if jsonRespnose["error"] as? Int == 0 {
                    if let data = jsonRespnose["data"] as? NSDictionary {
                        if let token = data["token"] as? String, let userObject = data["user"] as? NSDictionary {
                            let user = User(jsonObject: userObject, token: token)
                            success(user)
                        }
                    }
                }
            }
        }
    }
    
    func postResponse(for questionId: Int, with answer: Int, subAnswer: String, userId: String, token: String, onSuccess success: @escaping (Bool)-> Void) {
        Alamofire.request(APPENDPOINT + SAVEANSWER, method: .post, parameters: ["userId": userId, "answer": answer, "subQuestionAnswer": subAnswer, "questionId": questionId, "token": token], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            print("@@@", response.result.value)
            if let jsonResponse = response.result.value as? NSDictionary {
                if jsonResponse["error"] as? Int == 0 {
                    success(true)
                }else {
                    success(false)
                }
            }
        }
    }
}

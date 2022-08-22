//
//  Question.swift
//  AppTracNhiem
//
//  Created by V000315 on 17/08/2022.
//s

import Foundation
import FirebaseFirestoreSwift

class Question : Identifiable, Codable {
    var question: String?
    var choise1: String?
    var choise2: String?
    var choise3: String?
    var choise4: String?
    var answer: String?
    
    func initLoad(_ json: [String: Any]) {
        question = json["Question"] as? String ?? ""
        choise1 = json["Choice1"] as? String ?? ""
        choise2 = json["Choice2"] as? String ?? ""
        choise3 = json["Choice3"] as? String ?? ""
        choise4 = json["Choice4"] as? String ?? ""
        answer = json["Answer"] as? String ?? ""
    }
}

//
//  FireBase.swift
//  AppTracNhiem
//
//  Created by V000315 on 17/08/2022.
//

import UIKit
import FirebaseDatabase
class FireBase: NSObject {
    static let firebase : FireBase = FireBase()
    private override init() {
    }
    private let database = Database.database().reference()
    func getQuestions( clousue: @escaping(([Exam]) -> Void)){
        var listExam : [Exam] = []
        database.child("1urSOD9SR3lSD7WE1SF0CqKRa7c1INR9I-iMqQgwsKvM").observeSingleEvent(of: .value) { snap,data  in
            guard let value = snap.value as? [String: Any] else {
                return
            }
            
            for item in value {
                let title: String = item.key
                var listQuestion: [Question] = []
                if let exam = item.value as? [[String: Any]] {
                    for item1 in exam {
                        let que = Question()
                        que.initLoad(item1)
                        listQuestion.append(que)
                    }
                }
                let examdata = Exam(title: title, listQuestion: listQuestion)
                listExam.append(examdata)
            }
            clousue(listExam)
        }
    }
    func checkDataLogin(userName: String, clousue: @escaping (_ respone: Bool) -> Void){
        var check = false
        database.child("Users").queryOrdered(byChild: "username").queryStarting(atValue: userName).queryEnding(atValue: userName+"\u{f8ff}").observe(.value, with: { snapshot in
            if snapshot.value != nil {
                check = true
            }
            clousue(check)
        })
        
    }
}

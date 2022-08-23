//
//  FireBase.swift
//  AppTracNhiem
//
//  Created by V000315 on 17/08/2022.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
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
    func creatAAcount(email: String, password: String, clousue: @escaping(_ respone : Bool) -> Void){
        Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
            if error != nil {
                clousue(false)
            } else {
                clousue(true)
            }
        }
    }
    func loginAccount(email: String, password: String, clousue: @escaping(_ respone : Bool,_ userLogin: User) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { user , error in
            var userLogin = User(userName: "", uid: "")
            if error != nil {
                clousue(false, userLogin)
            } else {
                self.addInforUser(uid: user?.user.uid ?? "", numberQS: 0, timeLimit: 0, username: email )
                userLogin.uid = user?.user.uid ?? ""
                userLogin.userName = email
                clousue(true, userLogin )
            }
        }
    }
    func addInforUser(uid: String, numberQS: Int, timeLimit: Int, username: String){
        let object : [String : Any] = [
                "numberOfQuestions" : numberQS,
                "timeLimit" : timeLimit,
                "userName" :  username
        ]
        database.child("Users").child(uid).setValue(object)
    }
    func addHistory(user: User, history: History){
        let random = Int.random(in: 100000000000000...999999999999999)
        let object : [String : Any] = [
            "id": random,
            "playDate" : history.playDate,
                "score" : history.score,
                "time" :  history.time
        ]
        database.child("PlayHistory").child(user.uid).child(history.topic).child(String(random)).setValue(object)
    }
}

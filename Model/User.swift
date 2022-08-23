//
//  User.swift
//  AppTracNhiem
//
//  Created by V000315 on 23/08/2022.
//

import UIKit
class History: NSObject {
    var topic: String = ""
    var playDate: String = ""
    var score: Int = 0
    var time: Int = 0
    init(topic: String, playDate: String, score: Int, time: Int) {
        self.topic = topic
        self.playDate = playDate
        self.score = score
        self.time = time
    }
}
class User: NSObject {
    var userName: String = ""
    var uid: String = ""
    var history: [History] = []
    init(userName: String, uid: String) {
        self.userName = userName
        self.uid = uid
    }
}

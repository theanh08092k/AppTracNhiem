//
//  Exam.swift
//  AppTracNhiem
//
//  Created by V000315 on 17/08/2022.
//

import UIKit

class Exam: NSObject {
    var title: String = ""
    var listQuestion: [Question] = []
    init(title: String, listQuestion: [Question]) {
        self.title = title
        self.listQuestion = listQuestion
    }
}

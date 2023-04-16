//
//  ReportModel.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/16/23.
//

import Foundation


struct ReportModel: Identifiable {
    init(type:String, question:String) {
        self.type = type
        self.question = question
        self.choices = []
        self.answer = ""
        self.answered = false
    }
    
    init(type:String, question:String, mChoices:String) {
        self.type = type
        self.question = question
        self.choices = mChoices.components(separatedBy: "_")
        self.answer = ""
        self.answered = false
    }
    
    init(question:String, answer:String) {
        self.type = ""
        self.question = question
        self.choices = []
        self.answer = answer
        self.answered = true
    }
    
    
    var id: UUID = UUID()
    var type:String
    var question:String
    var choices:[String]
    var answer:String
    var answered:Bool

    
    func getType() -> String {
        return type
    }
    func getQuestion() -> String {
        return question
    }
    func getChoices() -> [String] {
        return choices
    }
    func getAnswer() -> String {
        return answer
    }
    
    func isAnswered() -> Bool {
        return answered
    }
    
    mutating func setAsnwer(answer:String) {
        self.answer = answer
        self.answered = true
    }
}



//class ReportModelFromDataBase: Encodable {
    //var type:String = ""
    //var question:String = ""
//}




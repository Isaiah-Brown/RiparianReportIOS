//
//  ReportModel.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/16/23.
//

import Foundation



class JSON : ObservableObject {
    
    var json: [String: Any]
    
    init(questions: [String], answers: [String]) {
        self.json = [
            "questions" : questions,
            "answers" : answers
        ]
    }
    
    func getObjectJSON() -> [String: Any] {
        return json
    }
    
}




struct ReportModel: Identifiable, Hashable {
    
    init() {
        self.type = ""
        self.question = ""
        self.choices = []
        self.answer = ""
        self.answered = false
        self.idx = 0
    }
    init(type:String, question:String, idx:Int) {
        self.type = type
        self.question = question
        self.choices = []
        self.answer = ""
        self.answered = false
        self.idx = idx
    }
    
    init(type:String, question:String, mChoices:String, idx:Int) {
        self.type = type
        self.question = question
        self.choices = mChoices.components(separatedBy: "_")
        self.answer = ""
        self.answered = false
        self.idx = idx
        if (self.type == "MULTIPLE_CHOICE_OTHER") {
            choices.append("Other:")
        }
    }
    
    init(question:String, answer:String, idx:Int) {
        self.type = ""
        self.question = question
        self.choices = []
        self.answer = answer
        self.answered = true
        self.idx = idx
    }
    
    
    let id: UUID = UUID()
    var type:String
    var question:String
    var choices:[String]
    var answer:String
    var answered:Bool
    var idx:Int

    
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
    
    func getIdx() -> Int {
        return idx
    }
    
    mutating func setAsnwer(answer:String) {
        self.answer = answer
        self.answered = true
    }
}



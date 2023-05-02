//
//  HistoryHelper.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/19/23.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift


class HistoryHelper: ObservableObject {
    
    
    
    var ref = Database.database().reference()
    var dateKey = ""
    private var username = ""
    
    @Published var forms = [Form]()
    
    @Published var isSorted: Bool = false
    
    @Published var initalized:Bool = false
    
    
    func addUserName(username: String) {
        let tmpUsername = username.replacingOccurrences(of: ".", with: ",").lowercased()
        self.username = tmpUsername
    }
   
    func initForms() {
       
        print("*******   FORMS STARTED ***********")
        print(self.dateKey)
        ref.child("users").child(username).observeSingleEvent(of: .value) { snapshot in
            var tmpForms = [Form]()
            let allChildren = snapshot.children.allObjects as! [DataSnapshot]
            var idx = 0
            for snap in allChildren {
                var form = Form()
                let questions = snap.children.allObjects as! [DataSnapshot]
                for question in questions {
                    let value = question.value as? String
                    let key = String(question.key)
                    print(key)
                    if (key == "Date of Check-up") {
                        form.setDate(date: value ?? "No date")
                        form.setDateNumber(date: value ?? "")
                        print("date found", value)
                    }
                    form.questionSet.append(Pair(question: key, answer: value as! String))
                    form.setIdx(idx: idx)
                }
                tmpForms.append(form)
                idx += 1
            }
            if tmpForms.count != 0 {
                for i in 0..<tmpForms.count - 1 {
                    for j in 0..<tmpForms.count - i - 1{
                        if (tmpForms[j].getDateNumber() < tmpForms[j+1].getDateNumber()) {
                            tmpForms[j].setIdx(idx: j+1)
                            tmpForms[j+1].setIdx(idx: j)
                            tmpForms.swapAt(j, j+1)
                        }
                    }
                }
            }
            self.forms = tmpForms
            
        }
        //sortForms()
        
    }
    func sortForms() {
        if (self.forms.count < 1) {
            print("count", forms.count)
            return
        }
        print("****SORT FORMS STARTED******")
        for i in stride(from: 0, to: self.forms.count, by: 1) {
            print(self.forms[i].getDate(), forms[i].getIdx(), "date before")
        }
        var tmpForms = self.forms
        for i in 0..<tmpForms.count - 1 {
            for j in 0..<tmpForms.count - i - 1{
                if (tmpForms[j].getDateNumber() < tmpForms[j+1].getDateNumber()) {
                    tmpForms[j].setIdx(idx: j+1)
                    tmpForms[j+1].setIdx(idx: j)
                    tmpForms.swapAt(j, j+1)
                }
            }
        }
     
        self.forms = tmpForms
        
        
        for i in stride(from: 0, to: self.forms.count, by: 1) {
            print(self.forms[i].getDate(), self.forms[i].getIdx(), "date after")
        }
        isSorted = true
        initalized = true
    }
}



class Form: Identifiable {
    
    
    let id: UUID = UUID()
    var questionSet = [Pair]()
    @Published var date:String
    var dateNumber:Int
    var idx:Int
    
    init() {
        self.questionSet = [Pair]()
        self.date = ""
        self.dateNumber = 0
        self.idx = 0
    }
    
    
    func addPair(pair :Pair) {
        questionSet.append(pair)
    }
    
    func setDate(date: String) {
        self.date = date
    }
    
    func setIdx(idx: Int) {
        self.idx = idx
    }
    
    func getIdx() -> Int {
        return self.idx
    }
    
    func getDate() -> String {
        return date
    }
    
    func setDateNumber(date: String) {
        var finalNum = 0
        var numbers = date.components(separatedBy: "/")
        var month = (Int(numbers[0]) ?? 0) * 30
        var day = Int(numbers[1]) ?? 0
        var year = (Int(numbers[2]) ?? 0) * 365
        finalNum = month + day + year
        self.dateNumber = finalNum
    }
    
    func getDateNumber() -> Int {
        return self.dateNumber
    }
    
}

struct Pair: Identifiable, Hashable {
    
    let question: String
    let answer: String
    let id: UUID = UUID()
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}



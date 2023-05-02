//
//  WriteReportModel.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/18/23.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class WriteReportModel: ObservableObject {
    
   
    private var username = ""
    
    private let ref = Database.database().reference()
    
    func addUserName(username: String) {
        let tmpUsername = username.replacingOccurrences(of: ".", with: ",").lowercased()
        self.username = tmpUsername
    }
    
    func pushReportModels(reportModels: [ReportModel]) {
        let refToAdd = ref.child("users").child(username).childByAutoId()
        
        for i in 0...reportModels.count - 1 {
            var question = reportModels[i].getQuestion().replacingOccurrences(of: ".", with: ",")
            var answer = reportModels[i].getAnswer()
            if answer.count == 0 {
                answer = "N/A"
            }
           
            refToAdd.child(question).setValue(answer)
        }
    }
    
    
    func pushToSheets(reportModels: [ReportModel]) {
        
        var questions = [String]()
        var answers = [String]()
        
        for i in 0..<reportModels.count {
            var q = reportModels[i].getQuestion()
            var a = reportModels[i].getAnswer()
            questions.append(q)
            answers.append(a)
        }
        let jsonObJ = JSON(questions: questions, answers: answers)
        
        let json = jsonObJ.getObjectJSON()
        
        let url = URL(string: "https://script.google.com/macros/s/AKfycbx8wxoe8Vv9FLgDOu9BWsxvAbglIA24l83lHuJ75RmHvfhWjBrwkrhgfRrzJ6E0bTzKdQ/exec")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let dataJSON = try! JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = dataJSON
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("in task")
            if let data = data {
                print("did not error")
                return
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        
        task.resume()
    }
    
}

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
            /*
            if (question.contains(".") || question.contains("#") || question.contains("$") || question.contains("[") || question.contains("]") || answer.contains(".") || answer.contains("#") || answer.contains("$") || answer.contains("[") || answer.contains("]")) || question == "" || answer == "" {
                print("*****", question, answer, i)
            }
             */
            //print(i, question)
            refToAdd.child(question).setValue(answer)
        }
    }
    
    
    func pushTooGoogleSHeets() {
        
    }
    
    
    func pushNewValue() {
        //ref.setValue(value)
        
        let refToAdd = ref.child("users").child(username).childByAutoId()
        refToAdd.child("Question").setValue("Answer")
        //refToAdd.setValue("answer", forKey: "Question")
        //ref.child("users").child(username).childByAutoId().setValue("answer", forKey: "Question")
        
        
        /*
        do {
            do {
                try ref.child("users").child(username).childByAutoId().setValue("beans", forKey: "ben")
            } catch let error as NSException {
                print(error)
                ref.child("users").setNilValueForKey(username)
                ref.child("users").child(username).childByAutoId().setValue("answer", forKey: "Question")
            }
        }
         */
    }
        
}

//
//  ReadReportModel.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/16/23.
//

import Foundation
import FirebaseDatabase


class ReadReportModel: ObservableObject {
    
    
    var ref = Database.database().reference()
    
    @Published var created: Bool = false
    
    @Published var reportModels: [ReportModel] = []
    
    @Published var pastReportModels: [ReportModel] = []
    
    @Published var value: String? = nil
    
    private var username = ""
    
    func addUserName(username: String) {
        let tmpUsername = username.replacingOccurrences(of: ".", with: ",").lowercased()
        self.username = tmpUsername
    }
    
    
    //@Published var halfReportModel: HalfReportModel ?= nil
    
    
    func readValue() {
       ref.child("Questions").observeSingleEvent(of: .value) { snapshot in
            self.value = snapshot.value as? String
        }
    }
    
    func createReportModels() {
        ref.child("Questions").observeSingleEvent(of: .value) { snapshot in
            let allChildren = snapshot.children.allObjects as! [DataSnapshot]
            self.reportModels = [ReportModel](repeating: ReportModel(), count: allChildren.count)
            for snap in allChildren {
                var idx:Int = (Int(snap.key) ?? 1) - 1
                var question:String = ""
                var type:String = ""
                var choices:String = ""
                
                if let mType = snap.childSnapshot(forPath: "type").value as? String {
                    type = mType
                }
                if let mQuesion = snap.childSnapshot(forPath: "question").value as? String {
                   question = mQuesion
                }
                if let mChoices = snap.childSnapshot(forPath: "choices").value as? String {
                   choices = mChoices
                }
                print(type, question,  choices)
                self.reportModels[idx] = ReportModel(type: type, question: question, mChoices: choices, idx: idx)
            }
            //self.reportModels.remove(at: 0)
        }
        created = true
    }
    
    func readHistory() {
        ref.child("users").child(username).observeSingleEvent(of: .value) { snapshot in
            let allChildren = snapshot.children.allObjects as! [DataSnapshot]
            var count = 1
            //var array = [][]
            for snap in allChildren {
                
            }
        }
    }
    
    /*
    func readObject(){
        ref.child("1").observeSingleEvent(of: .value) { snapshot in
            do {
                var halfReportModel = snapshot.data(as: HalfReportModel.self)
            } catch {
                print("cannot conver object")
            }
        }
        
    }
     */
    
    
}


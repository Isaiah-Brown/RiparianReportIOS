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
    
    @Published var value: String? = nil
    
    
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
                var idx:Int = Int(snap.key) ?? 0
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
                if idx < self.reportModels.count {
                    self.reportModels.remove(at: idx)
                }
                self.reportModels.insert(ReportModel(type: type, question: question, mChoices: choices, idx: idx), at: idx)
            }
        }
        created = true
        print(reportModels.count)
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

class ReportModelArray: ObservableObject {
    
}

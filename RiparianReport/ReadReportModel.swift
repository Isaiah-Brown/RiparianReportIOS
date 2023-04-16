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
    
    
    @Published var value: String? = nil
    //@Published var halfReportModel: HalfReportModel ?= nil
    
    
    func readValue() {
       ref.child("Questions").observeSingleEvent(of: .value) { snapshot in
            self.value = snapshot.value as? String
        }
    }
    
    func readSingleValue() {
        ref.child("Questions").observeSingleEvent(of: .value) { snapshot in
            let allChildren = snapshot.children.allObjects as! [DataSnapshot]
            for snap in allChildren {
                if let question = snap.childSnapshot(forPath: "question").value as? String {
                    print(question)
                }
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

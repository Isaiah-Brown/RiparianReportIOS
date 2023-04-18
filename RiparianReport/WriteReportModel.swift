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
    
    
    private let ref = Database.database().reference()
    
    
    func pushNewValue(value: String) {
        ref.setValue(value)
    }
}

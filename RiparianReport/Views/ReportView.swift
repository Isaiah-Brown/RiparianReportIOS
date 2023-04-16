//
//  ReportView.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/16/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase


var formReportModels: [ReportModel?] = []





struct ReportRow: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}



struct ReportView: View {
    @StateObject
    var readReportModel = ReadReportModel()
  
    
    var body: some View {
        if readReportModel.value != nil {
            Text(readReportModel.value!)
        } else {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        
        Button {
            readReportModel.readSingleValue()
        } label: {
            Text("Read from dataBase")
        }

    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}

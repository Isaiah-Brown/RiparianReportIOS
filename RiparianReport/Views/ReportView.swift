//
//  ReportView.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/16/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase


var formReportModels: [ReportModel] = []


struct ReportRow: View {
    @State var reportModels: [ReportModel]
    @State var reportModel: ReportModel
    @State var answer: String
    var body: some View {
        Text(reportModel.getQuestion())
        HStack {
            TextField("Answer", text: $answer)
            Button {
                reportModel.setAsnwer(answer: answer)
            } label: {
                Text("Enter")
            }

        }
    }
}

var reportModels: [ReportModel] = []

struct ReportView: View {
    @StateObject var readReportModel = ReadReportModel()
    
  
    var body: some View {
        Spacer()
        if readReportModel.created {
            List(readReportModel.reportModels, id: \.idx) { reportModel in
                ReportRow(reportModels: reportModels, reportModel: reportModel, answer: "")
            }
        } else {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        Spacer()
        Button {
           readReportModel.createReportModels()
           reportModels = readReportModel.reportModels
        } label: {
            Text("Read from dataBase")
        }
        Spacer()
        Button {
            for reportModel in reportModels {
                print("answer", reportModel.getAnswer())
            }
        } label: {
            Text("Print to console")
        }
        Spacer()
        
            .onAppear() {
                readReportModel.createReportModels()
                reportModels = readReportModel.reportModels
            }


    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}

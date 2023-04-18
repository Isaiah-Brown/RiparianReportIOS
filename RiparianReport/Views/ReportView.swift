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
    @StateObject var readReportModel: ReadReportModel
    @State var idx: Int
    @State var answer: String
    
    var body: some View {
        Text(readReportModel.reportModels[idx].getQuestion())
        HStack {
            TextField("Answer", text: $answer)
            Button {
                readReportModel.reportModels[idx].setAsnwer(answer: answer)
            } label: {
                Text("Enter")
            }

        }
    }
}

var reportModels: [ReportModel] = []

struct ReportView: View {
    
    @StateObject var readReportModel = ReadReportModel()
    @StateObject var writeReportModel = WriteReportModel()
    @EnvironmentObject var appState: AppState
    
  
    var body: some View {
        Spacer()
        if readReportModel.created {
            List(readReportModel.reportModels, id: \.idx) { reportModel in
                ReportRow(readReportModel: readReportModel, idx: reportModel.getIdx(), answer: "")
            }
        } else {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        Spacer()
        Button {
           
        } label: {
            Text("push to database")
        }
        Spacer()
        Button {
            for reportModel in readReportModel.reportModels {
                print("answer", reportModel.getAnswer())
            }
            print("printed to console", readReportModel.reportModels.count)
        } label: {
            Text("Print to console")
        }
        Spacer()
            .onAppear() {
                readReportModel.createReportModels()
                reportModels = readReportModel.reportModels
                let user = Auth.auth().currentUser
                let mEmail = user?.email
                print(mEmail)
                //print("saved email", appState.username)
                
            }


    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}

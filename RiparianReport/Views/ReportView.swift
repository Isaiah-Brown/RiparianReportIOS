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
    @State var date = Date()
    @State var rowAnswered = false
    @State var pickerAnswer: String
    
    
    var body: some View {
        ZStack {
            if (readReportModel.reportModels[idx].getAnswer() != "") {
                Rectangle().foregroundColor(Color.accentColor).ignoresSafeArea().opacity(0.1)
            } else {
                //.listRowBackground(Color("MatteBlack"))
            }
            if (readReportModel.reportModels[idx].getType() == "TEXT") {
                VStack(alignment: .leading){
                    Text(readReportModel.reportModels[idx].getQuestion())
                    TextField("Answer", text: $answer)
                        .onChange(of: answer) { newValue in
                            readReportModel.reportModels[idx].setAsnwer(answer: answer)
                        }
                }
            } else if readReportModel.reportModels[idx].getType() == "DATE" {
                HStack{
                    DatePicker(readReportModel.reportModels[idx].getQuestion(), selection: $date, displayedComponents: .date)
                        .onTapGesture {
                            let formatter = DateFormatter()
                            formatter.dateStyle = .short
                            answer = formatter.string(from: date)
                            print(answer)
                            readReportModel.reportModels[idx].setAsnwer(answer: answer)
                        }
                        //datePicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
                }
        
            } else if readReportModel.reportModels[idx].getType() == "MULTIPLE_CHOICE" {
                VStack{
                    HStack{
                        Picker(readReportModel.reportModels[idx].getQuestion(), selection: $pickerAnswer) {
                            ForEach(readReportModel.reportModels[idx].getChoices(), id: \.self) {
                                Text($0).foregroundColor(Color.accentColor)
                            }.onChange(of: pickerAnswer) { newValue in
                                readReportModel.reportModels[idx].setAsnwer(answer: pickerAnswer)
                            }
                        }
                    }
                }
                
            } else if readReportModel.reportModels[idx].getType() == "MULTIPLE_CHOICE_OTHER" {
                VStack{
                    HStack{
                        Picker(readReportModel.reportModels[idx].getQuestion(), selection: $pickerAnswer) {
                            ForEach(readReportModel.reportModels[idx].getChoices(), id: \.self) {
                                Text($0).foregroundColor(Color.accentColor)
                            }.onChange(of: pickerAnswer) { newValue in
                                if pickerAnswer != "Other:" {
                                    readReportModel.reportModels[idx].setAsnwer(answer: pickerAnswer)
                                }
                            }
                            
                        }
                    }
                    HStack {
                        if (pickerAnswer == "Other:") {
                            TextField("Answer", text: $answer)
                                .onSubmit {
                                    readReportModel.reportModels[idx].setAsnwer(answer: answer)
                                }
                        }
                        
                    }
                }
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
        ZStack {
            //Rectangle().foregroundColor((Color("MatteBlack"))).ignoresSafeArea()
            VStack {
                if readReportModel.created {
                    List(readReportModel.reportModels) { reportModel in
                        ReportRow(readReportModel: readReportModel, idx: reportModel.getIdx(), answer: "", date: Date(), rowAnswered: false, pickerAnswer: "")
                            //.listRowBackground(Color(.gray)).opacity(0.1)
                    }   .listStyle(.plain)
                       
                    
                } else {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                Button {
                    writeReportModel.pushReportModels(reportModels: readReportModel.reportModels)
                } label: {
                    Text("Submit Answers")
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
                        writeReportModel.addUserName(username: appState.username)
                        readReportModel.createReportModels()
                        //reportModels = readReportModel.reportModels
                        let user = Auth.auth().currentUser
                        let mEmail = user?.email
                        print(mEmail)
                        print("username****", appState.username)
                        //print("saved email", appState.username)
                    }
            }
        }


    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}

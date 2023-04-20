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
                Rectangle().foregroundColor(Color.accentColor).ignoresSafeArea()
            } else {
                //.listRowBackground(Color("MatteBlack"))
            }
            if (readReportModel.reportModels[idx].getType() == "TEXT") {
                VStack{
                    HStack{
                        Text(readReportModel.reportModels[idx].getQuestion()).foregroundColor(Color("Sand"))
                            .foregroundColor(Color.gray)
                        Spacer()
                    }
                    HStack{
                        TextField("Answer", text: $answer).foregroundColor(Color("Sand"))
                        Button {
                            readReportModel.reportModels[idx].setAsnwer(answer: answer)
                        } label: {
                            Text("Enter").foregroundColor(Color.accentColor)
                        }
                    }
                }
            } else if readReportModel.reportModels[idx].getType() == "DATE" {
                HStack{
                    DatePicker(readReportModel.reportModels[idx].getQuestion(), selection: $date, displayedComponents: .date)
                        //datePicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
                    
                    Spacer()
                    Button {
                        let formatter = DateFormatter()
                        formatter.dateStyle = .short
                        answer = formatter.string(from: date)
                        print(answer)
                        readReportModel.reportModels[idx].setAsnwer(answer: answer)
                    } label: {
                        Text("Enter").foregroundColor(Color.accentColor)
                    }
                }
        
            } else if readReportModel.reportModels[idx].getType() == "MULTIPLE_CHOICE" {
                VStack{
                    HStack{
                        Picker(readReportModel.reportModels[idx].getQuestion(), selection: $pickerAnswer) {
                            ForEach(readReportModel.reportModels[idx].getChoices(), id: \.self) {
                                Text($0).foregroundColor(Color.accentColor)
                            }
                        }
                    }
                    HStack{
                        TextField("Answer", text: $answer).foregroundColor(Color("Sand"))
                        Spacer()
                        Button {
                            answer = pickerAnswer
                            readReportModel.reportModels[idx].setAsnwer(answer: pickerAnswer)
                        } label: {
                            Text("Enter").foregroundColor(Color.accentColor)
                        }
                    }
                }
                
            } else if readReportModel.reportModels[idx].getType() == "MULTIPLE_CHOICE_OTHER" {
                VStack{
                    HStack{
                        Picker(readReportModel.reportModels[idx].getQuestion(), selection: $pickerAnswer) {
                            ForEach(readReportModel.reportModels[idx].getChoices(), id: \.self) {
                                Text($0).foregroundColor(Color.accentColor)
                            }
                            
                        }
                            //.compositingGroup()
                            //.clipped()

                    }
                    HStack {
                        TextField("Answer", text: $answer).foregroundColor(Color("Sand"))
                        Spacer()
                        Button {
                            if (pickerAnswer == "Other:") {
                                readReportModel.reportModels[idx].setAsnwer(answer: answer)
                            } else {
                                answer = pickerAnswer
                                readReportModel.reportModels[idx].setAsnwer(answer: answer)
                                
                            }
                        } label: {
                            Text("Enter").foregroundColor(Color.accentColor)
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

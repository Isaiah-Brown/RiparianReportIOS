//
//  ReportView.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/16/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase


//var formReportModels: [ReportModel] = []



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
            if (readReportModel.reportModels[idx].getType() == "TEXT" || readReportModel.reportModels[idx].getType() == "LOCATION"){
                VStack(alignment: .leading){
                    Text(readReportModel.reportModels[idx].getQuestion())
                        .foregroundColor(Color("Sand"))
                        .font(.custom("Poppins-Bold", size: 16))
                    ZStack{
                        TextField("", text: $answer)
                            .font(.custom("Poppins-Light", size:16))
                            .foregroundColor(Color.accentColor)
                            .onChange(of: answer) { newValue in
                                readReportModel.reportModels[idx].setAsnwer(answer: answer)
                            }
                        /*
                        if (answer.isEmpty) {
                            HStack{
                                Text("Answer")
                                    .foregroundColor(Color.accentColor)
                                    .font(.custom("Poppins-Light", size:16))
                                Spacer()
                            }
                        }*/
                    }
                }
                .listRowBackground(Color("MatteBlack"))
            } else if readReportModel.reportModels[idx].getType() == "DATE" {
                HStack{
                    Text(readReportModel.reportModels[idx].getQuestion())
                        .foregroundColor(Color("Sand"))
                        .font(.custom("Poppins-Bold", size: 16))
                    DatePicker("", selection: $date, displayedComponents: .date)
                        //.accentColor(Color.accentColor)
                        .onTapGesture {
                            let formatter = DateFormatter()
                            formatter.dateStyle = .short
                            answer = formatter.string(from: date)
                            print(answer)
                            readReportModel.reportModels[idx].setAsnwer(answer: answer)
                        }
                        .onChange(of: date) { newValue in
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
                    Menu{
                        Picker(readReportModel.reportModels[idx].getQuestion(), selection: $pickerAnswer) {
                            ForEach(readReportModel.reportModels[idx].getChoices(), id: \.self) {
                                Text($0).foregroundColor(Color.accentColor)
                            }.onChange(of: pickerAnswer) { newValue in
                                readReportModel.reportModels[idx].setAsnwer(answer: pickerAnswer)
                            }
                        }
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(readReportModel.reportModels[idx].getQuestion())
                                    .foregroundColor(Color("Sand"))
                                    .font(.custom("Poppins-Bold", size: 16))
                                Spacer()
                            }
                            if (pickerAnswer) != "Other:" {
                                Text(pickerAnswer).padding(.top, 1)
                                    .font(.custom("Poppins-Light", size:16))
                                    .foregroundColor(Color.accentColor)
                            }
                            
                        }
                    }
                }
                
            } else if readReportModel.reportModels[idx].getType() == "MULTIPLE_CHOICE_OTHER" {
                VStack{
                        Menu {
                            Picker(readReportModel.reportModels[idx].getQuestion(), selection: $pickerAnswer) {
                                ForEach(readReportModel.reportModels[idx].getChoices(), id: \.self) {
                                    Text($0)
                                }
                                .onChange(of: pickerAnswer) { newValue in
                                    if pickerAnswer != "Other:" {
                                        readReportModel.reportModels[idx].setAsnwer(answer: pickerAnswer)
                                    }
                                }
                                
                            }
                        } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(readReportModel.reportModels[idx].getQuestion())
                                        .foregroundColor(Color("Sand"))
                                        .font(.custom("Poppins-Bold", size: 16))
                                    Spacer()
                                }
                                if (pickerAnswer) != "Other:" {
                                    Text(pickerAnswer).padding(.top, 1)
                                }
                                
                            }
                        }
                    HStack {
                        if (pickerAnswer == "Other:") {
                            ZStack {
                                TextField("", text: $answer)
                                    .font(.custom("Poppins-Light", size:16))
                                    .foregroundColor(Color.accentColor)
                                    .onChange(of: answer) { newValue in
                                        readReportModel.reportModels[idx].setAsnwer(answer: answer)
                                    }
                                /*
                                if (answer.isEmpty) {
                                    HStack{
                                        Text("Answer").foregroundColor(Color.accentColor)
                                        Spacer()
                                    }
                                }*/
                            }
                            
                        }
                        
                        
                    }
                }
            }
                //.listRowBackground(Color("MatteBlack"))
            
        }
       
    }
}



struct ReportView: View {
    @Binding var path: [String]
    @ObservedObject var readReportModel: ReadReportModel
    @ObservedObject var writeReportModel: WriteReportModel
    @EnvironmentObject var appState: AppState
    @State private var showingAlert = false
    @State private var goBackToHome = false
    @State private var formCompleted = false
    
   
    var body: some View {
       ZStack {
           VStack {
               if readReportModel.created {
                   List(readReportModel.reportModels) { reportModel in
                       ReportRow(readReportModel: readReportModel, idx: reportModel.getIdx(), answer: "", date: Date(), rowAnswered: false, pickerAnswer: "")
                           .listRowBackground(Color("MatteBlack"))
                    }
                    .listStyle(.plain)
                    .ignoresSafeArea()
                    .padding(.top, 1)
                   
                   Spacer()
                   Button {
                       showingAlert = !readReportModel.isAllAnswered();
                       formCompleted = readReportModel.isAllAnswered();
                       if !showingAlert {
                           writeReportModel.pushReportModels(reportModels: readReportModel.reportModels)
                           writeReportModel.pushToSheets(reportModels: readReportModel.reportModels)
                       }
                   } label: {
                       ZStack {
                           Text("Submit").font(.custom("Poppins-Medium", size: 32)).foregroundColor(Color.accentColor)
                       }
                   }
                   .alert("Please answer all fields", isPresented: $showingAlert) {
                               Button("OK", role: .cancel) { }
                           }
                   .alert("Report Submitted!", isPresented: $formCompleted) {
                       Button("Back to Home", role: .cancel) {
                           path = []
                           
                       }
                   }
               }
            }
        }.background(Color("MatteBlack"))
    }

}

/*
 struct ReportView_Previews: PreviewProvider {
 static var previews: some View {
 ReportView()
 }
 }
 */

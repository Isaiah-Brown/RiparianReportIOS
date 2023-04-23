//
//  HistoryView.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/19/23.
//

import SwiftUI


struct DateRow: View {
    @StateObject var historyHelper: HistoryHelper
    @State var idx: Int
    var date: String
    var body: some View {
        NavigationLink {
            HistoryInnerView(questionSet: historyHelper.forms[idx].questionSet)
        } label: {
            HStack {
                Text(date)
            }
        }
    }
}

struct HistoryView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var historyHelper = HistoryHelper()
    
    var body: some View {
        //if historyHelper.initalized {
            List(historyHelper.forms) { form in
                DateRow(historyHelper: historyHelper, idx: form.getIdx(), date: form.date)
            }.onChange(of: historyHelper.initalized) { newValue in
                historyHelper.sortForms()
            }
        
        /*
        } else {
            Text("Loading")
        }*/
        Button {
            historyHelper.sortForms()
        }label: {
            Text("View Previous forms")
        }
        Spacer()
            .onAppear() {
                if !historyHelper.initalized {
                    DispatchQueue.main.async {
                        historyHelper.addUserName(username: appState.username)
                        historyHelper.initForms()
                        historyHelper.sortForms()
                    }
                    //historyHelper.addUserName(username: appState.username)
                    //historyHelper.initForms()
                    //historyHelper.sortForms()
                    
                }
                //if !historyHelper.isSorted {
                   // historyHelper.sortForms()
                //}
            }
            
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

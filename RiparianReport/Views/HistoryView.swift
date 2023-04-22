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
    var body: some View {
        NavigationLink {
            HistoryInnerView(questionSet: historyHelper.forms[idx].questionSet)
        } label: {
            HStack {
                Text(historyHelper.forms[idx].getDate())
                Text(String(historyHelper.forms[idx].getDateNumber()))
            }
        }
    }
}

struct HistoryView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var historyHelper = HistoryHelper()
    
    var body: some View {
        if historyHelper.created {
            List(historyHelper.forms) { form in
                DateRow(historyHelper: historyHelper, idx: form.getIdx())
            }
        } else {
            Text("Loading")
        }
        Button {
            historyHelper.sortForms()
        }label: {
            Text("View Previous forms")
        }
        Spacer()
            .onAppear() {
                if !historyHelper.created {
                    historyHelper.addUserName(username: appState.username)
                    historyHelper.findDateQuestion()
                }
            }
            
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

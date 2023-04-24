//
//  HistoryView.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/19/23.
//

import SwiftUI


struct DateRow: View {
    var form: Form
    var body: some View {
        NavigationLink {
            HistoryInnerView(questionSet: form.questionSet)
        } label: {
            HStack {
                Spacer()
                Image(systemName: "doc.fill")
                    .foregroundColor(Color("Sand"))
                    .font(.system(size: 28))
                Text(form.date)
                    .foregroundColor(Color.accentColor)
                    .font(.custom("Poppins-Bold", size: 30))
                Spacer()
            }
        }
    }
}

struct HistoryView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var historyHelper: HistoryHelper
    
    var body: some View {
        ZStack {
            //Color("MatteBlack").ignoresSafeArea()
            List(historyHelper.forms) { form in
                DateRow(form: form)
                    .listRowBackground(Color("MatteBlack"))
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .ignoresSafeArea()
            .padding(.top, 1)
            //.scrollContentBackground(.hidden)
            }
        .background(Color("MatteBlack"))
    }
}

/*
struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(historyHelper: HistoryHelper)
    }
}*/

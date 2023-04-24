//
//  HistoryInnerView.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/22/23.
//

import SwiftUI

struct HistoryInnerRow: View {
    let pair: Pair
    var body: some View {
        VStack(alignment: .leading) {
            Text(pair.question).foregroundColor(Color("Sand"))
                .font(.custom("Poppins-Bold", size: 18))
            Text(pair.answer).foregroundColor(Color.accentColor)
                .font(.custom("Poppins-Medium", size:18))
        }
    }
}

struct HistoryInnerView: View {
    let questionSet: [Pair]
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        ZStack {
            List(questionSet) { pair in
                HistoryInnerRow(pair: pair)
                    .listRowBackground(Color("MatteBlack"))
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .ignoresSafeArea()
            .padding(.top, 1)
        }.background(Color("MatteBlack"))
    }
}

/*
 struct HistoryInnerView_Previews: PreviewProvider {
 static var previews: some View {
 HistoryInnerView(questionSet: historyHelper.forms[idx].questionSet)
 }
 }
 */

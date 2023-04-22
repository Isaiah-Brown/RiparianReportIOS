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
            Text(pair.question)
            Text(pair.answer)
        }
    }
}

struct HistoryInnerView: View {
    let questionSet: [Pair]
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        List(questionSet) { pair in
            HistoryInnerRow(pair: pair)
        }
    }
}

/*
 struct HistoryInnerView_Previews: PreviewProvider {
 static var previews: some View {
 HistoryInnerView(questionSet: historyHelper.forms[idx].questionSet)
 }
 }
 */

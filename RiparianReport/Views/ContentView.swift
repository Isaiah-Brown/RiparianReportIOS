//
//  ContentView.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/14/23.
//



/*
init() {
    for familyName in  UIFont.familyNames {
        print(familyName)
        for fontName in UIFont.fontNames(forFamilyName: familyName) {
            print("-- \(fontName)")
        }
    }
}
 */

import SwiftUI



struct ReportRow: View {
    var graphic: String
    var caption: String
    
    var body: some View {
        VStack{
            Image(graphic).foregroundColor(Color("Sand"))
            Text(caption).foregroundColor(Color.accentColor).font(.custom("Poppins-Bold", size: 32))
        }.padding(10)
    
    }
    
    
}

struct ContentView: View {
    var body: some View {
        
        ZStack {
            Rectangle().foregroundColor((Color("MatteBlack"))).ignoresSafeArea()
            VStack {
                ReportRow(graphic: "mapGraphic", caption: "Map")
                ReportRow(graphic: "reportGraphic", caption: "Report")
                ReportRow(graphic: "historyGraphic", caption: "History")
            }
            .padding(20)
            .foregroundColor(Color("MatteBlack"))
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

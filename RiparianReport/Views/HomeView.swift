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
import Firebase
import FirebaseAuth



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


struct HomeView: View {
    @State private var path = NavigationPath()
    @EnvironmentObject var appState: AppState
    var body: some View {
        NavigationStack(path: $path){
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
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

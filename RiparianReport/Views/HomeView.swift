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



struct HomeRow: View {
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
                    Spacer()
                    Button {
                        //
                    } label: {
                        Image("mapGraphic").foregroundColor(Color("Sand"))
                        Text("Map").foregroundColor(Color.accentColor).font(.custom("Poppins-Bold", size: 32))
                    }
                    Spacer()
                    
                    Button {
                        path.append("ReportView")
                    } label: {
                        Image("reportGraphic").foregroundColor(Color("Sand"))
                        Text("Report").foregroundColor(Color.accentColor).font(.custom("Poppins-Bold", size: 32))
                    }
                    Spacer()
                    Button {
                        //
                    } label: {
                        Image("historyGraphic").foregroundColor(Color("Sand"))
                        Text("History").foregroundColor(Color.accentColor).font(.custom("Poppins-Bold", size: 32))
                    }
                    Button {
                        logoutUser()
                    } label: {
                        Text("Logout").foregroundColor(Color("Sand"))
                    }

                }
                .foregroundColor(Color("MatteBlack"))
            }
            .navigationDestination(for: String.self) { view in
                if view == "ReportView" {
                    ReportView()
                }
            }
        }
    }
    func logoutUser() {
        // call from any screen
        
        do {
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
            print("is active user?")
            //appState.setLoggedOut()
            //appState.username = ""
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

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


struct HomeLogoView: View {
    @EnvironmentObject var appState: AppState
    @State private var showingAlert = false
    var body: some View {
        HStack {
            Spacer()
            Button {
                showingAlert = true
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundColor(Color("Sand"))
                    .font(.system(size: 50))
            }
            .alert(isPresented:$showingAlert) {
                Alert(
                    title: Text("Are you sure you want to logout"),
                    message: Text("You will have to sign back in"),
                    primaryButton: .destructive(Text("Logout")) {
                        logoutUser()
                        print("Logging out")
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        ZStack {
            Image("leaf").resizable().scaledToFit()
            //Image(systemName: "house.fill")
               // .foregroundColor(Color("MatteBlack"))
                //.font(.system(size: 50))
        }
    }
    func logoutUser() {
        // call from any screen
        
        do {
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
                appState.setLoggedOut()
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
            print("is active user?")
            appState.setLoggedOut()
            appState.removeUserName()
        }
    }
}

//


struct HomeRow: View {
    var graphic: String
    var caption: String
    @EnvironmentObject var appState: AppState
    var body: some View {
        VStack{
            Image(graphic).foregroundColor(Color("Sand"))
            Text(caption).foregroundColor(Color.accentColor).font(.custom("Poppins-Bold", size: 32))
        }.padding(10)
            .onAppear() {
                print(appState.username, "username")
            }
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
                    HomeLogoView()
       
                    Button {
                        path.append("ReportView")
                    } label: {
                        Image(systemName: "arrow.up.doc.fill")
                            .foregroundColor(Color("Sand"))
                            .font(.system(size: 50))
                        Text("Report").foregroundColor(Color.accentColor).font(.custom("Poppins-Bold", size: 32))
                    }
                    Spacer()
                    Button {
                        path.append("HistoryView")
                    } label: {
                        Image(systemName: "clock.fill")
                            .foregroundColor(Color("Sand"))
                            .font(.system(size: 50))
                        Text("History").foregroundColor(Color.accentColor).font(.custom("Poppins-Bold", size: 32))
                    }
                    Spacer()
                }
                .foregroundColor(Color("MatteBlack"))
            }
            .navigationDestination(for: String.self) { view in
                if view == "ReportView" {
                    ReportView()
                } else if view == "HistoryView" {
                    HistoryView()
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

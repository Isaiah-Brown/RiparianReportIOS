//
//  RiparianReportApp.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/14/23.
//

import SwiftUI
import Firebase
import FirebaseAuth


class AppState: ObservableObject {
    @Published var loggedIn: Bool
    
    init(loggedIn: Bool) {
        self.loggedIn = loggedIn
    }
}

func userIsLoggedIn() -> Bool {
    
    var loggedIn:Bool
    //Auth.auth().addStateDidChangeListener { auth, user in
        //if user != nil {
            //loggedIn = true;
        //}
    //}
    if Auth.auth().currentUser?.uid != nil {
        loggedIn = true
    }else{
        loggedIn = false
    }
    return loggedIn;
}


@main
struct RiparianReportApp: App {
    @ObservedObject var appState = AppState(loggedIn: false)
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if appState.loggedIn {
                HomeView()
                    .environmentObject(appState)
            } else {
                LoginView()
                    .environmentObject(appState)
            }
            
        }
    }
}


//
//  RiparianReportApp.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/14/23.
//

import SwiftUI
import Firebase


class AppState: ObservableObject {
    @Published var loggedIn: Bool
    
    init(loggedIn: Bool) {
        self.loggedIn = loggedIn
    }
}

func userIsLoggedIn() -> Bool {
    var loggedIn = false;
    Auth.auth().addStateDidChangeListener { auth, user in
        if user != nil {
            loggedIn = true;
        }
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


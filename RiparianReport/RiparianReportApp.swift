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
    
    @AppStorage("Username") var username: String = ""
    
    init(loggedIn: Bool) {
        self.loggedIn = loggedIn
    }
    
    func setLoggedIn() {
        loggedIn = true
    }
    
    func setLoggedOut() {
        loggedIn = false
    }
    
    func saveUserName(userName: String) {
        self.username = userName
    }
    
    func removeUserName() {
        self.username = ""
    }
    
    func checkIfActiveUser() {
        
        Auth.auth().addStateDidChangeListener { [self] auth, user in
            if user != nil {
                // User is signed in. Show home screen
                loggedIn = true
                if (username == "" || username == " ") {
                    loggedIn = false
                }
                print("active user", username)
            }else {
                loggedIn = false
                print("no active user")
                
            }

        }
    }
}

    




@main
struct RiparianReportApp: App {
    @ObservedObject var appState = AppState(loggedIn: false)
    
    
    init() {
        FirebaseApp.configure()
        appState.checkIfActiveUser()
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


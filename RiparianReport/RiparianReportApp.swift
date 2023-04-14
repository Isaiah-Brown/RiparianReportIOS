//
//  RiparianReportApp.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/14/23.
//

import SwiftUI
import Firebase

@main
struct RiparianReportApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

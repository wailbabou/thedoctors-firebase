//
//  TheDoctorsApp.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import SwiftUI
import Firebase
@main
struct TheDoctorsApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SharedViewModel()).statusBar(hidden: true)
        }
    }
}

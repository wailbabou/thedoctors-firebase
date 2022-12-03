//
//  AdminViewModel.swift
//  TheDoctors
//
//  Created by mac on 3/1/2022.
//

import Foundation
import FirebaseAuth

class AdminViewModel : ObservableObject {
    @Published var password = ""
    @Published var email = ""
    @Published var goToDashboard = false
    
    @Published var error = false
    @Published var errorMsg = ""
    func loginAdmin(){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let user = result?.user {
                print(user)
                self.goToDashboard = true
            } else {
                print("failed")
                self.errorMsg = "Failed to login"
                self.error = true
            }
        }
    }
}

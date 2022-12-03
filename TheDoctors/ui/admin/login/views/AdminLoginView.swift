//
//  AdminLogin.swift
//  TheDoctors
//
//  Created by mac on 3/1/2022.
//

import SwiftUI
import FirebaseAuth

struct AdminLoginView: View {
    @StateObject var adminVM = AdminViewModel()
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    NavigationLink(destination: DashboardView(isActive: self.$adminVM.goToDashboard), isActive: self.$adminVM.goToDashboard) {
                        EmptyView()
                    }
                }.hidden()
                Spacer()
                
                TextField("Email",text: self.$adminVM.email).padding()
                SecureField("Password",text: self.$adminVM.password).padding()
                
                Button {
                    adminVM.loginAdmin()
                } label: {
                    Text("Sign In")
                        .foregroundColor(Color.white)
                        .padding()
                }.background(Color("welcome_background"))
                    .clipShape(Capsule())
                Spacer()
            }.onAppear {
                if Auth.auth().currentUser != nil {
                  // User is signed in.
                    self.adminVM.goToDashboard = true
                } else {
                  // No user is signed in.
                  // ...
                }
            }.alert(self.adminVM.errorMsg, isPresented: self.$adminVM.error) {
                Button("OK", role: .cancel){}
            }
        }
    }
}

struct AdminLogin_Previews: PreviewProvider {
    static var previews: some View {
        AdminLoginView()
    }
}

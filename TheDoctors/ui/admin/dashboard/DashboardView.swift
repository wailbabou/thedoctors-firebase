//
//  DashboardView.swift
//  TheDoctors
//
//  Created by mac on 4/1/2022.
//

import SwiftUI
import FirebaseAuth
struct DashboardView: View {
    @Binding var isActive : Bool
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                NavigationLink {
                    ManageCategoriesView()
                } label: {
                    HStack {
                        Spacer()
                        Text("Manage Categories")
                            .font(.title)
                        Spacer()
                    }
                }
                Spacer()
            }
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding()
            
            VStack {
                Spacer()
                NavigationLink {
                    WaitingDoctorsView()
                } label: {
                    HStack {
                        Spacer()
                        Text("Waiting Doctors")
                            .font(.title)
                        Spacer()
                    }
                }
                Spacer()
            }
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding()
        }.navigationBarTitle(Text("Dashboard"))
            .navigationBarItems(trailing: Button(action: {
                do {
                    try Auth.auth().signOut()
                    self.isActive = false
                } catch let signOutError as NSError {
                  print("Error signing out: %@", signOutError)
                }
            }, label: {
                Text("Logout")
            }))
            .navigationBarBackButtonHidden(true)

    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(isActive: .constant(true))
    }
}

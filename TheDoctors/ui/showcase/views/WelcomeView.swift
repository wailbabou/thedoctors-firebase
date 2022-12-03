//
//  WelcomeView.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var sharedVM : SharedViewModel
    @State var sheetDoctor = false
    
    var body: some View {
        VStack {
            Image("doctor_welcome")
                .resizable()
                .scaledToFit()
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Text("Find ")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                    + Text("a best ")
                        .fontWeight(.none)
                        .font(.title)
                        .foregroundColor(.white)
                    + Text("Doctor")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("Nearby")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("Find your doctor now")
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                    HStack {
                        Button {
                            // action go to doctor
                            self.sheetDoctor = true
                        } label: {
                            Text("I'm a doctor")
                                .foregroundColor(.white)
                                .padding()
                        }.overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 2))
                        // -----
                        Button {
                            // ...
                            self.sharedVM.goToHome = true
                        } label: {
                            Text("Let's Go")
                                .foregroundColor(Color("welcome_background"))
                                .padding()
                        }.background(Color.white)
                            .clipShape(Capsule())
                    }
                    Spacer()
                }
                Spacer()
            }
            .sheet(isPresented: self.$sheetDoctor, content: {
                AddDoctorView(isActive: self.$sheetDoctor)
            })
            .background(Color("welcome_background"))
            .cornerRadius(40, corners: [.topLeft, .topRight])
            
        }
        .ignoresSafeArea(edges:.bottom)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

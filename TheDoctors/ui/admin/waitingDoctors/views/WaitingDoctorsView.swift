//
//  WaitingDoctorsView.swift
//  TheDoctors
//
//  Created by mac on 4/1/2022.
//

import SwiftUI

struct WaitingDoctorsView: View {
    @Namespace private var animation

    let columns = [
        GridItem(.flexible())
    ]
    @StateObject var waitingDoctorsVM = WaitingDoctorViewModel()
    
    var body: some View {
        ZStack{
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(waitingDoctorsVM.doctors , id: \.id){ doc in
                        DoctorRow(doctor: doc,animation: animation,fullWidth: true)
                            .padding(.leading,3)
                            .padding(.vertical)
                            .shadow(radius: 2)
                            .onTapGesture {
                                withAnimation(.spring()){
                                    waitingDoctorsVM.selectedDoctor = doc
                                    waitingDoctorsVM.showCard.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn){
                                            waitingDoctorsVM.showContent = true
                                        }
                                    }
                                }
                            }
                    }
                    
                }
                .padding(.horizontal)
            }
            .navigationBarTitle(Text("Waiting Doctors"))
            .onAppear {
                self.waitingDoctorsVM.getDoctors()
            }
            
            if waitingDoctorsVM.showCard {
                SingleDoctorView(showCard: self.$waitingDoctorsVM.showCard, showContent: self.$waitingDoctorsVM.showContent, doctor: waitingDoctorsVM.selectedDoctor, animation: animation,isAdmin: true)
            }
        }
    }
}

struct WaitingDoctorsView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingDoctorsView()
    }
}

//
//  DoctorsView.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import SwiftUI

struct DoctorsView: View {
    @ObservedObject var homeVM:HomeViewModel
    var animation: Namespace.ID

    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack {
                Spacer().frame(width: 12)
                ForEach(homeVM.doctors , id: \.id){ doc in
                    DoctorRow(doctor: doc,animation: animation)
                        .padding(.leading,3)
                        .padding(.vertical)
                        .shadow(radius: 2)
                        .onTapGesture {
                            withAnimation(.spring()){
                                homeVM.selectedDoctor = doc
                                homeVM.showCard.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation(.easeIn){
                                        homeVM.showContent = true
                                    }
                                }
                            }
                        }
                }
                
            }
        }
    }
}

struct DoctorsView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorsView(homeVM: HomeViewModel(), animation: Namespace.init().wrappedValue)
    }
}

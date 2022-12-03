//
//  DoctorsByCategoryView.swift
//  TheDoctors
//
//  Created by mac on 2/1/2022.
//

import SwiftUI

struct DoctorsByCategoryView: View {
    @Namespace private var animation
    
    var category : Category
    let columns = [
        GridItem(.flexible())
    ]
    @StateObject var doctorsByCategoryVM = DoctorsByCategoryVM()
    
    init(category : Category){
        self.category = category
    }
    
    var body: some View {
        ZStack{
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(doctorsByCategoryVM.doctors , id: \.id){ doc in
                        DoctorRow(doctor: doc,animation: animation,fullWidth: true)
                            .padding(.leading,3)
                            .padding(.vertical)
                            .shadow(radius: 2)
                            .onTapGesture {
                                withAnimation(.spring()){
                                    doctorsByCategoryVM.selectedDoctor = doc
                                    doctorsByCategoryVM.showCard.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn){
                                            doctorsByCategoryVM.showContent = true
                                        }
                                    }
                                }
                            }
                    }
                    if doctorsByCategoryVM.doctors.count == 0 &&  doctorsByCategoryVM.loaded {
                        HStack {
                            Text("Empty List").foregroundColor(.secondary)
                        }
                    }
                    if doctorsByCategoryVM.lastSnapshot != nil {
                        HStack{
                            Spacer()
                            Button {
                                // ..
                                doctorsByCategoryVM.loadMore(category: category.name)
                            } label: {
                                Text("Load More")
                            }
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle(Text(category.name))
            .onAppear {
                self.doctorsByCategoryVM.getDoctorsByCategory(category: category.name)
            }
            
            if doctorsByCategoryVM.showCard {
                SingleDoctorView(showCard: self.$doctorsByCategoryVM.showCard, showContent: self.$doctorsByCategoryVM.showContent, doctor: doctorsByCategoryVM.selectedDoctor, animation: animation)
            }
        }
    }
}

struct DoctorsByCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorsByCategoryView(category: PreviewData.category)
    }
}

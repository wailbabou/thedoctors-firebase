//
//  HomeView.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    @Namespace private var animation

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        VStack {
                            NavigationLink(isActive: self.$homeVM.goToSearch) {
                                SearchResultView(search: self.homeVM.searchText)
                            } label: {
                                EmptyView()
                            }
                        }.hidden()
                        HStack {
                            Spacer()
                        }.padding()
                        Text("Do you need help?")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        Text("Let's Find Your Doctor")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .lineLimit(2)
                            .padding(.horizontal)
                        
                        SearchBarView(searchText: self.$homeVM.searchText, homeVM: self.homeVM)
                            .padding(.horizontal)
                        
                        Text("Categories")
                            .font(.headline)
                            .foregroundColor(Color("welcome_background"))
                            .padding(.horizontal)
                        
                        if homeVM.categories.count > 0 {
                            CategoriesView(homeVM: self.homeVM)
                        }
                        
                        Text("Last Doctors")
                            .font(.headline)
                            .foregroundColor(Color("welcome_background"))
                            .padding(.horizontal)
                        if homeVM.doctors.count > 0 {
                            DoctorsView(homeVM: self.homeVM,animation:animation)
                        }
                        Spacer()
                    }
                }
                if homeVM.showCard {
                    SingleDoctorView(showCard: $homeVM.showCard, showContent: $homeVM.showContent, doctor: homeVM.selectedDoctor, animation: animation)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

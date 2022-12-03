//
//  SearchResultView.swift
//  TheDoctors
//
//  Created by mac on 3/1/2022.
//

import SwiftUI

struct SearchResultView: View {
    @Namespace private var animation
    
    var search : String
    let columns = [
        GridItem(.flexible())
    ]
    @StateObject var searchVM = SearchViewModel()
    
    init(search : String){
        self.search = search
    }
    
    var body: some View {
        ZStack{
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(searchVM.doctors , id: \.id){ doc in
                        DoctorRow(doctor: doc,animation: animation,fullWidth: true)
                            .padding(.leading,3)
                            .padding(.vertical)
                            .shadow(radius: 2)
                            .onTapGesture {
                                withAnimation(.spring()){
                                    searchVM.selectedDoctor = doc
                                    searchVM.showCard.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn){
                                            searchVM.showContent = true
                                        }
                                    }
                                }
                            }
                    }
                    if searchVM.lastSnapshot != nil {
                        HStack{
                            Spacer()
                            Button {
                                // ..
                                searchVM.loadMore(name: search)
                            } label: {
                                Text("Load More")
                            }
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle(Text(search))
            .onAppear {
                self.searchVM.getDoctorsByName(name: search)
            }
            
            if searchVM.showCard {
                SingleDoctorView(showCard: self.$searchVM.showCard, showContent: self.$searchVM.showContent, doctor: searchVM.selectedDoctor, animation: animation)
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(search: "Hello")
    }
}

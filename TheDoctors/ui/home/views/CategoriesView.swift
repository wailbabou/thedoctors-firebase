//
//  CategoriesView.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import SwiftUI

struct CategoriesView: View {
    @ObservedObject var homeVM:HomeViewModel
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack {
                Spacer().frame(width: 12)
                ForEach(homeVM.categories , id: \.id){ cat in
                    NavigationLink(destination: DoctorsByCategoryView(category: cat)) {
                        CategoryRow(category: cat)
                            .padding(.leading,3)
                            .padding(.vertical)
                            .shadow(radius: 2)
                    }.buttonStyle(PlainButtonStyle())
                     .transition(AnyTransition.scale)
                }
                
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(homeVM: HomeViewModel())
    }
}

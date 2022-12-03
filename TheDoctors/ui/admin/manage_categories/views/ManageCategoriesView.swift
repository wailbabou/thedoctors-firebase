//
//  ManageCategoriesView.swift
//  TheDoctors
//
//  Created by mac on 4/1/2022.
//

import SwiftUI
import Kingfisher

struct ManageCategoriesView: View {
    @StateObject var manageCategoriesVM = ManageCategoriesViewModel()
    var body: some View {
        List {
            ForEach(self.manageCategoriesVM.categories , id:\.id) { category in
                HStack {
                    KFImage(URL(string: category.iconUrl))
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text(category.name)
                }.padding()
            }.onDelete(perform: self.manageCategoriesVM.delete)
        }.onAppear {
            manageCategoriesVM.getCategories()
        }
        .navigationBarTitle(Text("Categories"))
        .navigationBarItems(trailing: Button(action: {
            // action ..
            self.manageCategoriesVM.sheetAddCategory = true
        }, label: {
            Image(systemName: "plus")
        }))
        .sheet(isPresented: self.$manageCategoriesVM.sheetAddCategory) {
            AddCategoryView(manageCategoriesVM: self.manageCategoriesVM)
        }
    }
}

struct ManageCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        ManageCategoriesView()
    }
}

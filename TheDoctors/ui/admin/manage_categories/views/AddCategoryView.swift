//
//  AddCategoryView.swift
//  TheDoctors
//
//  Created by mac on 4/1/2022.
//

import SwiftUI

struct AddCategoryView: View {
    @StateObject var manageCategoriesVM : ManageCategoriesViewModel
    var body: some View {
        Form {
            Section {
                TextField("Name",text: self.$manageCategoriesVM.categoryName)
                VStack {
                    if self.manageCategoriesVM.imagePhoto != nil {
                        HStack{
                            Spacer()
                            Image(uiImage: self.manageCategoriesVM.imagePhoto!)
                                .resizable()
                                .scaledToFill()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .shadow(radius: 3)
                                .padding()
                            Spacer()
                        }
                    } else {
                        HStack {
                            Button {
                                self.manageCategoriesVM.sheetSelectImage = true
                            } label: {
                                Text("Select the icon")
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            Section {
                HStack {
                    Spacer()
                    Button {
                        self.manageCategoriesVM.addCategory()
                    } label: {
                        Text("Send")
                    }
                    Spacer()
                }
            }
        }.sheet(isPresented: self.$manageCategoriesVM.sheetSelectImage) {
            ImagePicker(selectedImage: self.$manageCategoriesVM.imagePhoto)
        }
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView(manageCategoriesVM: ManageCategoriesViewModel())
    }
}

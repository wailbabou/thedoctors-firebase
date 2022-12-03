//
//  AddDoctorView.swift
//  TheDoctors
//
//  Created by mac on 3/1/2022.
//

import SwiftUI

struct AddDoctorView: View {
    @EnvironmentObject var sharedVM : SharedViewModel
    @StateObject var addDoctorVM = AddDoctorViewModel()
    @Binding var isActive : Bool
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Info")) {
                    Text("*You will be added to our database after reviewing your application")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("*Image must be with transparent background")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Section(header: Text("Personal")) {
                    TextField("Full name", text: $addDoctorVM.fullname)
                    TextField("About you", text: $addDoctorVM.about)
                    Picker("Select a category", selection: self.$addDoctorVM.category) {
                        ForEach(self.addDoctorVM.categories, id: \.name) { cat in
                            Text(cat.name)
                        }
                    }
                }
                Section(header: Text("Profesional")) {
                    TextField("Address", text: $addDoctorVM.addressTxt)
                    TextField("Open hours", text: $addDoctorVM.openHours)
                    TextField("Location (Plus Code)", text: $addDoctorVM.plusCode)
                    Link(destination: URL(string: "https://support.google.com/maps/answer/7047426?hl=en")!) {
                        HStack {
                            Spacer()
                            Text("What is Plus Code ?").font(.caption)
                        }
                    }
                    VStack {
                        if self.addDoctorVM.imagePhoto != nil {
                            HStack{
                                Spacer()
                                Image(uiImage: self.addDoctorVM.imagePhoto!)
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
                                    self.addDoctorVM.isShowSheet = true
                                } label: {
                                    Text("Select an image")
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }.sheet(isPresented: self.$addDoctorVM.isShowSheet) {
                    ImagePicker(selectedImage: self.$addDoctorVM.imagePhoto)
                }.alert(self.addDoctorVM.errorMsg, isPresented: self.$addDoctorVM.error) {
                    Button("OK", role: .cancel) {
                        self.isActive = false
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Button {
                            if self.addDoctorVM.fullname == "admin" {
                                self.isActive = false
                                sharedVM.goToAdmin = true
                                sharedVM.goToHome = false
                            }else{
                                self.addDoctorVM.addDoctor()
                            }
                        } label: {
                            Text("Send")
                        }
                        Spacer()
                    }.alert("Sent Successfully", isPresented: self.$addDoctorVM.success) {
                        Button("OK", role: .cancel) {
                            self.isActive = false
                        }
                    }
                    if self.addDoctorVM.isLoading {
                        HStack{
                            Spacer()
                            Text("Sending data ...")
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                    }
                }
            }.onAppear {
                addDoctorVM.getCategories()
            }.navigationBarTitle(Text("Doctor Form"))
        }
    }
}

struct AddDoctorView_Previews: PreviewProvider {
    static var previews: some View {
        AddDoctorView(addDoctorVM: AddDoctorViewModel(), isActive: .constant(true))
    }
}

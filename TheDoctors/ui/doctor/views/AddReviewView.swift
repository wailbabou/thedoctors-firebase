//
//  AddReviewView.swift
//  TheDoctors
//
//  Created by mac on 2/1/2022.
//

import SwiftUI

struct AddReviewView: View {
    @StateObject var doctorVM : SingleDoctorViewModel
    @State var name : String = ""
    @State var review : String = ""
    @State var rating : Int = 1
    @Binding var isActive : Bool
    
    @State var error = false
    @State var errorMg = ""
    
    var body: some View {
        Form {
            Section(header: Text("Review")) {
                TextField("Name", text: self.$name)
                    .padding()
                TextField("Review", text: self.$review)
                    .keyboardType(.emailAddress)
                    .padding()
                RatingView(rating: $rating)
                    .padding()
            }
            Section{
                HStack{
                    Spacer()
                    Button {
                        //...
                        if name.isEmpty || review.isEmpty {
                            self.errorMg = "Please fill the form !"
                            self.error = true
                            return
                        }
                        self.doctorVM.addReview(name: name, review: review, stars: rating) {
                            // on complete ..
                            self.isActive = false
                        }
                    } label: {
                        Text("Save")
                    }
                    Spacer()
                }
            }
        }.alert(self.errorMg, isPresented: $error) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct AddReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewView(doctorVM: SingleDoctorViewModel(), isActive: .constant(true))
    }
}

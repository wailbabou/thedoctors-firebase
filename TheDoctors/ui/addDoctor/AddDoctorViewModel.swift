//
//  AddDoctorViewModel.swift
//  TheDoctors
//
//  Created by mac on 3/1/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import SwiftUI

class AddDoctorViewModel : ObservableObject {
    @Published var fullname = ""
    @Published var about = ""
    @Published var addressTxt = ""
    @Published var openHours = ""
    @Published var category = ""
    @Published var image = ""

    @Published var plusCode = ""
    
    @Published var isShowSheet = false
    @Published var imagePhoto: UIImage?
    
    @Published var categories : [Category] = []
    
    @Published var error = false
    @Published var errorMsg = ""
    @Published var success = false

    @Published var isLoading = false

    func getCategories () {
        let pathCategories: String = "Categories"
        let store = Firestore.firestore()
        store.collection(pathCategories).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting cards: \(error.localizedDescription)")
                return
            }
            self.categories = querySnapshot?.documents.compactMap { document in
                // 6
                do {
                    return try document.data(as: Category.self)
                } catch {
                    print("Error codable \(error)")
                    return nil
                }
            } ?? []
        }
    }
    func addDoctor(){
        if isLoading {
            self.errorMsg = "You need to wait till the end of your last request"
            self.error = true
            return
        }
        if fullname.isEmpty {
            self.errorMsg = "Full Name is empty"
            self.error = true
            return
        }
        if about.isEmpty {
            self.errorMsg = "About section is empty"
            self.error = true
            return
        }
        if addressTxt.isEmpty {
            self.errorMsg = "Address is empty"
            self.error = true
            return
        }
        if openHours.isEmpty {
            self.errorMsg = "Opening hours is empty"
            self.error = true
            return
        }
        if category.isEmpty {
            self.errorMsg = "You need to select a category"
            self.error = true
            return
        }
        withAnimation {
            self.isLoading = true
        }
        uploadImage { url in
            let store = Firestore.firestore()
            let path = "WaitingDoctors"
            // Add a new document with a generated id.
            var ref: DocumentReference? = nil
            ref = store.collection(path).addDocument(data: [
                "about" : self.about,
                "address" : self.addressTxt,
                "fullname" : self.fullname,
                "image" : url ?? "",
                "openHours" : self.openHours,
                "category" : self.category,
                "plusCode" : self.plusCode
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    ref?.updateData(["id" : ref!.documentID]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                            withAnimation {
                                self.isLoading = false
                                self.success = true
                            }
                        }
                    }
                }
            }
            
        }
    }
    func uploadImage(completion : @escaping(_ url:String?) -> Void){
        if imagePhoto != nil {
            // Create a root reference
            let storageRef = Storage.storage().reference()

            // Create a reference to "mountains.jpg"
            let name = "\(fullname)_\(category)_\(Date().timeIntervalSince1970)"
            let imageRef = storageRef.child("doctors/\(name).png")
            let uploadTask = imageRef.putData(imagePhoto!.pngData()!, metadata: nil) { metadata, error in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                }
               
                // You can also access to download URL after upload.
                imageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                      // Uh-oh, an error occurred!
                      return
                    }
                    completion(downloadURL.absoluteString)
                  }
            }
        }else{
            completion(nil)
        }
    }
}

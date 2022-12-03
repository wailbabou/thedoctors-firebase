//
//  ManageCategoriesViewModel.swift
//  TheDoctors
//
//  Created by mac on 4/1/2022.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class ManageCategoriesViewModel : ObservableObject {
    @Published var sheetAddCategory = false
    @Published var categories : [Category] = []
    
    @Published var sheetSelectImage = false
    @Published var imagePhoto: UIImage?
    @Published var categoryName = ""
    
    private let pathCategories: String = "Categories"
    private let store = Firestore.firestore()
    
    @Published var isLoading = false

    func getCategories(){
        store.collection(pathCategories).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting cards: \(error.localizedDescription)")
                return
            }
            self.categories = querySnapshot?.documents.compactMap { document in
                do {
                    return try document.data(as: Category.self)
                } catch {
                    print("Error codable \(error)")
                    return nil
                }
            } ?? []
        }
    }
    func addCategory(){
        withAnimation {
            self.isLoading = true
        }
        uploadImage { url in
            let store = Firestore.firestore()
            let path = "Categories"
            // Add a new document with a generated id.
            var ref: DocumentReference? = nil
            ref = store.collection(path).addDocument(data: [
                "iconUrl" : url ?? "",
                "name" : self.categoryName
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
                                self.sheetAddCategory = false
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
            let name = "\(Date().timeIntervalSince1970)"
            let imageRef = storageRef.child("categories/\(name).png")
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
    
    func delete(at offsets: IndexSet) {
        let cat = categories[offsets.first!]
        let store = Firestore.firestore()
        let path = "Categories"
        // delete the objects here
        categories.remove(atOffsets: offsets)
        store.collection(path).document(cat.id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}

//
//  DoctorByCategoryVM.swift
//  TheDoctors
//
//  Created by mac on 2/1/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DoctorsByCategoryVM : ObservableObject {
    private let path: String = "Doctors"
    private let store = Firestore.firestore()
    
    @Published var doctors : [Doctor] = []
    
    @Published var showCard = false
    @Published var selectedDoctor = PreviewData.doctor
    @Published var showContent = false
    
    @Published var lastSnapshot : QueryDocumentSnapshot? = nil
    @Published var loaded = false

    func getDoctorsByCategory(category:String){
        store.collection(path).whereField("category", isEqualTo: category).limit(to: 10).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting cards: \(error.localizedDescription)")
                return
            }
            self.lastSnapshot = querySnapshot?.documents.last

            self.doctors = querySnapshot?.documents.compactMap { document in
                // 6
                do {
                    return try document.data(as: Doctor.self)
                } catch {
                    print("Error codable \(error)")
                    return nil
                }
            } ?? []
            self.loaded = true

        }
    }
    
    func loadMore(category:String){
        // Construct a new query starting after this document,
        // retrieving the next 25 cities.
        if lastSnapshot != nil {
            let next = store.collection(path)
                .whereField("category", isEqualTo: category)
                .limit(to: 10)
                .start(afterDocument: lastSnapshot!)
            next.getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error getting cards: \(error.localizedDescription)")
                    return
                }
                self.lastSnapshot = querySnapshot?.documents.last

                self.doctors.append(contentsOf: querySnapshot!.documents.compactMap { document in
                    do {
                        return try document.data(as: Doctor.self)
                    } catch {
                        print("Error codable \(error)")
                        return nil
                    }
                })
            }
        }
    }
}

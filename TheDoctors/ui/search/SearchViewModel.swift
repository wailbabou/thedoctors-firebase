//
//  SearchViewModel.swift
//  TheDoctors
//
//  Created by mac on 3/1/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class SearchViewModel : ObservableObject {
    private let path: String = "Doctors"
    private let store = Firestore.firestore()
    
    @Published var doctors : [Doctor] = []
    
    @Published var showCard = false
    @Published var selectedDoctor = PreviewData.doctor
    @Published var showContent = false
    
    @Published var lastSnapshot : QueryDocumentSnapshot? = nil
    func getDoctorsByName(name:String){
        store.collection(path).order(by: "fullname").start(at: [name]).end(at: [name+"\\uf8ff"]).limit(to: 10).getDocuments { querySnapshot, error in
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
        }
    }
    
    func loadMore(name:String){
       
        if lastSnapshot != nil {
            let next = store.collection(path)
                .order(by: "fullname")
                .start(at: [name])
                .end(at: [name+"\\uf8ff"])
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

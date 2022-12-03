//
//  HomeViewModel.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
class HomeViewModel: ObservableObject {
    private let path: String = "Doctors"
    private let pathCategories: String = "Categories"
    private let store = Firestore.firestore()
    // ....
    @Published var showCard = false
    @Published var selectedDoctor = PreviewData.doctor
    @Published var showContent = false
    @Published var goToSearch = false
    @Published var searchText:String = ""

    @Published var categories : [Category] = []
    
    @Published var doctors : [Doctor] = []
    
    init() {
        getDoctors()
        getCategories()
    }
    
    func getDoctors(){
        store.collection(path).limit(to: 15).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting cards: \(error.localizedDescription)")
                return
            }
            self.doctors = querySnapshot?.documents.compactMap { document in
                do {
                    return try document.data(as: Doctor.self)
                } catch {
                    print("Error codable \(error)")
                    return nil
                }
            } ?? []
        }
    }
    
    func getCategories(){
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
}

//
//  WaitingDoctorsViewModel.swift
//  TheDoctors
//
//  Created by mac on 4/1/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class WaitingDoctorViewModel : ObservableObject {
    private let path: String = "WaitingDoctors"
    private let store = Firestore.firestore()
    
    @Published var doctors : [Doctor] = []
    
    @Published var showCard = false
    @Published var selectedDoctor = PreviewData.doctor
    @Published var showContent = false
    
    func getDoctors(){
        store.collection(path).addSnapshotListener { querySnapshot, error in
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
    
}

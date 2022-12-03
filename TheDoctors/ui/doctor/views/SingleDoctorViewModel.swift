//
//  SingleDoctorViewModel.swift
//  TheDoctors
//
//  Created by mac on 2/1/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import SwiftUI

class SingleDoctorViewModel : ObservableObject {
    @Published var reviews : [Review] = []
    // states
    @Published var sheetAddRate = false
    var doctorId = ""
    var doctor : Doctor? = nil
    func getReviews(doctor : Doctor){
        self.doctorId = doctor.id
        self.doctor = doctor
        let store = Firestore.firestore()
        let path = "Doctors/\(doctorId)/reviews"

        store.collection(path).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting cards: \(error.localizedDescription)")
                return
            }
            self.reviews = querySnapshot?.documents.compactMap { document in
                do {
                    return try document.data(as: Review.self)
                } catch {
                    print("Error codable \(error)")
                    return nil
                }
            } ?? []
        }
    }
    func addReview(name:String, review:String, stars : Int , completion : @escaping () -> Void ){
        let store = Firestore.firestore()
        let path = "Doctors/\(doctorId)/reviews"
        // Add a new document with a generated id.
        var ref: DocumentReference? = nil
        ref = store.collection(path).addDocument(data: [
            "review" : review,
            "reviewer" : name,
            "stars" : stars
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
                        self.updateRateAverage(stars: stars)
                        completion()
                    }
                }
            }
        }
    }
    
    func updateRateAverage(stars : Int ){
        let store = Firestore.firestore()
        var average = 0.0
        var count = 0.0
        if doctor!.countRates != nil {
            average = ((doctor!.countRates! * doctor!.avgRating!) + Double(stars)) / (doctor!.countRates! + 1)
            count = doctor!.countRates!+1
        }else{
            average = Double(stars)
            count = 1
        }
        store.collection("Doctors").document(doctorId).updateData(["countRates" : count ,"avgRating":average]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func approveDoctor(secretKey : String , completion : @escaping () -> Void){
        let store = Firestore.firestore()
        let path = "Doctors"
        // Add a new document with a generated id.
        var ref: DocumentReference? = nil
        ref = store.collection(path).addDocument(data: [
            "about" : self.doctor!.about,
            "address" : self.doctor!.address,
            "fullname" : self.doctor!.fullname,
            "image" : self.doctor!.image,
            "openHours" : self.doctor!.openHours,
            "category" : self.doctor!.category,
            "plusCode" : self.doctor!.plusCode
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
                        self.declineDoctor(secretKey: secretKey) {
                            completion()
                        }
                    }
                }
            }
        }
    }
    func declineDoctor(secretKey : String , completion : @escaping () -> Void){
        let store = Firestore.firestore()
        let path = "WaitingDoctors"
        // delete the objects here
        store.collection(path).document(doctor!.id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                completion()
            }
        }
    }
}

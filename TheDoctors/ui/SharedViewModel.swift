//
//  SharedViewModel.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import Foundation
class SharedViewModel : ObservableObject {
    @Published var goToHome = false
    @Published var goToAdmin = false
}

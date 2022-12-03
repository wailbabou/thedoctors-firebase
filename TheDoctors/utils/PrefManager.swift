//
//  PrefManager.swift
//  TheDoctors
//
//  Created by mac on 2/1/2022.
//

import Foundation
class PrefManager {
    let showWelcomeKey = "showWelcomeKey"
    
    func setShowWelcome(done:Bool) {
        UserDefaults.standard.set(done, forKey: showWelcomeKey) //Bool
    }
    func needToShowWelcome() -> Bool {
        return UserDefaults.standard.bool(forKey: showWelcomeKey)
    }
}

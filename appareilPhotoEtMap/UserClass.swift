//
//  UserClass.swift
//  appareilPhotoEtMap
//
//  Created by NGUELE Steve  on 02/01/2025.
//

import Foundation
import SwiftUI

class User: Identifiable, ObservableObject {
    let id = UUID()
    let firstName: String
    let lastName: String
    @Published var profilePicture: Image
    let email: String
    let age: Int
    
    init(firstName: String, lastName: String, email: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.profilePicture = Image("default_image")
        self.email = email
        self.age = age
    }
}

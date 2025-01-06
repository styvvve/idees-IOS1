//
//  ProfileView.swift
//  appareilPhotoEtMap
//
//  Created by NGUELE Steve  on 02/01/2025.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    //afficher la camera qd on appuie sur la photo de profil
    @State private var showCamera: Bool = false
    @State private var confirmationShow: Bool = false
    
    //pour sélectionner la photo depuis la librairie
    @State private var isPhotoPickerPresented: Bool = false
    @State private var pickerItem: PhotosPickerItem?
    
    //les infos de l'utilisateur vont etre dans cette instance
    @State private var userInfo: User = User(firstName: "", lastName: "", email: "", age: 1)
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var age = 1
    @State private var image: Image? //on met rien pour ne pas charger la mémoire
    
    var body: some View {
        NavigationView {
            
        }
    }
    
    //fonction pour enregistrer un nouvel utilisateur
    func updateUser() {
        
    }
}

#Preview {
    ProfileView()
}

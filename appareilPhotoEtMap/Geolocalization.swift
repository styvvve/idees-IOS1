//
//  Geolocalization.swift
//  appareilPhotoEtMap
//
//  Created by NGUELE Steve  on 07/01/2025.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var errorMessage: String?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        userLocation = latestLocation.coordinate //stocker la nvle position
    }
    
    override init() {
        super.init()
        locationManager.delegate = self //definition de la classe en tant que deleguee
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //pour une haute précision
        locationManager.requestWhenInUseAuthorization() //demander l'autorisation
        locationManager.startUpdatingLocation() //commencer à mettre à jour la localisation
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            //autorisation refusée
            errorMessage = "Accès à la caméra restreint. Veuillez autoriser l'application."
        case .notDetermined:
            //en attente
            break
        default : break
        }
    }
}

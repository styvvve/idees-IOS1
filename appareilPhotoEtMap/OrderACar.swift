//
//  OrderACar.swift
//  appareilPhotoEtMap
//
//  Created by NGUELE Steve  on 07/01/2025.
//
/*On va se baser sur le modèle d'Uber
 https://mobbin.com/screens/70879e3f-d44a-485a-b3ca-e845caaf59f6?filter=screenPatterns.Map
 
 */

import SwiftUI
import MapKit
import UIKit

struct OrderACar: View {
    
    //"=" a la place de ":"
    @StateObject private var locationManager: LocationManager
    
    //pour creer une modal
    @State private var offset: CGFloat = 300
    @State private var lastDragGesture: CGFloat = 0
    
    //cela est necessaire seulement pour la preview
    //permet de passer en parametre de la vue "locationManager"
    //et ainsi de l'appeler dans la preview
    init(locationManager: LocationManager) {
        _locationManager = StateObject(wrappedValue: locationManager)
    }
    
    var body: some View {
        VStack {
            if let userLocation = locationManager.userLocation {
                ZStack {
                    VStack {
                        Map(
                            position: .constant(
                                MapCameraPosition.region(
                                    MKCoordinateRegion(
                                        center: userLocation,
                                        span: MKCoordinateSpan(
                                            latitudeDelta: 0.01, longitudeDelta: 0.01
                                        )
                                    )
                                )
                            )
                        ) { UserAnnotation() }
                            .mapControls {
                                MapCompass()
                                MapUserLocationButton()
                            }
                    }
                    
                    //le sheet partiel
                    GeometryReader { geometry in
                        VStack {
                            Capsule()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 40, height: 6)
                                .padding(8)
                            
                            VStack {
                                Text("Choose a ride")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                               Rectangle()
                                    .frame(height: 2)
                                    .padding()
                                    .foregroundStyle(.white)
                                HStack {
                                    Image("uberX")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                    VStack(alignment: .leading) {
                                        Text("UberX")
                                            .font(.system(size: 24))
                                            .bold()
                                            .foregroundStyle(.white)
                                        Text("12:53pm. 2 min away")
                                            .foregroundStyle(.white)
                                    }
                                    Spacer()
                                    VStack {
                                        Text("10,99$")
                                            .font(.headline)
                                            .bold()
                                            .foregroundStyle(.white)
                                    }
                                    Spacer()
                                }
                                .padding()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .border(Color.white, width: 5)
                                
                                HStack {
                                    Image("black_SUV")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                    VStack(alignment: .leading) {
                                        Text("Black SUV")
                                            .font(.system(size: 24))
                                            .bold()
                                            .foregroundStyle(.white)
                                        Text("12:54pm.")
                                            .foregroundStyle(.white)
                                    }
                                    Spacer()
                                    VStack {
                                        Text("32,86$")
                                            .font(.headline)
                                            .bold()
                                            .foregroundStyle(.white)
                                    }
                                    Spacer()
                                }
                                .padding()
                                HStack {
                                    Image("black_car")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                    VStack(alignment: .leading) {
                                        Text("black")
                                            .font(.system(size: 24))
                                            .bold()
                                            .foregroundStyle(.white)
                                        Text("12:53pm.")
                                            .foregroundStyle(.white)
                                    }
                                    Spacer()
                                    VStack {
                                        Text("24,99$")
                                            .font(.headline)
                                            .bold()
                                            .foregroundStyle(.white)
                                    }
                                    Spacer()
                                }
                                .padding()
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .background(VisualEffectView(effect: UIBlurEffect(style: .dark)))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                        .offset(y: max(0, geometry.size.height * 0.5 + offset))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    offset = lastDragGesture + value.translation.height
                                }
                                .onEnded { value in
                                    lastDragGesture = offset
                                }
                        )
                    }.ignoresSafeArea(edges: .bottom)
                }
            }else {
                Text("En attente de géolocalisation")
            }
        }
    }
}

struct Map_Preview: PreviewProvider {
    static var previews: some View {
        OrderACar(locationManager: mockLocationManager())
    }
    static func mockLocationManager() -> LocationManager {
        let simulatedLocation = CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522) // Paris
        let locationManager = LocationManager()
        locationManager.userLocation = simulatedLocation
        return locationManager
    }
}


//
//  LocationManager.swift
//  MobileAbschlussapplikation
//
//  Created by Nastia Hanna on 01.01.23.

import Foundation
import CoreLocation
import UIKit
import AVFoundation

class LocationManager : NSObject, CLLocationManagerDelegate, ObservableObject {
    var locationManager: CLLocationManager
    @Published var lat = 0.0
    @Published var lon = 0.0
    @Published var inLocation1 = false
    @Published var inLocation2 = false
    @Published var inLocation3 = false
    @Published var inLocation4 = false
    @Published var inLocation5 = false
    @Published var inLocation6 = false
    
    @Published var showAlert1 = false
    @Published var showAlert2 = false
    @Published var showAlert3 = false
    @Published var showAlert4 = false
    @Published var showAlert5 = false
    @Published var showAlert6 = false
    
    @Published var locationName = ""
    @Published var locationActivity = ""
    
    @Published var alarm = false {
        didSet {
            if(alarm == true){
                if(showAlert1) {
                    locationName = locations[0].place
                    locationActivity = locations[0].toDo
                } else if(showAlert2) {
                    locationName = locations[1].place
                    locationActivity = locations[1].toDo
                } else if(showAlert3) {
                    locationName = locations[2].place
                    locationActivity = locations[2].toDo
                } else if(showAlert4) {
                    locationName = locations[3].place
                    locationActivity = locations[3].toDo
                } else if(showAlert5) {
                    locationName = locations[4].place
                    locationActivity = locations[4].toDo
                } else if(showAlert6) {
                    locationName = locations[5].place
                    locationActivity = locations[5].toDo
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                    self.showAlert1 = false
                    self.showAlert2 = false
                    self.showAlert3 = false
                    self.showAlert4 = false
                    self.showAlert5 = false
                    self.showAlert6 = false
                    self.alarm = false
                }
            }
        }
    }
    
    var locations = [Locations(place: "Saturn", toDo: "Buy selfiestick", shortName: "Saturn", coordinate: .init(latitude: 52.504371, longitude: 13.337489)),
                     Locations(place: "Victory column", toDo: "Selfie with victory column", shortName: "Victory column", coordinate: .init(latitude: 52.51399, longitude: 13.350002)),
                     Locations(place: "House of the Cultures", toDo: "Selfie with building", shortName: "HC", coordinate: .init(latitude: 52.518399, longitude: 13.364822)),
                     Locations(place: "U-bahn Museumsinsel", toDo: "Selfie in the station", shortName: "U-Museumsinsel", coordinate: .init(latitude: 52.517453, longitude: 13.399343)),
                     Locations(place: "BERLIN Souvenir-Store", toDo: "Selfie with Berlin bear", shortName: "Souvenir", coordinate: .init(latitude: 52.520029, longitude: 13.404256)),
                     Locations(place: "Fernsehturm Berlin", toDo: "Selfie with TV-tower", shortName: "Fernsehturm", coordinate: .init(latitude: 52.521326, longitude: 13.408837))]
    
    let systemSoundID: SystemSoundID = 1021
    
    override init(){
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self // object
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let geoFenceRegion1:CLCircularRegion = CLCircularRegion(center: locations[0].coordinate, radius: 150, identifier: locations[0].place)
        let geoFenceRegion2:CLCircularRegion = CLCircularRegion(center: locations[1].coordinate, radius: 150, identifier: locations[1].place)
        let geoFenceRegion3:CLCircularRegion = CLCircularRegion(center: locations[2].coordinate, radius: 150, identifier: locations[2].place)
        let geoFenceRegion4:CLCircularRegion = CLCircularRegion(center: locations[3].coordinate, radius: 150, identifier: locations[3].place)
        let geoFenceRegion5:CLCircularRegion = CLCircularRegion(center: locations[4].coordinate, radius: 150, identifier: locations[4].place)
        let geoFenceRegion6:CLCircularRegion = CLCircularRegion(center: locations[5].coordinate, radius: 150, identifier: locations[5].place)
        
        locationManager.startMonitoring(for: geoFenceRegion1)
        locationManager.startMonitoring(for: geoFenceRegion2)
        locationManager.startMonitoring(for: geoFenceRegion3)
        locationManager.startMonitoring(for: geoFenceRegion4)
        locationManager.startMonitoring(for: geoFenceRegion5)
        locationManager.startMonitoring(for: geoFenceRegion6)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last
        guard let myLat = lastLocation?.coordinate.latitude else {return}
        guard let myLon = lastLocation?.coordinate.longitude else {return}
        self.lat = myLat
        self.lon = myLon
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered: \(region.identifier)")
        switch region.identifier {
        case locations[0].place:
            inLocation1 = true
            showAlert1 = true
            alarm = true
            AudioServicesPlaySystemSound(systemSoundID)
        case locations[1].place:
            inLocation2 = true
            showAlert2 = true
            alarm = true
            AudioServicesPlaySystemSound(systemSoundID)
        case locations[2].place:
            inLocation3 = true
            showAlert3 = true
            alarm = true
            AudioServicesPlaySystemSound(systemSoundID)
        case locations[3].place:
            inLocation4 = true
            showAlert4 = true
            alarm = true
            AudioServicesPlaySystemSound(systemSoundID)
        case locations[4].place:
            inLocation5 = true
            showAlert5 = true
            alarm = true
            AudioServicesPlaySystemSound(systemSoundID)
        case locations[5].place:
            inLocation6 = true
            showAlert6 = true
            alarm = true
            AudioServicesPlaySystemSound(systemSoundID)
        default:
            print("no changes")
        }
    }
       
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited: \(region.identifier)")
        switch region.identifier {
        case locations[0].place:
            inLocation1 = false
        case locations[1].place:
            inLocation2 = false
        case locations[2].place:
            inLocation3 = false
        case locations[3].place:
            inLocation4 = false
        case locations[4].place:
            inLocation5 = false
        case locations[5].place:
            inLocation6 = false
        default:
            print("no changes")
        }
    }
}

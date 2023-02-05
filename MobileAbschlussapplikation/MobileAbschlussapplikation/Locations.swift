//
//  Locations.swift
//  MobileAbschlussapplikation
//
//  Created by Nastia Hanna on 01.01.23.
//

import Foundation
import CoreLocation

struct Locations: Identifiable {
    let id = UUID()
    var place: String
    var toDo: String
    var shortName: String
    var coordinate: CLLocationCoordinate2D
}

//
//  ContentView.swift
//  MobileAbschlussapplikation
//
//  Created by Nastia Hanna on 01.01.23.
//

import SwiftUI

import SwiftUI
import MapKit
import Dispatch

struct ContentView: View {
    @StateObject var locManager = LocationManager()
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.506714, longitude: 13.332834), latitudinalMeters: 1000, longitudinalMeters: 1000)
    
    @State var activity1 = false {
        didSet {
            if(activity1){
                countCompStatus += 1
            } else {
                countCompStatus -= 1
            }
        }
    }
    @State var activity2 = false {
        didSet {
            if(activity2){
                countCompStatus += 1
            } else {
                countCompStatus -= 1
            }
        }
    }
    @State var activity3 = false {
        didSet {
            if(activity3){
                countCompStatus += 1
            } else {
                countCompStatus -= 1
            }
        }
    }
    @State var activity4 = false {
        didSet {
            if(activity4){
                countCompStatus += 1
            } else {
                countCompStatus -= 1
            }
        }
    }
    @State var activity5 = false {
        didSet {
            if(activity5){
                countCompStatus += 1
            } else {
                countCompStatus -= 1
            }
        }
    }
    @State var activity6 = false {
        didSet {
            if(activity6){
                countCompStatus += 1
            } else {
                countCompStatus -= 1
            }
        }
    }
    
    @State private var isTracking = false
    @State private var isListOpen = false
    
    @State private var notes = ""
    @State private var countCompStatus = 0
    
    var body: some View {
            ZStack (alignment: .top){
                Map(coordinateRegion: $region,
                    showsUserLocation: true,
                    userTrackingMode: isTracking ? .constant(.follow) : .none,
                    annotationItems: locManager.locations) { places in
                    MapAnnotation(coordinate: places.coordinate,
                        content: {
                            Image(systemName: "pin.fill")
                                .foregroundColor(.red)
                                .scaleEffect(1.5)
                                .padding(5)
                            Text(places.shortName)
                                .font(.system(size: 18))
                                .background(Color.white.cornerRadius(40).opacity(0.8))
                        }
                    )
                }
                .gesture(
                DragGesture()
                    .onChanged { _ in
                        isTracking = false
                    }
                )
                .gesture(
                MagnificationGesture()
                    .onChanged { _ in
                        isTracking = false
                    }
                )
                .frame(width: 400, height: 900)
                VStack {
                    
                    HStack {
                        Button(action: {if(locManager.inLocation1) {activity1.toggle()}}){
                            Text("**\(locManager.locations[0].place)** \n \(locManager.locations[0].toDo)")
                                .frame(width: 180, height: 40, alignment: .center)
                                .background(buttonColor(locManager.inLocation1, activity1).cornerRadius(40).opacity(0.95))
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                        }
                        .shadow(color: .gray, radius: 3, x: 5, y: 5)
                        Button(action: {if(locManager.inLocation2) {activity2.toggle()}}){
                            Text("**\(locManager.locations[1].place)** \n \(locManager.locations[1].toDo)")
                                .frame(width: 180, height: 40, alignment: .center)
                                .background(buttonColor(locManager.inLocation2, activity2).cornerRadius(40).opacity(0.95))
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                        }
                        .shadow(color: .gray, radius: 3, x: 5, y: 5)
                    }
                    HStack {
                        Button(action: {if(locManager.inLocation3) {activity3.toggle()}}){
                            Text("**\(locManager.locations[2].place)** \n \(locManager.locations[2].toDo)")
                                .frame(width: 180, height: 40, alignment: .center)
                                .background(buttonColor(locManager.inLocation3, activity3).cornerRadius(40).opacity(0.95))
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                        }
                        .shadow(color: .gray, radius: 3, x: 5, y: 5)
                        Button(action: {if(locManager.inLocation4) {activity4.toggle()}}){
                            Text("**\(locManager.locations[3].place)** \n \(locManager.locations[3].toDo)")
                                .frame(width: 180, height: 40, alignment: .center)
                                .background(buttonColor(locManager.inLocation4, activity4).cornerRadius(40).opacity(0.95))
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                        }
                        .shadow(color: .gray, radius: 3, x: 5, y: 5)
                    }
                    HStack {
                        Button(action: {if(locManager.inLocation5) {activity5.toggle()}}){
                            Text("**\(locManager.locations[4].place)** \n \(locManager.locations[4].toDo)")
                                .frame(width: 180, height: 40, alignment: .center)
                                .background(buttonColor(locManager.inLocation5, activity5).cornerRadius(40).opacity(0.95))
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                        }
                        .shadow(color: .gray, radius: 3, x: 5, y: 5)
                        Button(action: {if(locManager.inLocation6) {activity6.toggle()}}){
                            Text("**\(locManager.locations[5].place)** \n \(locManager.locations[5].toDo)")
                                .frame(width: 180, height: 40, alignment: .center)
                                .background(buttonColor(locManager.inLocation6, activity6).cornerRadius(40).opacity(0.95))
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                        }
                        .shadow(color: .gray, radius: 3, x: 5, y: 5)
                    }
                }
                .offset(x: 0, y: 80)
                HStack{
                    Button(action: {self.isListOpen = true}){
                        Text("Overview")
                            .frame(width: 180, height: 40, alignment: .center)
                            .background(Color.blue.cornerRadius(40).opacity(0.95))
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                    }
                    .shadow(color: .gray, radius: 3, x: 5, y: 5)
                    .sheet(isPresented: $isListOpen) {
                        NavigationStack {
                            List {
                                Section(header: Text("Places")) {
                                    ForEach(locManager.locations) { places in
                                        NavigationLink(destination: List {
                                            Text("**Short name:** \(places.shortName)")
                                            Text("**To Do:** \(places.toDo)")
                                            HStack {
                                                Text("Coordinates:").fontWeight(.bold)
                                                Text(String(format: " %.6f, %.6f", places.coordinate.latitude, places.coordinate.longitude))
                                            }
                                            Text("**Distance away:** \(String(format: "%.1f", distance(to: places.coordinate))) m")
                                            Text("**Status:** \(status(activity: places.place))")
                                        }
                                            .navigationTitle(places.place)
                                        ){
                                            Text(places.place)
                                        }
                                    }
                                }
                                Section(header: Text("Completion status")) {
                                    Text("\(countCompStatus) out of 6")
                                }

                                Section(header: Text("Notes")) {
                                    TextEditor(text: $notes)
                                }                            }
                            .navigationTitle("Overview")
                        }
                    }
                    .padding(30)
                    Button(action: {
                        if let location = self.locManager.locationManager.location {
                            self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                        }
                        self.isTracking.toggle()
                    }) {
                        Image(systemName: "location.circle.fill")
                            .foregroundColor(isTracking ? .white : .blue)
                            .padding()
                            .background(isTracking ? Color.blue : Color.white)
                            .clipShape(Circle())
                    }
                    .shadow(color: .gray, radius: 3, x: 5, y: 5)
                }
                .offset(x: 30, y: 770)
            }
            .alert(isPresented: $locManager.alarm, content: {
                Alert(
                    title: Text(locManager.locationName),
                    message: Text(locManager.locationActivity),
                    dismissButton: .default(Text("OK")) {
                        locManager.showAlert1 = false
                        locManager.showAlert2 = false
                        locManager.showAlert3 = false
                        locManager.showAlert4 = false
                        locManager.showAlert5 = false
                        locManager.showAlert6 = false
                        locManager.alarm = false
                    }
                )
            })
        }

    func buttonColor(_ place: Bool, _ done: Bool) -> Color {
        if(done){
            return .green
        } else if(place){
            return .yellow
        }
        return .red
    }
    
    func distance(to coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        if let userLocation = locManager.locationManager.location {
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            return userLocation.distance(from: location)
        }
        return 0
    }
    
    func status(activity: String) -> String {
        if (activity1 && activity == locManager.locations[0].place) {
            return "Complete!"
        }
        if (activity2 && activity == locManager.locations[1].place) {
            return "Complete!"
        }
        if (activity3 && activity == locManager.locations[2].place) {
            return "Complete!"
        }
        if (activity4 && activity == locManager.locations[3].place) {
            return "Complete!"
        }
        if (activity5 && activity == locManager.locations[4].place) {
            return "Complete!"
        }
        if (activity6 && activity == locManager.locations[5].place) {
            return "Complete!"
        }
        return "Incomplete"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//Mobile App, Alternative 1
//
//Kaisers Wegpunkte auf der Karte
//Die Position des Benutzers soll auf der Karte angezeigt werden.
//Die 6 definierten Wegpunkte sollen als Pins auf der Karte angezeigt werden.
//Die Pins sollen beschriftet sein (Kurzname des Wegpunktes).
//Beim Erreichen des Wegpunktes soll eine Meldung ausgegeben werden. Die Meldung soll sowohl visuell (Alertmeldung/Textmeldung..) als auch auditiv (Abspielen einer MP3-Datei) erfolgen.
//Wenn der Benutzer die Karte einmal gezoomt hatte, darf die Applikation nicht mehr die Karte um die Benutzerposition zoomen und es soll ein Knopf "Aktuelle Position" erscheinen.  Das Zoomen auf die Benutzerposition soll durch die Betätigung des Knopfes "Aktuelle Position" wieder aufgenommen werden. Wenn die Benutzerposition gezoomt ist, darf der Knopf "Aktuelle Position" nicht sichtbar sein. Verwenden Sie dazu die angefangene Lösung  mit Corelocation in der Vorlesung.

//Zu Testzwecken soll der GPS-Track vom Bus 100 verwendet werden.

//
//  LocateManager.swift
//  Weather
//
//  Created by Дрозд Денис on 23.03.2024.
//

import CoreLocation

final class LocateManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocateManager()
    private let locationManager = CLLocationManager()
    private var oneCall = true
    private var newLocation: String?
    
    override init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let parameter = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        if oneCall {
            oneCall = false
            newLocation = parameter
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
    
    func getLocation() -> String {
        guard let newLocation = newLocation else { return "" }
        return newLocation
    }
    
}

//
//  LocationManager.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 01.02.2023.
//

import CoreLocation

protocol LocationDelegate {
    func gotCurrent(location: CLLocation?)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    var delegate: LocationDelegate?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation? {
        didSet {
            delegate?.gotCurrent(location: currentLocation)
        }
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.distanceFilter = Constants.Location.distanceFilter
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        currentLocation = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            currentLocation = nil
        default:
            break
        }
    }
}

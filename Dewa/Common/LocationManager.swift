//
//  LocationManager.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(location: CLLocation)
}
class LocationManager: NSObject, CLLocationManagerDelegate {

    static let shared = LocationManager()
    let manager = CLLocationManager()

    weak var delegate: LocationManagerDelegate?

    private override init() { }
    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationManagerAuthorization()
        } else {

        }
    }
    func setupLocationManager() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkLocationManagerAuthorization() {
        switch authorizationStatus() {
        case .notDetermined:
            print("Auth: notDetermined")
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("Auth: authorizedWhenInUse")
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("Auth: denied")
            break
        default:
            break
        }
    }

    func authorizationStatus() -> CLAuthorizationStatus {
        var status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = CLLocationManager().authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        return status
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            manager.stopUpdatingLocation()
            delegate?.didUpdateLocation(location: location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationService()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
    }
}

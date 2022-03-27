//
//  LocationDetailView.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import Foundation
import UIKit
import MapKit

class LocationDetailView: UIView {

    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var servicesLabel: UILabel!


    var viewModel: LocationDetailViewModel? {
        didSet {
            configure()
        }
    }

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    func configure() {
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func openMap(location: CLLocation) {
        let application = UIApplication.shared
        let googleMapsURL = URL(string: "comgooglemaps://")!
        if application.canOpenURL(googleMapsURL) {
            let locationURL = URL(string:  "comgooglemaps://?saddr=&daddr=\(location.coordinate.latitude),\(location.coordinate.longitude)&directionsmode=driving)")!
            application.open(locationURL, options: [:], completionHandler: nil)
        } else {
            if let urlDestination = URL(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(location.coordinate.latitude),\(location.coordinate.longitude)&directionsmode=driving") {
                application.open(urlDestination)
            }
        }
    }

}

extension LocationDetailView {
    func setupUI() {
        guard let viewModel = viewModel else {
            return
        }
        titleLabel.text = viewModel.title
        locationLabel.text = viewModel.location
        distanceLabel.text = "\(viewModel.distance ?? 0) km away"
        if let services = viewModel.services {
            var servicesString = "Services: "
            for service in services {
                servicesString.append("\n \(service)")
            }
            servicesLabel.text = servicesString
        } else {
            servicesLabel.isHidden = true
        }
        guard let latitude = viewModel.latitude, let longitude = viewModel.longitude else {
            return
        }
        let annotation = MKPointAnnotation()
        annotation.title = viewModel.title
        annotation.subtitle = viewModel.location
        annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 0, longitude: Double(longitude) ?? 0)
        mapview.addAnnotation(annotation)
        mapview.delegate = self
    }
}
extension LocationDetailView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let coordinate = view.annotation?.coordinate else {
            return
        }
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        openMap(location: location)
    }

}

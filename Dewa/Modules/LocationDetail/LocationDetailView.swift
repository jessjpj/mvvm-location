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
    }
}

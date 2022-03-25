//
//  DewaLocationViewModel.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import Foundation
import CoreLocation

class DewaLocationViewModel {
    private(set) var webservice: DewaLocationWebService!

    var title: String? = "Dewa Locations"
    var models: [DewaLocationItem] = [DewaLocationItem]()

    init(models: [DewaLocationItem]) {
        self.models = models
    }

    init(service: DewaLocationWebService) {
        self.webservice = service
    }


}

extension DewaLocationViewModel {
    func getDewaLocations(completion :@escaping (DewaLocationViewModel) -> ()) {
        let urlString = AppConfiguration().dewaLocationURL
        guard let url = URL(string: urlString) else {
            return
        }
        webservice.getDewaLocations(url: url) { data, error in
            guard let data = data else {
                return
            }
            do {
                let dewaLocationModel = try DewaLocationModel(data: data)
                self.models = dewaLocationModel.locationsApp?.cordinate?.item ?? [DewaLocationItem]()
                DispatchQueue.main.async {
                    completion(self)
                }
            } catch let error {
                print(error)
            }
            if let error = error {
                print(error)
            }
        }
    }
}

extension DewaLocationViewModel {
    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows() -> Int {
        return models.count
    }

    func getItem(at indexPathRow: Int) -> DewaLocationItem {
        return models[indexPathRow]
    }

    func updateCurrentLocation(location: CLLocation) {
        for row in models.indices {
            guard let lat = models[row].lat, let latitude = Double(lat) else {
                return
            }
            guard let lon = models[row].lon, let longitude = Double(lon) else {
                return
            }
            let placeLocation = CLLocation(latitude: latitude, longitude: longitude)
            let distance = placeLocation.distance(from: location)
            models[row].distance = Int(distance.inKilometers())
        }
        sortModels()
    }

    func sortModels() {
        models = models.sorted {
            ($0.distance ?? 0) < ($1.distance ?? 0)
        }
    }
}

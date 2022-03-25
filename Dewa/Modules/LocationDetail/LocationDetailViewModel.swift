//
//  LocationDetailViewModel.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import Foundation

class LocationDetailViewModel {
    var latitude: String?
    var longitude: String?
    var location: String?
    var title: String?
    var services: [String]?
    var distance: Int?
    var image: String?

    init(latitude: String?, longitude: String?, location: String?, title: String?, services: [String]?, distance: Int?, image: String?) {
        self.latitude = latitude
        self.longitude = longitude
        self.location = location
        self.title = title
        self.services = services
        self.distance = distance
        self.image = image
    }
}

//
//  CustomerServiceModel.swift
//  Dewa
//
//  Created by Mac on 24/03/2022.
//

import Foundation

struct ServiceCenterModel: Hashable {
    let id: Int
    let title: String
    let latitude: String
    let longitude: String
    let shortAddress: String
    let longAddress: String
    let addressline1: String
    let landmark: String
    let city: String
    let countrycode: String
    let zipcode: String
    let officenumber: String
    let callcenternumber: String
    let emergencynumber: String
    let workinghours: String
    let website: String
    let email: String
    let makaninumber: String
    let contacttext: String
    let businesscardtext: String
    let businesscardlink: String
    let image: String
    let map: String
    let services: [String]
    var distance: Int?

    init(
        id: Int,
        title: String?,
        latitude: String?,
        longitude: String?,
        shortAddress: String?,
        longAddress: String?,
        addressline1: String?,
        landmark: String?,
        city: String?,
        countrycode: String?,
        zipcode: String?,
        officenumber: String?,
        callcenternumber: String?,
        emergencynumber: String?,
        workinghours: String?,
        website: String?,
        email: String?,
        makaninumber: String?,
        contacttext: String?,
        businesscardtext: String?,
        businesscardlink: String?,
        image: String?,
        map: String?,
        services: [String]?,
        distance: Int?) {
            self.id = id
            self.title = title ?? ""
            self.latitude = latitude ?? ""
            self.longitude = longitude ?? ""
            self.shortAddress = shortAddress ?? ""
            self.longAddress = longAddress ?? ""
            self.addressline1 = addressline1 ?? ""
            self.landmark = landmark ?? ""
            self.city = city ?? ""
            self.countrycode = countrycode ?? ""
            self.zipcode = zipcode ?? ""
            self.officenumber = officenumber ?? ""
            self.callcenternumber = callcenternumber ?? ""
            self.emergencynumber = emergencynumber ?? ""
            self.workinghours = workinghours ?? ""
            self.website = website ?? ""
            self.email = email ?? ""
            self.makaninumber = makaninumber ?? ""
            self.contacttext = contacttext ?? ""
            self.businesscardtext = businesscardtext ?? ""
            self.businesscardlink = businesscardlink ?? ""
            self.image = image ?? ""
            self.map = map ?? ""
            self.services = services ?? [String]()
            self.distance = distance
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: ServiceCenterModel, rhs: ServiceCenterModel) -> Bool {
        lhs.id == rhs.id && lhs.distance == rhs.distance
    }
}

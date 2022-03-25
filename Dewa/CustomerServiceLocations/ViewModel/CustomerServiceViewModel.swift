//
//  CustomerServiceViewModel.swift
//  Dewa
//
//  Created by Mac on 24/03/2022.
//

import Foundation
import AEXML
import CoreLocation

class CustomerServiceViewModel {
    private(set) var webservice :CustomerServiceWebService!

    var title: String? = "Customer Service Locations"
    var models: [ServiceCenterModel] = [ServiceCenterModel]()

    init(models: [ServiceCenterModel]) {
        self.models = models
    }

    init(service: CustomerServiceWebService) {
        self.webservice = service
    }


}

extension CustomerServiceViewModel {
    func getCustomerServiceLocations(completion :@escaping (CustomerServiceViewModel) -> ()) {
        let urlString = AppConfiguration().customerServiceLocationURL
        guard let url = URL(string: urlString) else {
            return
        }
        webservice.getCustomerServiceLocations(url: url) { data, error in
            guard let data = data else {
                return
            }
            do {
                let xmlDoc = try AEXMLDocument(xml: data)
                let children = xmlDoc.root.children
                let customerService = children.filter { child in
                    return child.name == "CustomerService"
                }.first
                guard let serviceCenters = customerService?.children else {
                    return
                }
                self.models = [ServiceCenterModel]()
                self.parseData(serviceCenters)
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

    fileprivate func parseData(_ serviceCenters: [AEXMLElement]) {
        for serviceCenter in serviceCenters {
            let id = serviceCenter.children.filter { $0.name == "id" }.first
            let title = serviceCenter.children.filter { $0.name == "title" }.first
            let latitude = serviceCenter.children.filter { $0.name == "latitude" }.first
            let longitude = serviceCenter.children.filter { $0.name == "longitude" }.first
            let address = serviceCenter.children.filter { $0.name == "address" }.first
            let addressdetails = serviceCenter.children.filter { $0.name == "addressdetails" }.first
            let addressline1 = serviceCenter.children.filter { $0.name == "addressline1" }.first
            let landmark = serviceCenter.children.filter { $0.name == "landmark" }.first
            let city = serviceCenter.children.filter { $0.name == "city" }.first
            let countrycode = serviceCenter.children.filter { $0.name == "countrycode" }.first
            let zipcode = serviceCenter.children.filter { $0.name == "zipcode" }.first
            let officenumber = serviceCenter.children.filter { $0.name == "officenumber" }.first
            let callcenternumber = serviceCenter.children.filter { $0.name == "callcenternumber" }.first
            let emergencynumber = serviceCenter.children.filter { $0.name == "emergencynumber" }.first
            let workinghours = serviceCenter.children.filter { $0.name == "workinghours" }.first
            let website = serviceCenter.children.filter { $0.name == "website" }.first
            let email = serviceCenter.children.filter { $0.name == "email" }.first
            let makaninumber = serviceCenter.children.filter { $0.name == "makaninumber" }.first
            let contacttext = serviceCenter.children.filter { $0.name == "contacttext" }.first
            let businesscardtext = serviceCenter.children.filter { $0.name == "businesscardtext" }.first
            let businesscardlink = serviceCenter.children.filter { $0.name == "businesscardlink" }.first
            let image = serviceCenter.children.filter { $0.name == "image" }.first
            let map = serviceCenter.children.filter { $0.name == "map" }.first
            let services = serviceCenter.children.filter { $0.name == "services" }.first
            let serviceList = services?.children.compactMap { $0.value }
            let model = ServiceCenterModel(
                id: id?.int ?? 0,
                title: title?.string,
                latitude: latitude?.string,
                longitude: longitude?.string,
                shortAddress: address?.string,
                longAddress: addressdetails?.string,
                addressline1: addressline1?.string,
                landmark: landmark?.string,
                city: city?.string,
                countrycode: countrycode?.string,
                zipcode: zipcode?.string,
                officenumber: officenumber?.string,
                callcenternumber: callcenternumber?.string,
                emergencynumber: emergencynumber?.string,
                workinghours: workinghours?.string,
                website: website?.string,
                email: email?.string,
                makaninumber: makaninumber?.string,
                contacttext: contacttext?.string,
                businesscardtext: businesscardtext?.string,
                businesscardlink: businesscardlink?.string,
                image: image?.string,
                map: map?.string,
                services: serviceList,
                currentLocation: nil)
            models.append(model)
        }
    }
}

extension CustomerServiceViewModel {
    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows() -> Int {
        return models.count
    }

    func getItem(at indexPathRow: Int) -> ServiceCenterModel {
        return models[indexPathRow]
    }

    func updateCurrentLocation(location: CLLocation) {
        for row in models.indices {
            models[row].currentLocation = location
        }
    }
}

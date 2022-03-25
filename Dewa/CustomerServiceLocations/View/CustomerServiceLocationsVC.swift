//
//  CustomerServiceLocationsVC.swift
//  Dewa
//
//  Created by Mac on 24/03/2022.
//

import UIKit

class CustomerServiceLocationsVC: UIViewController {

    var viewModel: CustomerServiceViewModel?
    var webservice = CustomerServiceWebService()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.webservice = CustomerServiceWebService()
        self.viewModel = CustomerServiceViewModel(service: self.webservice)
        self.title = self.viewModel?.title
        loadLocations()
    }

    func loadLocations() {
        viewModel?.getCustomerServiceLocations(completion: { viewModel in
            self.viewModel = viewModel
        })
    }

}

//
//  CustomerServiceLocationsVC.swift
//  Dewa
//
//  Created by Mac on 24/03/2022.
//

import UIKit

class CustomerServiceLocationsVC: UIViewController {

    var viewModel: CustomerServiceViewModel? {
        didSet {
            contentView.collectionView.viewModel = viewModel
        }
    }
    var webservice = CustomerServiceWebService()

    @IBOutlet weak var contentView: CustomerServiceLocationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = contentView
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

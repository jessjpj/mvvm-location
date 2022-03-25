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
            updateView()
        }
    }
    var webservice = CustomerServiceWebService()

    @IBOutlet weak var contentView: CustomerServiceLocationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.webservice = CustomerServiceWebService()
        self.viewModel = CustomerServiceViewModel(service: self.webservice)
        loadLocations()
    }

    func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        contentView.collectionView.viewModel = viewModel
    }

    func loadLocations() {
        viewModel?.getCustomerServiceLocations(completion: { viewModel in
            self.viewModel = viewModel
        })
    }

}

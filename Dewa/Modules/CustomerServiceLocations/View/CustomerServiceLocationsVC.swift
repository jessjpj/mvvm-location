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
        observeContentView()
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

    func observeContentView() {
        contentView.collectionView.itemSelected = { item in
            self.openDetailScreen(item: item)
        }
    }

    func openDetailScreen(item: ServiceCenterModel) {
        let storyBoard = UIStoryboard(name: "LocationDetail", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: LocationDetailVC.identifier()) as? LocationDetailVC else {
            return
        }
        let viewModel = LocationDetailViewModel(
            latitude: item.latitude,
            longitude: item.longitude,
            location: item.longAddress,
            title: item.title,
            services: item.services,
            distance: item.distance,
            image: item.image)
        viewController.viewModel = viewModel
        if let navigationController = self.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            self.present(viewController, animated: true, completion: nil)
        }
    }

}

//
//  DewaLocationsVC.swift
//  Dewa
//
//  Created by Mac on 24/03/2022.
//

import UIKit

class DewaLocationsVC: UIViewController {

    var viewModel: DewaLocationViewModel? {
        didSet {
            updateView()
        }
    }
    var webservice = DewaLocationWebService()

    @IBOutlet weak var contentView: DewaLocationsView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.webservice = DewaLocationWebService()
        self.viewModel = DewaLocationViewModel(service: self.webservice)
        loadLocations()
    }

    func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        contentView.collectionView.viewModel = viewModel
        observeContentView()
    }

    func loadLocations() {
        viewModel?.getDewaLocations(completion: { viewModel in
            self.viewModel = viewModel
        })
    }

    func observeContentView() {
        contentView.collectionView.itemSelected = { item in
            self.openDetailScreen(item: item)
        }
    }

    func openDetailScreen(item: DewaLocationItem) {
        let storyBoard = UIStoryboard(name: "LocationDetail", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: LocationDetailVC.identifier()) as? LocationDetailVC else {
            return
        }
        let viewModel = LocationDetailViewModel(
            latitude: item.lat,
            longitude: item.lon,
            location: item.loc,
            title: item.office,
            services: nil,
            distance: item.distance,
            image: nil)
        viewController.viewModel = viewModel
        if let navigationController = self.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            self.present(viewController, animated: true, completion: nil)
        }
    }

}

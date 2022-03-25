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
    }

    func loadLocations() {
        viewModel?.getDewaLocations(completion: { viewModel in
            self.viewModel = viewModel
        })
    }

}

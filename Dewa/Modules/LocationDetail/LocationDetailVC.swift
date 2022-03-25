//
//  LocationDetailVC.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import UIKit

class LocationDetailVC: UIViewController {

    var viewModel: LocationDetailViewModel?

    @IBOutlet weak var contentView: LocationDetailView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        guard let viewModel = viewModel else {
            return
        }
        contentView.viewModel = viewModel
    }

}

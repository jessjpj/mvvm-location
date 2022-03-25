//
//  CollectionServiceLocationCollectionView.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import Foundation
import UIKit
import CoreLocation

final class CollectionServiceLocationCollectionView: UICollectionView {
    var viewModel: CustomerServiceViewModel? {
        didSet {
            reloadData()
            configure()
        }
    }

    enum Section {
        case all
    }

    private lazy var cellDataSource = makeDataSource()
    let locationManager = CLLocationManager()

    typealias DataSource = UICollectionViewDiffableDataSource<Section, ServiceCenterModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ServiceCenterModel>

    var itemSelected: Observer<ServiceCenterModel>?

    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func configure() {
        configureDelegates()
        registerCells()
        self.collectionViewLayout = flowLayout
        applySnapshot(animatingDifferences: false)
        self.dataSource = cellDataSource
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    private func configureDelegates() {
        delegate = self
    }

    private func registerCells() {
        let cellNib = UINib(nibName: CustomerServiceLocationCVC.cellIdentifier(), bundle: nil)
        register(cellNib, forCellWithReuseIdentifier: CustomerServiceLocationCVC.cellIdentifier())
    }

}

extension CollectionServiceLocationCollectionView {
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: self,
            cellProvider: { (collectionView, indexPath, locationItem) -> CustomerServiceLocationCVC? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CustomerServiceLocationCVC.cellIdentifier(),
                    for: indexPath) as? CustomerServiceLocationCVC
                cell?.configurecell(locationItem: locationItem)
                return cell
      })
      return dataSource
    }

    func applySnapshot(animatingDifferences: Bool = true) {
        guard let models = viewModel?.models else {
            return
        }
        var snapshot = Snapshot()
        snapshot.appendSections([.all])
        snapshot.appendItems(models)
        cellDataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension CollectionServiceLocationCollectionView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = cellDataSource.itemIdentifier(for: indexPath) else {
            return
        }
        itemSelected?(item)
    }

}

extension CollectionServiceLocationCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 1
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        let height: CGFloat = 110
        return CGSize(width: itemDimension, height: height)
    }
}

extension CollectionServiceLocationCollectionView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let capturedLocation = locations.first else {
            return
        }
        viewModel?.updateCurrentLocation(location: capturedLocation)
        applySnapshot()
    }
}

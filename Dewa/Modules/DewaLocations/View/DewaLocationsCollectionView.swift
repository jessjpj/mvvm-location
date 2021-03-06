//
//  DewaLocationsCollectionView.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import Foundation
import UIKit
import CoreLocation

final class DewaLocationsCollectionView: UICollectionView {
    var viewModel: DewaLocationViewModel? {
        didSet {
            reloadData()
            configure()
        }
    }

    enum Section {
        case all
    }

    private lazy var cellDataSource = makeDataSource()

    typealias DataSource = UICollectionViewDiffableDataSource<Section, DewaLocationItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DewaLocationItem>

    var itemSelected: Observer<DewaLocationItem>?

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
        let locationManager = LocationManager.shared
        locationManager.delegate = self
        locationManager.checkLocationService()
    }

    private func configureDelegates() {
        delegate = self
    }

    private func registerCells() {
        let cellNib = UINib(nibName: DevaLocationCVC.cellIdentifier(), bundle: nil)
        register(cellNib, forCellWithReuseIdentifier: DevaLocationCVC.cellIdentifier())
    }

}

extension DewaLocationsCollectionView {
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: self,
            cellProvider: { (collectionView, indexPath, locationItem) -> DevaLocationCVC? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: DevaLocationCVC.cellIdentifier(),
                    for: indexPath) as? DevaLocationCVC
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

extension DewaLocationsCollectionView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = cellDataSource.itemIdentifier(for: indexPath) else {
            return
        }
        itemSelected?(item)
    }

}

extension DewaLocationsCollectionView: UICollectionViewDelegateFlowLayout {
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

extension DewaLocationsCollectionView: LocationManagerDelegate {
    func didUpdateLocation(location: CLLocation) {
        viewModel?.updateCurrentLocation(location: location)
        applySnapshot()
    }
}

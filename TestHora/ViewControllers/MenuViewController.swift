//
//  ViewController.swift
//  TestHora
//
//  Created by Denis Svetlakov on 17.12.2020.
//

import UIKit

class MenuViewController: UIViewController {
    
    var sections: [Menu]!
    var dataSource: UICollectionViewDiffableDataSource <Menu, Dish>?
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    
    // Create collection view
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.reuseId)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))

            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
            let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .groupPagingCentered

            let layoutSectionHeader = self.createSectionHeader()
            layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

            return layoutSection
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 5
        layout.configuration = config
        return layout
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .estimated(40))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
    
    // Data source
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Menu, Dish>(collectionView: collectionView) {
            collectionView, indexPath, dish in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.reuseId,
                                                                for: indexPath) as? MenuCell
            else { fatalError() }
            cell.configure(with: dish)
            return cell
        }
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else { return nil }
            guard let firstDish = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstDish) else { return nil }
//            if section.name.isEmpty { return nil }
            sectionHeader.titleLabel.text = section.name
            return sectionHeader
        }
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Menu, Dish>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.dishes, toSection: section)
        }
        dataSource?.apply(snapshot)
    }
}



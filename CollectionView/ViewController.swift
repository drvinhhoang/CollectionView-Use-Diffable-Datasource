//
//  ViewController.swift
//  CollectionView
//
//  Created by VINH HOANG on 30/11/2021.
//


//1. declare a datasource
//2: Initialize diffable datasource,  and asign to datasource property.
//3. configure custom cell
//4. configure layout using compositional layout (including: sections, groups, items)
//5. add data to snapshot
//6. call datasource.apply(snapshot) to display data, choose to show difference or not.

import UIKit

class ViewController: UIViewController {

    enum Section {
        case main
    }
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // asigm compositional layout to colectionview's layout object.
        collectionView.collectionViewLayout = configureLayout()
        configureDataSource()
    }

    func configureLayout() -> UICollectionViewCompositionalLayout {
        
        //1. define itemsize
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
        //2. Create item from itemsize
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // add padding to 4 edges of item
        item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        //3. create group size
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/3))
        //4. create group from group size
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //5. Create section from group
        let section = NSCollectionLayoutSection(group: group)
        
        //6. return UICollectionViewCompositionalLayout by using section
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    
    func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, number in
            
            //1. setup a cell
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reuseIdentifier, for: indexPath) as? NumberCell else {
                fatalError("Cannot create new cell")
            }
           cell.label.text = number.description
            
            return cell
            
        })
        
        
        
        // 2. create snapshot
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        // 3. append section to snapshot
        initialSnapshot.appendSections([.main])
        // 4. append items to snapshot's section
        initialSnapshot.appendItems(Array(1...100), toSection: .main)
        //5.
        dataSource.apply(initialSnapshot, animatingDifferences: false)
        
        
    }
    
    
}


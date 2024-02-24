//
//  UICollectioView.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/12/23.
//

import UIKit

extension UICollectionView {
    
    func reloadCollection(isAnimate: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if isAnimate {
                UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.reloadData()
                }, completion: nil)
            } else {
                self.reloadData()
            }
        }
    }
    
    func dequeue<T: UICollectionViewCell>(_ cell: T.Type, _ indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as! T
    }
    
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: cell.identifier, bundle: nil), forCellWithReuseIdentifier: cell.identifier)
    }
    
    func dequeueHeader<T: UICollectionReusableView>(_ header: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header.identifier, for: indexPath) as! T
    }
    
    func dequeueFooter<T: UICollectionReusableView>(_ header: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: header.identifier, for: indexPath) as! T
    }
    
    func registerHeader<T: UICollectionReusableView>(_ view: T.Type) {
        return self.register(UINib(nibName: view.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: view.identifier)
    }
    
    func registerFooter<T: UICollectionReusableView>(_ view: T.Type) {
        self.register(UINib(nibName: view.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: view.identifier)
    }
}


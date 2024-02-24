//
//  UITableView.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import UIKit
extension UITableView{
    
    func sizeHeaderToFit() {
        if let headerView = self.tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            
            var newFrame = headerView.frame
            newFrame.size.height = height
            headerView.frame = newFrame
            
            headerView.layoutIfNeeded()
        }
    }
    
    func sizeFooterToFit() {
        if let footerView = self.tableFooterView {
            let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            
            var newFrame = footerView.frame
            newFrame.size.height = height
            footerView.frame = newFrame
            
            footerView.layoutIfNeeded()
        }
    }
    
    func reloadTableRows(isAnimate: Bool, path: [IndexPath]) {
        self.reloadRows(at: path, with: isAnimate ? .fade : .none)
    }
    
    func reloadTable(isAnimate: Bool, completion: ((Bool) -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if isAnimate {
                UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.reloadData()
                }, completion: completion)
            } else {
                self.reloadData()
            }
        }
    }

    func dequeueCell<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! T
    }
    
    func registerCell<T: UITableViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }
}



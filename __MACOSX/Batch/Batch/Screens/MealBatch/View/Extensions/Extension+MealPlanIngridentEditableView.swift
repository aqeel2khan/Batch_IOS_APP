//
//  Extension+MealPlanIngridentEditableView.swift
//  Batch
//
//  Created by Chawtech on 28/01/24.
//

import Foundation
import UIKit

extension MealPlanIngridentEditableView : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingridentlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(MealPlanIngridentTableCell.self, for: indexPath)
        cell.lblTitle.text = ingridentlist[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}

//  MARK:- Extension CollectionView

extension MealPlanIngridentEditableView : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == planReviewCollView {
            return 5
        }else if collectionView == showProtinListCollView{
            return 5
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == planReviewCollView {
            let cell = collectionView.dequeue(ReviewIngridentCollectionViewCell.self, indexPath)
            return cell
            
        }else if collectionView == showProtinListCollView{
            let cell1 = collectionView.dequeue(MealPlanProtienCollectionViewCell.self, indexPath)
            return cell1
        }
        return UICollectionViewCell()
        
    }
    
    
    
}

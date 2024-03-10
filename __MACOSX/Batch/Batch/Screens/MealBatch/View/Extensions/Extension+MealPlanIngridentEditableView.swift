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

extension MealPlanIngridentEditableView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == planReviewCollView {
            return 4
        } else if collectionView == showProtinListCollView{
            return self.nutritionList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == showProtinListCollView{
            let cell1 = collectionView.dequeue(MealPlanProtienCollectionViewCell.self, indexPath)
            cell1.nameLbl.text = self.nutritionList[indexPath.item].nutrientName
            let integerValue = self.nutritionList[indexPath.item].value?.components(separatedBy: ".").first ?? ""
            cell1.valueLbl.text = "\(integerValue)g"
            return cell1
        } else if collectionView == planReviewCollView {
            let cell = collectionView.dequeue(ReviewIngridentCollectionViewCell.self, indexPath)
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == showProtinListCollView {
            return CGSize(width: self.view.frame.size.width/4 - 20, height: 108)
        } else {
            return CGSize(width: self.view.frame.size.width - 60, height: 120)
        }
    }
    
}

//
//  Extension+MealBatchUnSubcribeDetailVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 29/01/24.
//

import Foundation
import UIKit

extension MealBatchUnSubscribeDetailVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 701 {
            return self.tagTitleArray.count
        }
        else if collectionView.tag == 702 {
            return self.mealCategoryArr.count
        }
        else if collectionView.tag == 703 {
            return self.dishesList.count
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 701 {
            let cell = collectionView.dequeue(BatchTrainingDetailCollCell.self, indexPath)
            cell.imgWorkOut.image = tagIconArray[indexPath.row]
            cell.lblWorkoutName.text = tagTitleArray[indexPath.row]
            return cell
        }
        else if collectionView.tag == 702 {
            let cell = collectionView.dequeue(BMealCategoryCollCell.self, indexPath)
            cell.categoryTitleLbl.text = mealCategoryArr[indexPath.item].categoryName
            return cell
        }
        else if collectionView.tag == 703 {
            let cell = collectionView.dequeue(BMealCollCell.self, indexPath)
            cell.radioBtn.isHidden = true
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == dishesCollView {
            return CGSize(width: dishesCollView.frame.width/2 - 10, height: 80)
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mealCategoryCollView {
            let cell : BMealCategoryCollCell = mealCategoryCollView.cellForItem(at: indexPath) as! BMealCategoryCollCell
            cell.bgView.backgroundColor = Colors.appViewPinkBackgroundColor
            
            self.getDishesListApi(mealCateogryId: self.mealCategoryArr[indexPath.item].categoryID!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == mealCategoryCollView {
            let cell : BMealCategoryCollCell = mealCategoryCollView.cellForItem(at: indexPath) as! BMealCategoryCollCell
            cell.bgView.backgroundColor = Colors.appViewBackgroundColor
        }
    }
    
}

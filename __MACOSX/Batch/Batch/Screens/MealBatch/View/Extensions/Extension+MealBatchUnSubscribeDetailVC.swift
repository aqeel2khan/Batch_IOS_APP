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
            let cell = collectionView.dequeue(BMealDishCollCell.self, indexPath)
            cell.radioBtn.isHidden = true
            cell.nameLbl.text = self.dishesList[indexPath.item].name
            cell.kclLbl.text = (self.dishesList[indexPath.item].avgPreparationTime ?? "0") + " kcal"
            return cell
        }
        return UICollectionViewCell()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == dishesCollView {
//            return CGSize(width: self.view.frame.width/2 - 10, height: 80)
//        }
//        return CGSize(width: 200, height: 60)
//    }
//
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
        else if collectionView == dishesCollView {
            let vc = MealPlanIngridentEditableView.instantiate(fromAppStoryboard: .batchMealPlans)
            vc.selectedMealData = self.mealData
            vc.dishData = self.dishesList[indexPath.item]
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == mealCategoryCollView {
            let cell : BMealCategoryCollCell = mealCategoryCollView.cellForItem(at: indexPath) as! BMealCategoryCollCell
            cell.bgView.backgroundColor = Colors.appViewBackgroundColor
        }
    }
    
}

extension MealBatchUnSubscribeDetailVC {
    @objc(collectionView:layout:sizeForItemAtIndexPath:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView.tag == 703 {
            let screenSize              = collectionView.frame.size //UIScreen.main.bounds
            let screenWidth             = screenSize.width
            let cellSquareSize: CGFloat = screenWidth
            return CGSize.init(width: cellSquareSize/2 - 20, height: 180) //250
        } else {
            let screenSize              = collectionView.frame.size //UIScreen.main.bounds
            let screenWidth             = screenSize.width
            return CGSize(width: screenWidth, height: 60)
        }
    }
    
    @objc(collectionView:layout:insetForSectionAtIndex:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: CGFloat(), right: 0)
    }
    
    @objc(collectionView:layout:minimumLineSpacingForSectionAtIndex:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 5
    }
    
    @objc(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 5
    }
}

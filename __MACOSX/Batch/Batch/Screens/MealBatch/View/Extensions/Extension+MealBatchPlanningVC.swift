//
//  Extension+MealBatchPlanningVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 28/01/24.
//

import Foundation
import UIKit

extension MealBatchPlanningVC: UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 601 {
            return self.weekDays.count
        }
        else if collectionView.tag == 602 {
            return self.mealCategoryArr.count
        }
        else if collectionView.tag == 603 {
            return self.dishesList.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 601 {
            let cell = collectionView.dequeue(weekCalenderCollCell.self, indexPath)
            cell.weekDayNameLbl.text = self.weekDays[indexPath.item].dayName
            cell.weekDateLbl.text = self.weekDays[indexPath.item].dayOfMonth
            cell.greenDotImgView.isHidden = true
            if let dishes = self.weekDays[indexPath.row].dishes, dishes.count > 0 {
                cell.greenDotImgView.isHidden = false
            }
            return cell
        } else if collectionView.tag == 602 {
            let cell = collectionView.dequeue(BMealCategoryCollCell.self, indexPath)
            cell.categoryTitleLbl.text = self.mealCategoryArr[indexPath.item].categoryName
            return cell
        } else if collectionView.tag == 603 {
            let cell = collectionView.dequeue(BMealDishCollCell.self, indexPath)
            cell.nameLbl.text = self.dishesList[indexPath.item].name
            // cell.kclLbl.text = self.dishesList[indexPath.item].
            if selectedWeekDay?.dishes?.contains(where: { $0.dishID == self.dishesList[indexPath.item].dishID }) ?? false {
                cell.radioBtn.isSelected = true
            } else {
                cell.radioBtn.isSelected = false
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = weekCalenderCollView.frame.width
        if collectionView.tag == 603 {
            return CGSize(width: screenWidth/2 - 10, height: 80)
        } else {
            return CGSize(width: screenWidth, height: 80)
        }
        
//        if collectionView.tag == 601
//        {
//            return CGSize(width: screenWidth/7, height: 80)
//        }
//        else if collectionView.tag == 602
//        {
//            return CGSize(width: screenWidth/3 - 10 , height: 80)
//        }
//        else if collectionView.tag == 603
//        {
//            return CGSize(width: screenWidth/2 - 10, height: 80)
//        }
//        else
//        {
//            return CGSize(width: screenWidth, height: 80)
//        }
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
        if collectionView.tag == 601 {
            let weekday = self.weekDays[indexPath.item]
            self.selectedWeekDay = weekday
            if let category = mealCategoryArr.first, let categoryID = category.categoryID {
                self.getDishesListApi(mealCateogryId: categoryID)
            }
        } else if collectionView.tag == 602 {
            if let cell = self.mealCategoryCollView.cellForItem(at: indexPath) as? BMealCategoryCollCell {
                cell.bgView.backgroundColor = Colors.appViewPinkBackgroundColor
                self.getDishesListApi(mealCateogryId: self.mealCategoryArr[indexPath.item].categoryID!)
            } else {
                // Handle the case when the cell is not available
                print("Cell is not available")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView.tag == 602 {
            if let cell = self.mealCategoryCollView.cellForItem(at: indexPath) as? BMealCategoryCollCell {
                cell.bgView.backgroundColor = Colors.appViewBackgroundColor
            } else {
                // Handle the case when the cell is not available
                print("Cell is not available")
            }
        }
    }

}

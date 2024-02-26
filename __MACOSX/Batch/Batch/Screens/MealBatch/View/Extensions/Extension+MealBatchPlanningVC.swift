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
        /*
         switch collectionView.tag {
         case 301:
         return self.weekDayNameArr.count
         case 302:
         return self.mealCategoryTitleArr.count
         case 303:
         return 8
         default:
         return 0
         }
         */
        
        if collectionView.tag == 601
        {
            return self.weekDayNameArr.count
        }
        else if collectionView.tag == 602
        {
            return self.mealCategoryTitleArr.count
        }
        else if collectionView.tag == 603
        {
            return 8
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 601
        {
            let cell = collectionView.dequeue(weekCalenderCollCell.self, indexPath)
            cell.weekDayNameLbl.text = self.weekDayNameArr[indexPath.item]
            cell.weekDateLbl.text    = self.weekDateArr[indexPath.item]
            return cell
        }
        else if collectionView.tag == 602
        {
            let cell = collectionView.dequeue(BMealCategoryCollCell.self, indexPath)
            cell.categoryTitleLbl.text = mealCategoryTitleArr[indexPath.item]
            return cell
        }
        else if collectionView.tag == 603
        {
            let cell = collectionView.dequeue(BMealDishCollCell.self, indexPath)
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
        
        /*
         switch collectionView.tag {
         case 301:
         case 302:
         case 303:
         default:
         return UICollectionViewCell()
         }
         */
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let screenWidth = weekCalenderCollView.frame.width
//        
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
//    }
    
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
        /*
         let vc = MealBatchDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
         vc.modalPresentationStyle = .overFullScreen
         vc.modalTransitionStyle = .coverVertical
         self.present(vc, animated: true)
         */
    }
    
}

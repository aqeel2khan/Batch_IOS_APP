//
//  Extension+MealBatchVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//

import Foundation
import UIKit

extension MealBatchVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mealListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(MealPlanTVC.self, for: indexPath)
        cell.titleLbl.text = self.mealListData[indexPath.row].name
        cell.priceLbl.text = "from $\(self.mealListData[indexPath.row].price ?? "")"
        cell.kclLbl.text = "\(self.mealListData[indexPath.row].avgCalPerDay ?? "") kcal"
        cell.mealsLbl.text = "\(self.mealListData[indexPath.row].name ?? "") meals"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MealBatchUnSubscribeDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300 //UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
    }
    
}

//extension MealBatchVC: UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 8
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealPlanCollectionCell", for: indexPath)  as! MealPlanCollectionCell
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let screenWidth = mealPlanCollView.frame.width - 10
//        return CGSize(width: screenWidth, height: 300)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
//        UIView.animate(
//            withDuration: 0.5,
//            delay: 0.05 * Double(indexPath.row),
//            options: [.curveEaseInOut],
//            animations: {
//                cell.transform = CGAffineTransform(translationX: 0, y: 0)
//            })
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // /*
//        let vc = MealBatchDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
//        vc.isCommingFrom = "MealBatchVCWithSubscribeBatch"
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .coverVertical
//        self.present(vc, animated: true)
//        // */
//        //
//        //        let vc = MealPlanIngridentEditableView.instantiate(fromAppStoryboard: .batchMealPlans)
//        //        vc.modalPresentationStyle = .overFullScreen
//        //        vc.modalTransitionStyle = .coverVertical
//        //        self.present(vc, animated: true)
//    }
//}

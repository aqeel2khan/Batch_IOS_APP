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
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
         let cell = tableView.dequeueCell(MealPlanTVC.self, for: indexPath)
         return cell
         */
        if indexPath.row != 7
        {
            let cell = tableView.dequeueCell(MealPlanTVC.self, for: indexPath)
            cell.btnMealPlan.tag = indexPath.row
            cell.btnMealPlan.addTarget(self, action: #selector(btnMealPlanAction(_:)), for: .touchUpInside)
            return cell
        }
        else
        {
            let cell = tableView.dequeueCell(MealPlanBottomCell.self, for: indexPath)
            cell.calculateBtn.tag = indexPath.row
            cell.calculateBtn.addTarget(self, action: #selector(btnMealPlanAction(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    
    @objc  func btnMealPlanAction(_ sender:UIButton) {
        
        if sender.tag != 7
        {
            let vc = MealBatchUnSubscribeDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
        else
        {
            let vc = QuestionGoalVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
        
        
        /*
         let vc = MealPlanCheckout.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
         vc.modalPresentationStyle = .fullScreen
         vc.modalTransitionStyle = .crossDissolve
         self.present(vc, animated: true)
         */
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
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

extension MealBatchVC: UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealPlanCollectionCell", for: indexPath)  as! MealPlanCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = mealPlanCollView.frame.width - 10
        return CGSize(width: screenWidth, height: 300)
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
        // /*
        let vc = MealBatchDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
        vc.isCommingFrom = "MealBatchVCWithSubscribeBatch"
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
        // */
        //
        //        let vc = MealPlanIngridentEditableView.instantiate(fromAppStoryboard: .batchMealPlans)
        //        vc.modalPresentationStyle = .overFullScreen
        //        vc.modalTransitionStyle = .coverVertical
        //        self.present(vc, animated: true)
    }
}

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
        if searchTextField.text == "" {
            if self.mealListData.count > 0 {
                return self.mealListData.count
            }
        } else {
            if self.searchmealListData.count > 0 {
                return self.searchmealListData.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchTextField.text == "" && indexPath.row == 2 &&  mealListData.count > 0 {
            let cell = tableView.dequeueCell(MealPlanBannerViewTVC.self, for: indexPath)
            return cell
        } else {
                if indexPath.row < 2 {
                    if searchTextField.text == "" {
                        let cell = tableView.dequeueCell(MealPlanTVC.self, for: indexPath)
                        cell.titleLbl.text = self.mealListData[indexPath.row].name
                        cell.priceLbl.text = "from $\(self.mealListData[indexPath.row].price ?? "")"
                        cell.kclLbl.text = "\(self.mealListData[indexPath.row].avgCalPerDay ?? "") kcal"
                        cell.mealsLbl.text = "\(self.mealListData[indexPath.row].mealCount ?? 0) meals"
                        return cell
                    } else {
                        let cell = tableView.dequeueCell(MealPlanTVC.self, for: indexPath)
                        cell.titleLbl.text = self.searchmealListData[indexPath.row].name
                        cell.priceLbl.text = "from $\(self.searchmealListData[indexPath.row].price ?? "")"
                        cell.kclLbl.text = "\(self.searchmealListData[indexPath.row].avgCalPerDay ?? "") kcal"
                        cell.mealsLbl.text = "\(self.searchmealListData[indexPath.row].mealCount ?? 0) meals"
                        return cell
                    }
                } else {
                    if searchTextField.text == "" {
                        let cell = tableView.dequeueCell(MealPlanTVC.self, for: indexPath)
                        cell.titleLbl.text = self.mealListData[indexPath.row - 1].name
                        cell.priceLbl.text = "from $\(self.mealListData[indexPath.row - 1].price ?? "")"
                        cell.kclLbl.text = "\(self.mealListData[indexPath.row - 1].avgCalPerDay ?? "") kcal"
                        cell.mealsLbl.text = "\(self.mealListData[indexPath.row - 1].mealCount ?? 0) meals"
                        return cell
                    } else {
                        let cell = tableView.dequeueCell(MealPlanTVC.self, for: indexPath)
                        cell.titleLbl.text = self.searchmealListData[indexPath.row].name
                        cell.priceLbl.text = "from $\(self.searchmealListData[indexPath.row].price ?? "")"
                        cell.kclLbl.text = "\(self.searchmealListData[indexPath.row].avgCalPerDay ?? "") kcal"
                        cell.mealsLbl.text = "\(self.searchmealListData[indexPath.row].mealCount ?? 0) meals"
                        return cell
                    }
                }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < 2 {
            if searchTextField.text == "" {
                let vc = MealBatchUnSubscribeDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .coverVertical
                vc.mealData = self.mealListData[indexPath.item]
                self.present(vc, animated: true)
            } else {
                let vc = MealBatchUnSubscribeDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .coverVertical
                vc.mealData = self.searchmealListData[indexPath.item]
                self.present(vc, animated: true)
            }
        }
        else if indexPath.row > 2 {
            if searchTextField.text == "" {
                let vc = MealBatchUnSubscribeDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .coverVertical
                vc.mealData = self.mealListData[indexPath.item + 1]
                self.present(vc, animated: true)
            } else {
                let vc = MealBatchUnSubscribeDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .coverVertical
                vc.mealData = self.searchmealListData[indexPath.item]
                self.present(vc, animated: true)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260 //UITableView.automaticDimension
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

extension MealBatchVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == searchTextField {
            let placeTextFieldStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
            timer?.invalidate()
            timer = Timer.scheduledTimer(
                timeInterval: 0.5,
                target: self,
                selector: #selector(getHints),
                userInfo: placeTextFieldStr,
                repeats: false)
        }
        return true
    }
    
    @objc func getHints(timer: Timer) {
            let userInfo = timer.userInfo as! String
        self.searchmealListData = self.mealListData.filter{ $0.name!.lowercased().contains(userInfo.lowercased()) }

            self.mealPlanTblView.reloadData()
    }
}

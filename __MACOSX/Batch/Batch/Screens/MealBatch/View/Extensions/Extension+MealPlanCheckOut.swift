//
//  Extension+MealPlanCheckOut.swift
//  Batch
//
//  Created by Chawtech on 26/01/24.
//

import Foundation
import UIKit

extension MealPlanCheckout :UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliverTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(MealPlanCheckoutCell.self, for: indexPath)
        cell.lblTitle.text = deliverTitles[indexPath.row].localized
        
        if indexPath.row == 0 {
            if MealSubscriptionManager.shared.startDate != nil {
                cell.lblSubTitle.text = MealSubscriptionManager.shared.startDate
            } else {
                cell.lblSubTitle.text = ""
            }
        } else if indexPath.row == 1 {
            if MealSubscriptionManager.shared.area != nil {
                cell.lblSubTitle.text = MealSubscriptionManager.shared.area
            } else {
                cell.lblSubTitle.text = ""
            }
            
            if MealSubscriptionManager.shared.house != nil {
                cell.lblTitle.text = "\(MealSubscriptionManager.shared.house ?? "")  \(MealSubscriptionManager.shared.street ?? "")"
            }
            
        } else if indexPath.row == 2 {
            if MealSubscriptionManager.shared.deliveryTime != nil {
                cell.lblSubTitle.text = MealSubscriptionManager.shared.deliveryTime
            } else {
                cell.lblSubTitle.text = ""
            }
        } else if indexPath.row == 3 {
            if MealSubscriptionManager.shared.deliveryArriving != nil {
                cell.lblSubTitle.text = MealSubscriptionManager.shared.deliveryArriving
            } else {
                cell.lblSubTitle.text = ""
            }
        } else if indexPath.row == 4 {
            if MealSubscriptionManager.shared.deliveryDropoff != nil {
                cell.lblSubTitle.text = MealSubscriptionManager.shared.deliveryDropoff
            } else {
                cell.lblSubTitle.text = ""
            }
        }
        cell.imgDeliveryItem.image = deliverImages[indexPath.row]
        cell.btnSelctDeliveryItems.tag = indexPath.row
        cell.btnSelctDeliveryItems.addTarget(self, action: #selector(selectDeleviryAddress(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func selectDeleviryAddress(_ sender:UIButton) {
        if sender.tag == 0 {
            let vc = StartDatePlanVC.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.completion = {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.delivertTableView.reloadData()
                }
            }
            self.present(vc, animated: true)
        }
        else if sender.tag == 1 {
            let vc = MealPlanAddressVC.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.completion = {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.delivertTableView.reloadData()
                }
            }
            self.present(vc, animated: true)
        }
        else if sender.tag == 2 {
            let vc = MealPlanDeliveryTimeVC.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            vc.completion = {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.delivertTableView.reloadData()
                }
            }
            
            self.present(vc, animated: true)
        }
        else if sender.tag == 3 {
            let vc = MealDilevaryArrivingVC.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.completion = {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.delivertTableView.reloadData()
                }
            }
            self.present(vc, animated: true)
        }
        else if sender.tag == 4 {
            let vc = MealDilevaryDropOffVC.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.completion = {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.delivertTableView.reloadData()
                }
            }
            self.present(vc, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
//        UIView.animate(
//            withDuration: 0.5,
//            delay: 0.05 * Double(indexPath.row),
//            options: [.curveEaseInOut],
//            animations: {
//                cell.transform = CGAffineTransform(translationX: 0, y: 0)
//            })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}

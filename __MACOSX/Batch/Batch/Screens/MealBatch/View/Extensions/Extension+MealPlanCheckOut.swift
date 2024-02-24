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
        cell.lblTitle.text = deliverTitles[indexPath.row]
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
            self.present(vc, animated: true)
        }
        else if sender.tag == 1 {
            let vc = MealPlanAddressVC.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        else if sender.tag == 2 {
            let vc = BWOPlanDurationPopUpVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
            vc.isCommingFrom = "MealPlanAddressVC"
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
        else if sender.tag == 3 {
            let vc = MealDilevaryArrivingVC.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        else if sender.tag == 4 {
            let vc = MealDilevaryDropOffVC.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}

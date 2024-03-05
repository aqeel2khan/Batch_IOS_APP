//
//  Extension+BStartWorkOutDetailVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 22/01/24.
//

import Foundation
import UIKit
//MARK:- Tableview func

extension BUserNotificationVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(NotificationSettingsListTableCell.self,for: indexPath)
//        let info = totalCourseArr[indexPath.row]
//        cell.lblTitle.text  = "Lower-Body Burn"
//        cell.lblKalori.text = "\(info.calorieBurn ?? "") kcal"
//        cell.lblMints.text  = "\(info.workoutTime ?? "") mins"
        if notificationPrefrences?.data?.all ?? 0 == 1 && notificationList[indexPath.row] == "All notifications"{
            cell.switchBtn.isOn = true
        }
        
        if notificationPrefrences?.data?.training ?? 0 == 1 && notificationList[indexPath.row] == "Training notifications"{
            cell.switchBtn.isOn = true
        }
        
        if notificationPrefrences?.data?.live_stream ?? 0 == 1 && notificationList[indexPath.row] == "Live stream notifications"{
            cell.switchBtn.isOn = true
        }
        
        if notificationPrefrences?.data?.meal_plan ?? 0 == 1 && notificationList[indexPath.row] == "Meal plan notificatins"{
            cell.switchBtn.isOn = true
        }
        
        if notificationPrefrences?.data?.delivery ?? 0 == 1 && notificationList[indexPath.row] == "Delivery notifications"{
            cell.switchBtn.isOn = true
        }
        cell.lblTitle.text = notificationList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
//            UIView.animate(
//                withDuration: 0.5,
//                delay: 0.05 * Double(indexPath.row),
//                options: [.curveEaseInOut],
//                animations: {
//                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
//            })
    }

    
}

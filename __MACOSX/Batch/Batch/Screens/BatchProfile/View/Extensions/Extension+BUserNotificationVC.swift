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
        cell.switchBtn.tag = indexPath.row
        if notificationPrefrences?.data?.all ?? 0 == 1 && notificationList[indexPath.row] == "All notifications".localized {
            cell.switchBtn.isOn = true
        }
        
        if notificationPrefrences?.data?.training ?? 0 == 1 && notificationList[indexPath.row] == "Training notifications".localized {
            cell.switchBtn.isOn = true
        }
        
        if notificationPrefrences?.data?.live_stream ?? 0 == 1 && notificationList[indexPath.row] == "Live stream notifications".localized {
            cell.switchBtn.isOn = true
        }
        
        if notificationPrefrences?.data?.meal_plan ?? 0 == 1 && notificationList[indexPath.row] == "Meal plan notifications".localized {
            cell.switchBtn.isOn = true
        }
        
        if notificationPrefrences?.data?.delivery ?? 0 == 1 && notificationList[indexPath.row] == "Delivery notifications".localized {
            cell.switchBtn.isOn = true
        }
        cell.lblTitle.text = notificationList[indexPath.row].localized
        
        cell.callBack = {
            if cell.switchBtn.isOn {
                self.notificaionPrefrenceList[self.notificationList[indexPath.row]] = 1
            }else{
                self.notificaionPrefrenceList[self.notificationList[indexPath.row]] = 0
            }
        }
        
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

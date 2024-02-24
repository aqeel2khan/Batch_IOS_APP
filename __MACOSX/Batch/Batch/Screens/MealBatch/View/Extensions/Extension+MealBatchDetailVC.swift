//
//  Extension+MealBatchDetailVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 28/01/24.
//

import Foundation
import UIKit

extension MealBatchDetailVC: UITableViewDelegate,UITableViewDataSource {
    /*
     func numberOfSections(in tableView: UITableView) -> Int {
     3
     }
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.sectionTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(BMealTblCell.self, for: indexPath)
        cell.sectionTitleLbl.text = sectionTitleArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tap On Collection")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140 //UITableView.automaticDimension
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

extension MealBatchDetailVC: UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 201
        {
            return self.tagTitleArray.count
        }
        else if collectionView.tag == 202
        {
            return 7
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 201
        {
            let cell = collectionView.dequeue(BatchTrainingDetailCollCell.self, indexPath)
            cell.imgWorkOut.image = tagIconArray[indexPath.row]
            cell.lblWorkoutName.text = tagTitleArray[indexPath.row]
            return cell
        }
        else if collectionView.tag == 202
        {
            let cell = collectionView.dequeue(weekCalenderCollCell.self, indexPath)
            cell.weekDayNameLbl.text = self.weekDayNameArr[indexPath.row]
            cell.weekDateLbl.text    = self.weekDateArr[indexPath.row]
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let screenWidth = weekCalenderCollView.frame.width
//        let screenHeight = tagCollView.frame.height
//        if collectionView.tag == 202
//        {
//            return CGSize(width: screenWidth/7, height: 80)
//        }
//        else
//        {
//            return CGSize(width: screenWidth, height: screenHeight)
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

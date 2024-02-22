//
//  Extension+BStartWorkOutDetailVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 22/01/24.
//

import Foundation
import UIKit
//import QuartzCore

extension BWorkOutDetailVC: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return newArray.count//workOutArray.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(BatchTrainingDetailCollCell.self, indexPath)
//        cell.imgWorkOut.image = workOutIconArray[indexPath.row]
//        cell.lblWorkoutName.text = workOutArray[indexPath.row]
        
        cell.imgWorkOut.image = newImage[indexPath.row]
        cell.lblWorkoutName.text = newArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
//        UIView.animate(
//            withDuration: 0.5,
//            delay: 0.05 * Double(indexPath.row),
//            options: [.curveEaseInOut],
//            animations: {
//                cell.transform = CGAffineTransform(translationX: 0, y: 0)
//        })
    }
    
}

//MARK:- Tableview func

extension BWorkOutDetailVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCommingFrom == "workoutbatches" {
            return self.totalCourseArr.count

        } else if isCommingFrom == "dashboard" {
            return self.totalCourseDashboardArr.count
        }
//        else if isCommingFrom == "MotivatorDetailVC"
//        {
//            return self.woMotivatorInfo?.
//        }
        
        return self.totalCourseArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(TrainingListTableCell.self,for: indexPath)
        if isCommingFrom == "workoutbatches" {
            let info = totalCourseArr[indexPath.row]
            cell.lblTitle.text  = "Lower-Body Burn"
            cell.lblKalori.text = "\(info.calorieBurn ?? "") kcal"
            cell.lblMints.text  = "\(info.workoutTime ?? "") mins"

        } else if isCommingFrom == "dashboard" {
            let info = self.totalCourseDashboardArr[indexPath.row]
            cell.lblTitle.text  = "Lower-Body Burn"
            cell.lblKalori.text = "\(info.calorieBurn ?? "") kcal"
            cell.lblMints.text  = "\(info.workoutTime ?? "") mins"
        }
        else {
            let info = totalCourseArr[indexPath.row]
            cell.lblTitle.text  = "Lower-Body Burn"
            cell.lblKalori.text = "\(info.calorieBurn ?? "") kcal"
            cell.lblMints.text  = "\(info.workoutTime ?? "") mins"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension //1300//
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let vc = VimoPlayerVC.instantiate(fromAppStoryboard: .batchTrainings)
//        vc.viemoVideoArr = vimoVideoURL
//        vc.videoIdInfo   = courseDurationExerciseArr[indexPath.row]
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .coverVertical
////        vc.completion = {
////                    print("Coming back Motivator filter Id")
////            print(self.vimoVideoURL)
////            self.callApiServices()
////
////                }
//        self.present(vc, animated: true)
        
    }

    
}

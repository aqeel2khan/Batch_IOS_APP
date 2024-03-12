//
//  Extension+BStartWorkOutDetailVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 22/01/24.
//

import Foundation
import UIKit

extension BWorkOutDetailVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(BatchTrainingDetailCollCell.self, indexPath)
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
            //return self.totalCourseArr.count
            return self.unsubscribeWorkoutsInfo.count
        } else if isCommingFrom == "dashboard" {
            return self.totalCourseDashboardArr.count
        }
        //        else if isCommingFrom == "MotivatorDetailVC" {
        //            return self.woMotivatorInfo?.
        //        }
        else {
            return self.totalCourseArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(TrainingListTableCell.self,for: indexPath)
        if isCommingFrom == "workoutbatches"
        {
            let info = self.unsubscribeWorkoutsInfo[indexPath.row]
            if info.status == 0 {
                cell.dayLbl.text = ""
                cell.lblTitle.text  = "Day Off"
                cell.bottomStackView.isHidden = true
            } else {
                cell.dayLbl.text = "\(indexPath.row + 1)"
                cell.lblTitle.text  = info.dayName
                //                cell.lblKalori.text = "\(info.calorieBurn ?? "") kcal"
                let originalKcalString = "\(info.calorieBurn ?? "") kcal"
                let keyword1 = BatchConstant.kcalSuffix
                let attributedKcalString = NSAttributedString.attributedStringWithDifferentFonts(for: originalKcalString, prefixFont: UIFont(name:"Outfit-Medium",size:14)!, suffixFont: UIFont(name:"Outfit-Medium",size:10)!, keyword: keyword1)
                cell.lblKalori.attributedText = attributedKcalString
                
                let originalMinsString = "\(info.workoutTime ?? "") mins"
                let keyword2 = BatchConstant.minsSuffix
                let attributedMinsString = NSAttributedString.attributedStringWithDifferentFonts(for: originalMinsString, prefixFont: UIFont(name:"Outfit-Medium",size:14)!, suffixFont: UIFont(name:"Outfit-Medium",size:10)!, keyword: keyword2)
                cell.lblMints.attributedText = attributedMinsString
                
                
                //                cell.lblMints.text  = "\(info.workoutTime ?? "") mins"
                cell.bottomStackView.isHidden = false
            }
        }
        //        {
        //            let info = totalCourseArr[indexPath.row]
        //            if info.status == 0 {
        //                cell.dayLbl.text = ""
        //                cell.lblTitle.text  = "Day Off"
        //                cell.bottomStackView.isHidden = true
        //            } else {
        //                cell.dayLbl.text = "\(indexPath.row + 1)"
        //                cell.lblTitle.text  = "Lower-Body Burn"
        //                cell.lblKalori.text = "\(info.calorieBurn ?? "") kcal"
        //                cell.lblMints.text  = "\(info.workoutTime ?? "") mins"
        //                cell.bottomStackView.isHidden = false
        //            }
        //
        //
        //        }
        else if isCommingFrom == "dashboard" {
            let info = self.totalCourseDashboardArr[indexPath.row]
            if info.status == 0 {
                cell.dayLbl.text = ""
                cell.lblTitle.text  = "Day Off"
                cell.bottomStackView.isHidden = true
            } else {
                cell.dayLbl.text = "\(indexPath.row + 1)"
                cell.lblTitle.text  = info.dayName
                //                cell.lblKalori.text = "\(info.calorieBurn ?? "") kcal"
                //                cell.lblMints.text  = "\(info.workoutTime ?? "") mins"
                
                let originalKcalString = "\(info.calorieBurn ?? "") kcal"
                let keyword1 = BatchConstant.kcalSuffix
                let attributedKcalString = NSAttributedString.attributedStringWithDifferentFonts(for: originalKcalString, prefixFont: UIFont(name:"Outfit-Medium",size:14)!, suffixFont: UIFont(name:"Outfit-Medium",size:10)!, keyword: keyword1)
                cell.lblKalori.attributedText = attributedKcalString
                
                let originalMinsString = "\(info.workoutTime ?? "") mins"
                let keyword2 = BatchConstant.minsSuffix
                let attributedMinsString = NSAttributedString.attributedStringWithDifferentFonts(for: originalMinsString, prefixFont: UIFont(name:"Outfit-Medium",size:14)!, suffixFont: UIFont(name:"Outfit-Medium",size:10)!, keyword: keyword2)
                cell.lblMints.attributedText = attributedMinsString
                
                
                
                cell.bottomStackView.isHidden = false
            }
            
            if indexPath.row == (todayWorkoutsInfo.row ?? 0) - 1 {
                cell.dayLbl.backgroundColor  = Colors.appThemeButtonColor
                cell.dayLbl.textColor = .white
            } else {
                cell.dayLbl.backgroundColor  = .clear
                cell.dayLbl.textColor = .black
            }
            
        } else {
            let info = totalCourseArr[indexPath.row]
            if info.status == 0 {
                cell.dayLbl.text = ""
                cell.lblTitle.text  = "Day Off"
                cell.bottomStackView.isHidden = true
            } else {
                cell.dayLbl.text = "\(indexPath.row + 1)"
                cell.lblTitle.text  = "Lower-Body Burn"
                //                cell.lblKalori.text = "\(info.calorieBurn ?? "") kcal"
                //                cell.lblMints.text  = "\(info.workoutTime ?? "") mins"
                
                
                let originalKcalString = "\(info.calorieBurn ?? "") kcal"
                let keyword1 = BatchConstant.kcalSuffix
                let attributedKcalString = NSAttributedString.attributedStringWithDifferentFonts(for: originalKcalString, prefixFont: UIFont(name:"Outfit-Medium",size:14)!, suffixFont: UIFont(name:"Outfit-Medium",size:10)!, keyword: keyword1)
                cell.lblKalori.attributedText = attributedKcalString
                
                let originalMinsString = "\(info.workoutTime ?? "") mins"
                let keyword2 = BatchConstant.minsSuffix
                let attributedMinsString = NSAttributedString.attributedStringWithDifferentFonts(for: originalMinsString, prefixFont: UIFont(name:"Outfit-Medium",size:14)!, suffixFont: UIFont(name:"Outfit-Medium",size:10)!, keyword: keyword2)
                cell.lblMints.attributedText = attributedMinsString
                
                cell.bottomStackView.isHidden = false
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
        
        if isCommingFrom == "dashboard" {
            if self.totalCourseDashboardArr[indexPath.row].status == 0 {
                return
            }
            
            self.videoIdArr.removeAll()
            for i in 0..<self.totalCourseDashboardArr[indexPath.row].courseDurationExercise!.count {
                let idArray = self.totalCourseDashboardArr[indexPath.row].courseDurationExercise
                let videoId = idArray?[i].videoDetail?.videoID ?? ""
                self.videoIdArr.append(videoId)
            }
            showLoading()
            vimoVideoURLList.removeAll()
            DispatchQueue.main.async {
                self.vimoVideoSetUp {
                    hideLoading()
                    if self.vimoVideoURLList.count != 0 {
                        let vc = VimoPlayerVC.instantiate(fromAppStoryboard: .batchTrainings)
                        vc.courseDetail = self.courseDetailsInfo
                        vc.viemoVideoArr = self.vimoVideoURLList
                        
                        if self.isCommingFrom == "dashboard" {
                            vc.dayNumberText = "\(indexPath.row + 1) / \(self.totalCourseDashboardArr.count)"
                        } else {
                            vc.dayNumberText = "\(indexPath.row + 1) / \(self.totalCourseArr.count)"
                        }
                        vc.todayWorkoutsInfo = self.todayWorkoutsInfo
                        vc.courseDurationExerciseArr = self.totalCourseDashboardArr[indexPath.row].courseDurationExercise!
                        vc.titleText = self.self.totalCourseDashboardArr[indexPath.row].dayName ?? ""
                        vc.modalPresentationStyle = .overFullScreen
                        vc.modalTransitionStyle = .coverVertical
                        vc.completion = {
                            print(self.vimoVideoURLList)
                            self.callApiServices()
                        }
                        self.present(vc, animated: true)
                    }
                }
            }
        }
    }
}

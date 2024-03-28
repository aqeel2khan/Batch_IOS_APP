//
//  Extension+MealBatchVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//

import Foundation
import UIKit
import SDWebImage

extension BatchDashboardVC: UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mealBatchCollView {
            if self.subscribedMealListData.count > 0 {
                return self.subscribedMealListData.count
            }
        } else {
            if self.courseList.count > 0 {
                return self.courseList.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mealBatchCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealBatchDashboardCollectionCell", for: indexPath)  as! MealBatchDashboardCollectionCell
            if self.subscribedMealListData.count > 0 {
                cell.titleLbl.text = self.subscribedMealListData[indexPath.item].name
                cell.descLbl.text = self.subscribedMealListData[indexPath.item].description
                if let startDate = createDate(from: self.subscribedMealListData[indexPath.item].startDate), let endDate = createDate(from: self.subscribedMealListData[indexPath.item].endDate) {
                    let (remainingDays, totalDays) = remainingDays(startDate: startDate, endDate: endDate)
                    let formattedString = "\(remainingDays)/\(totalDays) days"
                    cell.daysLbl.text = formattedString
                }
                if let startDate = createDate(from: self.subscribedMealListData[indexPath.item].startDate), let endDate = createDate(from: self.subscribedMealListData[indexPath.item].endDate) {
                    let percentage = calculatePercentage(startDate: startDate, endDate: endDate)
                    cell.progressView.progress = percentage
                }
                
                let fileUrl = URL(string: BaseUrl.imageBaseUrl + (self.subscribedMealListData[indexPath.row].image ?? ""))
                cell.imageBackGrd.sd_setImage(with: fileUrl , placeholderImage:UIImage(named: "Meal"))
            }
            return cell
        }

//        if collectionView == mealBatchCollView {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealBatchDashboardCollectionCell", for: indexPath)  as! MealBatchDashboardCollectionCell
//            if self.subscribedMealListData.count > 0 {
//
//                cell.titleLbl.text = self.subscribedMealListData[indexPath.row].name
//                let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(self.subscribedMealListData[indexPath.row].price ?? "")", prefixFont: UIFont(name:"Outfit-Medium",size:10)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
//                cell.priceLbl.attributedText = attributedPriceString
//
//                let original1String = "\(self.subscribedMealListData[indexPath.row].avgCalPerDay ?? "") \(BatchConstant.kcalSuffix)"
//                let keyword1 = BatchConstant.kcalSuffix
//                let attributedString = NSAttributedString.attributedStringWithDifferentFonts(for: original1String, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword1)
//                cell.kclLbl.attributedText = attributedString
//                cell.mealsLbl.text = "\(self.subscribedMealListData[indexPath.row].mealCount ?? 0) \(BatchConstant.meals)"
//
//                let original2String = "\(self.subscribedMealListData[indexPath.row].mealCount ?? 0) \(BatchConstant.meals)"
//                let keyword2 = BatchConstant.meals
//                let attributedString1 = NSAttributedString.attributedStringWithDifferentFonts(for: original2String, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword2)
//                cell.mealsLbl.attributedText = attributedString1
//
//                if let startDate = createDate(from: self.subscribedMealListData[indexPath.item].startDate), let endDate = createDate(from: self.subscribedMealListData[indexPath.item].endDate) {
//                    let percentage = calculatePercentage(startDate: startDate, endDate: endDate)
//                    cell.progressView.progress = percentage
//                }
//                return cell
//            }
//        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkoutBatchDashboardCollectionCell", for: indexPath)  as! WorkoutBatchDashboardCollectionCell
            
            if self.courseList.count > 0 {
                let course = self.courseList[indexPath.item].courseDetail
                
                let fileUrl = URL(string: BaseUrl.imageBaseUrl + (course?.courseImage ?? ""))
                cell.bgImageView.sd_setImage(with: fileUrl , placeholderImage:UIImage(named: "Image"))
                cell.titleLbl.text = course?.courseName
                cell.daysLbl.text = "\(self.courseList[indexPath.item].todayWorkouts?.row ?? 0)" + "/" + (course?.duration ?? "")
                cell.kclLbl.text = (course?.perDayWorkout ?? "") + " \(BatchConstant.minsSuffix)"
                cell.minLbl.text = (course?.duration ?? "") + " \(BatchConstant.days)"
                
                if let startDate = createCourseDate(from: self.courseList[indexPath.item].startDate ?? ""), let endDate = createCourseDate(from: self.courseList[indexPath.item].endDate ?? "") {
                    let percentage = calculatePercentage(startDate: startDate, endDate: endDate)
                    cell.progressView.progress = percentage
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var screenWidth : CGFloat!
        if collectionView == mealBatchCollView {
            if subscribedMealListData.count == 1 {
                screenWidth = mealBatchCollView.frame.width
            } else {
                screenWidth = mealBatchCollView.frame.width - 20
            }
            return CGSize(width: screenWidth, height: 248)
        } else {
            if courseList.count == 1 {
                screenWidth = workoutBatchCollView.frame.width
            } else {
                screenWidth = workoutBatchCollView.frame.width - 20
            }
        }
        return CGSize(width: screenWidth, height: 250)
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
        if collectionView == mealBatchCollView {
            let vc = MealBatchDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
            vc.mealData = self.subscribedMealListData[indexPath.item]
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)

        } else {
            let vc = BWorkOutDetailVC.instantiate(fromAppStoryboard: .batchTrainings)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            let info = self.courseList[indexPath.item]
            
            vc.courseDetailsInfo = info.courseDetail
            vc.todayWorkoutsInfo = info.todayWorkouts
            vc.isCommingFrom = "dashboard"
            
//            vc.newArray.append("\(String(describing: info.courseDetail?.duration ?? "" )) min")
//            vc.newImage.append(UIImage(named: "clock-circle-black")!)
            
            vc.newArray.append("\(String(describing: info.courseDetail?.courseLevel?.levelName ?? "" ))")
            vc.newImage.append(UIImage(named: "barchart-black")!)
            
            if info.courseDetail?.workoutType?.count != 0 {
                let workOutType = info.courseDetail?.workoutType?.count
                
                for i in 0..<(info.courseDetail?.workoutType?.count ?? 0) {
                    vc.newArray.append("\(info.courseDetail?.workoutType?[i].workoutdetail?.workoutType ?? "" )")
                    vc.newImage.append(UIImage(named: "accessibility_Black")!)
                }
            }
            self.present(vc, animated: true)
        }
    }
    
    func calculatePercentage(startDate: Date, endDate: Date) -> Float {
        let currentDate = Date()
        let totalTimeInterval = endDate.timeIntervalSince(startDate)
        let currentTimeInterval = currentDate.timeIntervalSince(startDate)
        let percentage = Float(currentTimeInterval / totalTimeInterval)
        return percentage
    }
    
    func createDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
    
    func createCourseDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
    
    func remainingDays(startDate: Date, endDate: Date) -> (Int, Int) {
        let currentDate = Date()
        
        // If start date is greater than current date, return (0, 0)
        if startDate > currentDate {
            return (0, 0)
        }
        
        let totalTimeInterval = endDate.timeIntervalSince(startDate)
        let remainingTimeInterval = endDate.timeIntervalSince(currentDate)
        
        // If the remaining time interval is negative, return (0, 0)
        if remainingTimeInterval < 0 {
            return (0, 0)
        }
        
        let totalDays = Int(totalTimeInterval / (24 * 60 * 60)) // Total days between start date and end date
        let remainingDays = Int(remainingTimeInterval / (24 * 60 * 60)) // Remaining days between current date and end date
        
        return (remainingDays, totalDays)
    }
}

//
//  Extension+BatchBoardHomeVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//
// com.BatchiOS - clint Bundle id
// com.demoAppJay - jay

import Foundation
import UIKit

extension BatchBoardHomeVC : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == woBatchCollView {
            return self.courseListDataArr.count < 5 ? self.courseListDataArr.count : 5
        }
        else if collectionView == motivatorsCollView {
            return self.coachListDataArr.count < 5 ? self.coachListDataArr.count : 5
        }
        else if collectionView == mealBatchCollView {
            return self.mealListData.count < 5 ? self.mealListData.count : 5
        }
        else if collectionView == topRatedMealCollView {
            return self.topRatedMealListData.count < 5 ? self.topRatedMealListData.count : 5
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == woBatchCollView {
            let cell = collectionView.dequeue(BWOBatchesListCollCell.self, indexPath)
            
            let info = courseListDataArr[indexPath.item]
            let fileUrl = URL(string: BaseUrl.imageBaseUrl + (info.courseImage ?? ""))
            cell.imgCourse.sd_setImage(with: fileUrl , placeholderImage:UIImage(named: "Image"))
            
            let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info.coachDetail?.profilePhotoPath ?? ""))
            cell.coachProfileImg.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
            
            cell.lblTitle.text = info.courseName
            cell.woDayCountLbl.text = BatchConstant.fromPrefix + " \(CURRENCY) " + (info.coursePrice?.removeDecimalValue() ?? "")

            cell.courseLevelTypeLbl.setTitle("\(info.courseLevel?.levelName ?? "")", for: .normal)
            cell.workOutTypeBtn.setTitle("\(info.workoutType?[0].workoutdetail?.workoutType ?? "")", for: .normal)
            cell.coachNameLbl.text = info.coachDetail?.name ?? ""
            
//            if UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.APP_LANGUAGE_CODE) as? String  == ARABIC_LANGUAGE_CODE {
//                cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
//            }
            return cell
        }
        else if collectionView == motivatorsCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BWOMotivatorsListCollCell", for: indexPath)  as! BWOMotivatorsListCollCell
            let data = coachListDataArr[indexPath.item]
            
            cell.typeLbl.text = ""
            var workOutType: [String] = []
            for i in 0..<(data.workoutType?.count ?? 0) {
                let type = data.workoutType?[i].workoutdetail?.workoutType ?? ""
                workOutType.append(type)
                if data.workoutType?.count == 1 {
                    cell.typeLbl.text = workOutType.joined(separator: ", ")
                }
                else if (data.workoutType?.count == 2) {
                    cell.typeLbl.text = workOutType.joined(separator: ", ")
                }
            }
            
            cell.nameLbl.text = data.name ?? ""
            let fileUrl = URL(string: BaseUrl.imageBaseUrl + (data.profilePhotoPath ?? ""))
            cell.imageMotivatorUser.cornerRadius = 75
            cell.imageMotivatorUser.sd_setImage(with: fileUrl , placeholderImage:UIImage(named: "Avatar2" ) )
            
//            if UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.APP_LANGUAGE_CODE) as? String  == ARABIC_LANGUAGE_CODE {
//                cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
//            }
            return cell
        }
        else if collectionView == mealBatchCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealPlanCollectionCell", for: indexPath)  as! MealPlanCollectionCell
            cell.titleLbl.text = self.mealListData[indexPath.row].name
            cell.priceLbl.text = BatchConstant.fromPrefix + " \(CURRENCY) " + "\(self.mealListData[indexPath.row].price?.removeDecimalValue() ?? "")"
            cell.kclLbl.text = "\(self.mealListData[indexPath.row].avgCalPerDay?.removeDecimalValue() ?? "0") " + BatchConstant.kcalSuffix
            cell.mealsLbl.text = "\(self.mealListData[indexPath.row].mealCount ?? 0) " + BatchConstant.meals
            let fileUrl = URL(string: BaseUrl.imageBaseUrl + (self.mealListData[indexPath.row].image ?? ""))
            cell.backGroundImage.sd_setImage(with: fileUrl , placeholderImage:UIImage(named: "Meal"))

//            if UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.APP_LANGUAGE_CODE) as? String  == ARABIC_LANGUAGE_CODE {
//                cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
//            }
            return cell
        }
        else if collectionView == topRatedMealCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealPlanCollectionCell", for: indexPath)  as! MealPlanCollectionCell
            cell.titleLbl.text = self.topRatedMealListData[indexPath.row].name
            cell.priceLbl.text = BatchConstant.fromPrefix + " \(CURRENCY) " + "\(self.topRatedMealListData[indexPath.row].price?.removeDecimalValue() ?? "")"
            cell.kclLbl.text = "\(self.topRatedMealListData[indexPath.row].avgCalPerDay?.removeDecimalValue() ?? "0") " + BatchConstant.kcalSuffix
            cell.mealsLbl.text = "\(self.topRatedMealListData[indexPath.row].mealCount ?? 0) " + BatchConstant.meals
            let fileUrl = URL(string: BaseUrl.imageBaseUrl + (self.topRatedMealListData[indexPath.row].image ?? ""))
            cell.backGroundImage.sd_setImage(with: fileUrl , placeholderImage:UIImage(named: "Meal"))

//            if UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.APP_LANGUAGE_CODE) as? String  == ARABIC_LANGUAGE_CODE {
//                cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
//            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == woBatchCollView {
            let vc = BWorkOutDetailVC.instantiate(fromAppStoryboard: .batchTrainings)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            let info = courseListDataArr[indexPath.item]
            vc.woDetailInfo = [info]
            vc.isCommingFrom = "workoutbatches"

//            vc.newArray.append("\(String(describing: info.duration ?? "" )) min")
//            vc.newImage.append(UIImage(named: "clock-circle-black")!)
            vc.newArray.append("\(String(describing: info.courseLevel?.levelName ?? "" ))")
            vc.newImage.append(UIImage(named: "barchart-black")!)

            if info.workoutType?.count != 0 {
                for i in 0..<info.workoutType!.count {
                    vc.newArray.append("\(info.workoutType?[i].workoutdetail?.workoutType ?? "" )")
                    vc.newImage.append(UIImage(named: "accessibility_Black")!)
                }
            }

            self.present(vc, animated: true)
        }
        else if collectionView == motivatorsCollView {
            let vc = BWorkOutMotivatorDetailVC.instantiate(fromAppStoryboard: .batchTrainings)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            vc.woCoachDetailInfo = [self.coachListDataArr[indexPath.item]]
            // vc.isCommingFrom = "motivtors"
            self.present(vc, animated: true)
        } else if collectionView == mealBatchCollView {
            let vc = MealBatchUnSubscribeDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            vc.mealData = self.mealListData[indexPath.item]
            self.present(vc, animated: true)
        } else if collectionView == topRatedMealCollView {
            let vc = MealBatchUnSubscribeDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            vc.mealData = self.topRatedMealListData[indexPath.item]
            self.present(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //        if (collectionView.tag == 1501)
        //        {
        //            pageControl.currentPage = indexPath.item
        //
        //             let indexValue = indexPath.item //Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        //             pageControl?.currentPage = indexValue
        //        }
    }
    
    /*
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
     */
}

extension BatchBoardHomeVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize              = collectionView.frame.size //UIScreen.main.bounds
        //        let screenSize              = UIScreen.main.bounds
        let screenWidth             = screenSize.width
        let cellSquareSize: CGFloat = screenWidth - 60
        
        if collectionView == woBatchCollView {
            return CGSize.init(width: cellSquareSize, height: 240)
        }
        else if collectionView == motivatorsCollView {
            return CGSize.init(width: (cellSquareSize / 2) - 20, height: 220)
        }
        else if collectionView == mealBatchCollView {
            return CGSize.init(width: cellSquareSize, height: 240)
        }
        else if collectionView == topRatedMealCollView {
            return CGSize.init(width: cellSquareSize, height: 240)
        }
        else {
            return CGSize.init(width: cellSquareSize, height: 120)
        }
    }
    
    @objc(collectionView:layout:insetForSectionAtIndex:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: CGFloat(), right: 0)
    }
    
    @objc(collectionView:layout:minimumLineSpacingForSectionAtIndex:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 5
    }
    
    @objc(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 5
    }
}

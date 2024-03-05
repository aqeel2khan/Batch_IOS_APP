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
        if collectionView == pageControllCollView {
            return self.imgArr.count
        }
        else if collectionView == woBatchCollView {
            return self.courseListDataArr.count < 5 ? self.courseListDataArr.count : 5
        }
        else if collectionView == motivatorsCollView {
            return self.coachListDataArr.count < 5 ? self.coachListDataArr.count : 5
        }
        else if collectionView == mealBatchCollView {
            return self.mealListData.count < 5 ? self.mealListData.count : 5
        }
        else if collectionView == topRatedMealCollView {
            return self.mealListData.count < 5 ? self.mealListData.count : 5
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == pageControllCollView {
            let cell = collectionView.dequeue(BatchHomePageContCollViewCell.self, indexPath)
            cell.pageControllImgView.image = UIImage(named: self.imgArr[indexPath.item])
            return cell
        }
        else if collectionView == woBatchCollView {
            let cell = collectionView.dequeue(BWOBatchesListCollCell.self, indexPath)
            
            let info = courseListDataArr[indexPath.item]
            let fileUrl = URL(string: BaseUrl.imageBaseUrl + (info.courseImage ?? ""))
            cell.imgCourse.sd_setImage(with: fileUrl , placeholderImage:UIImage(named: "Image"))
            
            let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info.coachDetail?.profilePhotoPath ?? ""))
            cell.coachProfileImg.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
            
            cell.lblTitle.text = info.courseName
            cell.woDayCountLbl.text = "\(info.coursePrice ?? "")"
            cell.courseLevelTypeLbl.setTitle("\(info.courseLevel?.levelName ?? "")", for: .normal)
            cell.workOutTypeBtn.setTitle("\(info.workoutType?[0].workoutdetail?.workoutType ?? "")", for: .normal)
            cell.coachNameLbl.text = info.coachDetail?.name ?? ""
            return cell
        }
        else if collectionView == motivatorsCollView {
            let cell = collectionView.dequeue(BWOMotivatorsListCollCell.self, indexPath)
            let data = coachListDataArr[indexPath.item]
            cell.typeLbl.text = data.website ?? ""
            cell.nameLbl.text = data.name ?? ""
            let fileUrl = URL(string: BaseUrl.imageBaseUrl + (data.profilePhotoPath ?? ""))
            cell.imageMotivatorUser.cornerRadius = 75
            cell.imageMotivatorUser.sd_setImage(with: fileUrl , placeholderImage:UIImage(named: "Avatar2" ) )
        }
        else if collectionView == mealBatchCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealPlanCollectionCell", for: indexPath)  as! MealPlanCollectionCell
            cell.titleLbl.text = self.mealListData[indexPath.row].name
            cell.priceLbl.text = "from $\(self.mealListData[indexPath.row].price ?? "")"
            cell.kclLbl.text = "\(self.mealListData[indexPath.row].avgCalPerDay ?? "") kcal"
            cell.mealsLbl.text = "\(self.mealListData[indexPath.row].mealCount ?? 0) meals"
            return cell
        }
        else if collectionView == topRatedMealCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealPlanCollectionCell", for: indexPath)  as! MealPlanCollectionCell
            cell.titleLbl.text = self.mealListData[indexPath.row].name
            cell.priceLbl.text = "from $\(self.mealListData[indexPath.row].price ?? "")"
            cell.kclLbl.text = "\(self.mealListData[indexPath.row].avgCalPerDay ?? "") kcal"
            cell.mealsLbl.text = "\(self.mealListData[indexPath.row].mealCount ?? 0) meals"
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
         let vc = BWorkOutMotivatorDetailVC.instantiate(fromAppStoryboard: .batchTrainings)
         vc.modalPresentationStyle = .overFullScreen
         vc.modalTransitionStyle = .coverVertical
         self.present(vc, animated: true)
         */
        
        if collectionView == mealBatchCollView {
            let vc = MealBatchUnSubscribeDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            vc.mealData = self.mealListData[indexPath.item]
            self.present(vc, animated: true)
        } else if collectionView == topRatedMealCollView {
            let vc = MealBatchUnSubscribeDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            vc.mealData = self.mealListData[indexPath.item]
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView == pageControllCollView)
        {
            let width = scrollView.frame.width
            currentPage = Int(scrollView.contentOffset.x / width)
        }
    }
}

extension BatchBoardHomeVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize              = collectionView.frame.size //UIScreen.main.bounds
        //        let screenSize              = UIScreen.main.bounds
        let screenWidth             = screenSize.width
        let cellSquareSize: CGFloat = screenWidth
        
        if (collectionView.tag == 1501) {
            return CGSize.init(width: cellSquareSize , height: 260)
        }
        else if (collectionView.tag == 1502) {
            return CGSize.init(width: cellSquareSize, height: 240)
        }
        else if (collectionView.tag == 1503) {
            return CGSize.init(width: (cellSquareSize / 2) - 20, height: 220)
        }
        else if (collectionView.tag == 1504) {
            return CGSize.init(width: cellSquareSize, height: 260)
        }
        else if (collectionView.tag == 1505) {
            return CGSize.init(width: cellSquareSize, height: 260)
        }
        else {
            return CGSize.init(width: cellSquareSize, height: 120)
        }
    }
    
    @objc(collectionView:layout:insetForSectionAtIndex:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: CGFloat(), right: 0)
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
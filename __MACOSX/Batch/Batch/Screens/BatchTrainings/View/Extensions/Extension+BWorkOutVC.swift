//
//  Extension+BWorkOutVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 19/12/23.
//

import Foundation
import UIKit
import SDWebImage

extension BWorkOutVC : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.segmentControl.selectedSegmentIndex == 0)
        {
            return self.courseListDataArr.count//courseListData.count
        }
        else
        {
            return self.coachListDataArr.count
            //motivatorListData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (self.segmentControl.selectedSegmentIndex == 0)
        {
            let cell = collectionView.dequeue(BWOBatchesListCollCell.self, indexPath)
            
            let info = courseListDataArr[indexPath.item]
            
            let fileUrl = URL(string: BaseUrl.imageBaseUrl + (info.courseImage ?? ""))
            cell.imgCourse.sd_setImage(with: fileUrl , placeholderImage:UIImage(named: "Image"))
            
            let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info.coachDetail?.profilePhotoPath ?? ""))
            cell.coachProfileImg.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
            
            cell.lblTitle.text = info.courseName
            //            cell.woDayCountLbl.text = "\(info.perDayWorkout ?? "0")/\(info.duration ?? "0") days"
            cell.woDayCountLbl.text = "\(info.coursePrice ?? "")"
            cell.courseLevelTypeLbl.setTitle("\(info.courseLevel?.levelName ?? "")", for: .normal)
            let workType = info.workoutType?[0].workoutdetail?.workoutType
            
            cell.workOutTypeBtn.setTitle("\(workType ?? "")", for: .normal)
            
            cell.coachNameLbl.text = info.coachDetail?.name ?? ""
            
            //            cell.goalLblBtn.setTitle("\(info.duration ?? "")", for: .normal)
            
            return cell
        }
        else
        {
            let cell = collectionView.dequeue(BWOMotivatorsListCollCell.self, indexPath)
            let data = coachListDataArr[indexPath.item]
            cell.typeLbl.text = data.website ?? ""
            cell.nameLbl.text = data.name ?? ""
            let fileUrl = URL(string: BaseUrl.imageBaseUrl + (data.profilePhotoPath ?? ""))
            cell.imageMotivatorUser.cornerRadius = 75
            cell.imageMotivatorUser.sd_setImage(with: fileUrl , placeholderImage:UIImage(named: "Avatar2" ) )
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (self.segmentControl.selectedSegmentIndex == 0)
        {
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
                let workOutType = info.workoutType?.count
                
                for i in 0..<info.workoutType!.count {
                    print(info.workoutType?[i].workoutdetail?.workoutType)
                    
                    vc.newArray.append("\(info.workoutType?[i].workoutdetail?.workoutType ?? "" )")
                    vc.newImage.append(UIImage(named: "accessibility_Black")!)
                    
                }
            }
            
            self.present(vc, animated: true)
        }
        else
        {
            let vc = BWorkOutMotivatorDetailVC.instantiate(fromAppStoryboard: .batchTrainings)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            vc.woCoachDetailInfo = [self.coachListDataArr[indexPath.item]]
            // vc.isCommingFrom = "motivtors"
            
            
            self.present(vc, animated: true)
        }
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
    
}

extension BWorkOutVC : UICollectionViewDelegateFlowLayout
{
    @objc(collectionView:layout:sizeForItemAtIndexPath:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let screenSize              = collectionView.frame.size //UIScreen.main.bounds
        let screenWidth             = screenSize.width
        let cellSquareSize: CGFloat = screenWidth
        if (self.segmentControl.selectedSegmentIndex == 0)
        {
            return CGSize.init(width: cellSquareSize, height: 220)//300
        }
        else
        {
            return CGSize.init(width: cellSquareSize/2 - 20, height: 220) //250
        }
    }
    
    @objc(collectionView:layout:insetForSectionAtIndex:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
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

extension BWorkOutVC:  UITextFieldDelegate
{
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // This method will be called whenever the text in the text field changes
        // You can use the updated text to perform your custom search
        
        // Combine the existing text with the replacement string
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        let query = newText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        workItemReference?.cancel()
        let querySearchWorkItem = DispatchWorkItem
        {
            // Example: Call your API function to perform a search
            self.performSearch(query: query)
        }
        workItemReference = querySearchWorkItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: querySearchWorkItem)
        
        return true
    }
    
}

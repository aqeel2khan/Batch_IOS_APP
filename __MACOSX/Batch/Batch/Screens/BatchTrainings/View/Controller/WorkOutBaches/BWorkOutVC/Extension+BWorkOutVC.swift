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
        if (self.segmentControl.selectedSegmentIndex == 0) {
            return self.courseListDataArr.count
        }
        else {
            if woSearchTextField.text == "" {
                if self.coachListDataArr.count > 0 {
                    return self.coachListDataArr.count
                }
            } else {
                if self.searchedCoachListDataArr.count > 0 {
                    return self.searchedCoachListDataArr.count
                }
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (self.segmentControl.selectedSegmentIndex == 0) {
            let cell = collectionView.dequeue(BWOBatchesListCollCell.self, indexPath)
            let info = courseListDataArr[indexPath.item]
            
            let fileUrl = URL(string: BaseUrl.imageBaseUrl + (info.courseImage ?? ""))
            cell.imgCourse.sd_setImage(with: fileUrl , placeholderImage:UIImage(named: "Image"))
            
            let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info.coachDetail?.profilePhotoPath ?? ""))
            cell.coachProfileImg.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
            
            cell.lblTitle.text = info.courseName
            
            let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(info.coursePrice?.removeDecimalValue() ?? "")", prefixFont: UIFont(name:"Outfit-Medium",size:12)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
            cell.woDayCountLbl.attributedText = attributedPriceString
            
            cell.courseLevelTypeLbl.setTitle("\(info.courseLevel?.levelName ?? "")", for: .normal)
            let workType = info.workoutType?[0].workoutdetail?.workoutType
            cell.workOutTypeBtn.setTitle("\(workType ?? "")", for: .normal)
            cell.coachNameLbl.text = info.coachDetail?.name ?? ""
            
            return cell
        }
        else  {
            let cell = collectionView.dequeue(BWOMotivatorsListCollCell.self, indexPath)
            var data : CoachListData!

            if woSearchTextField.text == "" && coachListDataArr.count > 0 {
                data = coachListDataArr[indexPath.item]
            } else if woSearchTextField.text != "" && searchedCoachListDataArr.count > 0  {
                data = searchedCoachListDataArr[indexPath.item]
            }

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
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (self.segmentControl.selectedSegmentIndex == 0) {
            let vc = BWorkOutDetailVC.instantiate(fromAppStoryboard: .batchTrainings)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            let info = courseListDataArr[indexPath.item]
            vc.woDetailInfo = [info]
            vc.isCommingFrom = "workoutbatches"
            
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
        else {
            let vc = BWorkOutMotivatorDetailVC.instantiate(fromAppStoryboard: .batchTrainings)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            if woSearchTextField.text == "" {
                vc.woCoachDetailInfo = [self.coachListDataArr[indexPath.item]]
            } else {
                vc.woCoachDetailInfo = [self.searchedCoachListDataArr[indexPath.item]]
            }
            vc.woCoachDetailInfo = [self.coachListDataArr[indexPath.item]]
            self.present(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if segmentControl.selectedSegmentIndex == 0 && !isWorkoutLoaded {
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
            UIView.animate(
                withDuration: 0.5,
                delay: 0.05 * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                })
        } else if segmentControl.selectedSegmentIndex == 1 && !isMotivatorLoaded {
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if segmentControl.selectedSegmentIndex == 0 {
            isWorkoutLoaded = true
        } else {
            isMotivatorLoaded = true
        }
    }
}

extension BWorkOutVC : UICollectionViewDelegateFlowLayout {
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

//extension BWorkOutVC:  UITextFieldDelegate
//{
//    // MARK: - UITextFieldDelegate
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // This method will be called whenever the text in the text field changes
//        // You can use the updated text to perform your custom search
//
//        // Combine the existing text with the replacement string
//        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
//        let query = newText.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        workItemReference?.cancel()
//        let querySearchWorkItem = DispatchWorkItem
//        {
//            // Example: Call your API function to perform a search
//            self.performSearch(query: query)
//        }
//        workItemReference = querySearchWorkItem
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: querySearchWorkItem)
//
//        return true
//    }
//
//}


extension BWorkOutVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == woSearchTextField {
            
            let placeTextFieldStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
            
            if placeTextFieldStr != "" {
                woMotivatorBackView.layer.borderWidth = 1
                woMotivatorBackView.layer.borderColor = Colors.appThemeButtonColor.cgColor
                woMotivatorBackView.backgroundColor = .clear
            } else {
                woMotivatorBackView.layer.borderWidth = 0
                woMotivatorBackView.layer.borderColor = UIColor.clear.cgColor
                woMotivatorBackView.backgroundColor = Colors.appViewBackgroundColor
            }
            
            timer?.invalidate()
            timer = Timer.scheduledTimer(
                timeInterval: 0.5,
                target: self,
                selector: #selector(getHints),
                userInfo: placeTextFieldStr,
                repeats: false)
        }
        return true
    }
    
    @objc func getHints(timer: Timer) {
            let userInfo = timer.userInfo as! String
        self.searchedCoachListDataArr = self.coachListDataArr.filter{ $0.name!.lowercased().contains(userInfo.lowercased()) }

            self.batchesMotivatorCollView.reloadData()
    }
}

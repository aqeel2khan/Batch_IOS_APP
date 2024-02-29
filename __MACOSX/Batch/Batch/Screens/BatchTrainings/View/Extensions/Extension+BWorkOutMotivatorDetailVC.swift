//
//  Extension+BStartWorkOutDetailVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 22/01/24.
//

import Foundation
import UIKit

//MARK:- Tableview func

extension BWorkOutMotivatorDetailVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.motivatorCourseArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(BWOPackageTblCell.self,for: indexPath)
        cell.cellBtn.tag = indexPath.row
        
        cell.cellBtn.addTarget(self, action: #selector(cellBtnClicked(sender:)), for: UIControl.Event.touchUpInside)
        
        let info = motivatorCourseArr[indexPath.item]
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
        
        return cell
    }
    
    @objc func cellBtnClicked(sender:UIButton) {
        let vc = BWorkOutDetailVC.instantiate(fromAppStoryboard: .batchTrainings)
        vc.isCommingFrom = "MotivatorDetailVC"
        vc.woMotivatorInfo = self.motivatorCourseArr[sender.tag]
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220 //UITableView.automaticDimension //1300//
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        /*
         let vc = BWorkOutDetailVC.instantiate(fromAppStoryboard: .batchTrainings)
         vc.isCommingFrom = "MotivatorDetailVC"
         vc.modalPresentationStyle = .overFullScreen
         vc.modalTransitionStyle = .coverVertical
         self.present(vc, animated: true)
         */
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

extension BWorkOutMotivatorDetailVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.tag == 701) {
            return newArray.count //workOutArray.count
        }
        else {
            return 0//recomProductArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView.tag == 701) {
            let cell = collectionView.dequeue(BatchTrainingDetailCollCell.self, indexPath)
            //            cell.imgWorkOut.image = workOutIconArray[indexPath.row]
            //            cell.lblWorkoutName.text = workOutArray[indexPath.row]
            
            cell.imgWorkOut.image = newImage[indexPath.row]
            cell.lblWorkoutName.text = newArray[indexPath.row]
            return cell
        }
        else {
            let cell = collectionView.dequeue(BWOMotivatorsReProductCollCell.self, indexPath)
            //cell.backgroundProductImgView.image = recomProductArr[indexPath.item]
            return cell
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

extension BWorkOutMotivatorDetailVC : UICollectionViewDelegateFlowLayout {
    @objc(collectionView:layout:sizeForItemAtIndexPath:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize              = collectionView.frame.size //UIScreen.main.bounds
        let screenWidth             = screenSize.width
        let cellSquareSize: CGFloat = screenWidth
        if (collectionView.tag == 702)
        {
            return CGSize.init(width: cellSquareSize/2, height: 250)
        }
        else
        {
            return CGSize.init(width: cellSquareSize, height: 40)
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

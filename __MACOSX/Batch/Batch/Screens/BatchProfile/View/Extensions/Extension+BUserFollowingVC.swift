//
//  Extension+BStartWorkOutDetailVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 22/01/24.
//

import Foundation
import UIKit
//MARK:- Tableview func

extension BUserFollowingVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followingData?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(FollowingListTableCell.self,for: indexPath)
        cell.unfollowBtn.tag = indexPath.row
        cell.lblName.text = followingData?.data?[indexPath.row].motivator_detail?.name ?? ""
        cell.lblDetails.text = followingData?.data?[indexPath.row].motivator_detail?.email ?? ""
        if followingData?.data?[indexPath.row].motivator_detail?.profile_photo_path != nil{
            cell.followingprofileImage.sd_setImage(with: URL(string: BaseUrl.imageBaseUrl + (followingData?.data?[indexPath.row].motivator_detail?.profile_photo_path ?? ""))!, placeholderImage: UIImage(named: "image2"))
        }else{
            cell.followingprofileImage.image = UIImage(named: "image2")
        }
        
        cell.callBackTOUnfollow = { tag in
            self.unfollowCoach(coachId: self.followingData?.data?[indexPath.row].coach_id ?? 0)
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
        let vc = BWorkOutMotivatorDetailVC.instantiate(fromAppStoryboard: .batchTrainings)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.isCommingFrom = "FreshCall"
        vc.coachIdStr = "\(followingData?.data?[indexPath.row].motivator_detail?.id ?? 0)"
        self.present(vc, animated: true)
    }
    
}

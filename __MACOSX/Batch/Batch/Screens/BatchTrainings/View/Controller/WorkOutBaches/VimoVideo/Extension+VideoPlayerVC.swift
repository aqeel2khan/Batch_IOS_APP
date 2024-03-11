//
//  Extension+VideoPlayerVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 15/02/24.
//

import Foundation
import UIKit

extension VideoPlayerVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tblIconArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(VideoThunbListTblCell.self,for: indexPath)
        cell.videoThunbnailImgView.image = self.tblIconArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100//UITableView.automaticDimension //1300//
    }


    
}

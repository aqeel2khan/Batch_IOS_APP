//
//  BUserFollowingVC.swift
//  Batch
//
//  Created by Hari Mohan on 19/02/24.
//

import Foundation
import UIKit

class BNotificationListVC: UIViewController {
    @IBOutlet weak var notificationListTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView()
        
        notificationListTableView.reloadData()
    }
    
    func registerTableView() {
        notificationListTableView.register(UINib(nibName: "NotificationListTableCell", bundle: .main), forCellReuseIdentifier: "NotificationListTableCell")
    }
    
    @IBAction func onTapBackBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

extension BNotificationListVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationListTableCell") as? NotificationListTableCell ?? UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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

    
}

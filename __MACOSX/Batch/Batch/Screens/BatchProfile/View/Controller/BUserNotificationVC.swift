//
//  BUserFollowingVC.swift
//  Batch
//
//  Created by Hari Mohan on 19/02/24.
//

import Foundation
import UIKit

class BUserNotificationVC: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var notificationListTableView: UITableView!
    let notificationList = ["All notifications","Training notifications","Live stream notifications", "Meal plan notificatins", "Delivery notifications"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView()
        
        notificationListTableView.reloadData()
        
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    func registerTableView() {
        notificationListTableView.register(UINib(nibName: "NotificationSettingsListTableCell", bundle: .main), forCellReuseIdentifier: "NotificationSettingsListTableCell")
    }
    
    @IBAction func onTapBackBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

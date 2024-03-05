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
    
    var notificationPrefrences : GetNotificationPrefrencesResponse?{
        didSet{
            DispatchQueue.main.async{
                self.notificationListTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView()
        
        notificationListTableView.reloadData()
        getNotificationPrefrences()
        
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    func getNotificationPrefrences(){
        let bUserNotificationVM = BUserNotificationVM()
        DispatchQueue.main.async {
            showLoading()
        }
        bUserNotificationVM.getNotificationPrefrences { response in
            DispatchQueue.main.async {
                hideLoading()
                self.notificationPrefrences = response
            }
            
        } onError: { error in
            DispatchQueue.main.async {
                hideLoading()
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
   
    
    func registerTableView() {
        notificationListTableView.register(UINib(nibName: "NotificationSettingsListTableCell", bundle: .main), forCellReuseIdentifier: "NotificationSettingsListTableCell")
    }
    
    @IBAction func onTapBackBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

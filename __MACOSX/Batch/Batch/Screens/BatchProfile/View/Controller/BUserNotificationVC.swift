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
    let notificationList = ["All notifications","Training notifications","Live stream notifications", "Meal plan notifications", "Delivery notifications"]
    
    var notificaionPrefrenceList: [String : Int] = [:]
    var isChanged = false
    
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
        if internetConnection.isConnectedToNetwork() == true {
            let bUserNotificationVM = BUserNotificationVM()
            DispatchQueue.main.async {
                showLoading()
            }
            bUserNotificationVM.getNotificationPrefrences { response in
                DispatchQueue.main.async {
                    hideLoading()
                    self.notificationPrefrences = response
                    self.notificationList.forEach { data in
                        switch data{
                        case "All notifications":
                            self.notificaionPrefrenceList[data] = response.data?.all ?? 0
                        case "Training notifications":
                            self.notificaionPrefrenceList[data] = response.data?.training ?? 0
                        case "Live stream notifications":
                            self.notificaionPrefrenceList[data] = response.data?.live_stream ?? 0
                        case "Meal plan notificatins":
                            self.notificaionPrefrenceList[data] = response.data?.meal_plan ?? 0
                        case "Delivery notifications":
                            self.notificaionPrefrenceList[data] = response.data?.delivery ?? 0
                        default:
                            self.notificaionPrefrenceList[data] = 0
                        }
                        
                    }
                }
                
            } onError: { error in
                DispatchQueue.main.async {
                    hideLoading()
                    self.showAlert(message: error.localizedDescription)
                }
            }
        } else{
                self.showAlert(message: "Please check your internet", title: "Network issue")
            }
    }
   
    
    func registerTableView() {
        notificationListTableView.register(UINib(nibName: "NotificationSettingsListTableCell", bundle: .main), forCellReuseIdentifier: "NotificationSettingsListTableCell")
    }
    
    @IBAction func onTapBackBtn(_ sender: UIButton) {
        updateNotificationInfo()
    }
    
    func updateNotificationInfo(){
        var request = UpdateNotificationRequest()
        for (key, value) in self.notificaionPrefrenceList{
            if key == "All notifications" && value == 1{
                request.all = 1
            }else if key == "Training notifications" && value == 1{
                request.training = 1
            }else if key == "Live stream notifications" && value == 1{
                request.live_stream = 1
            }else if key == "Meal plan notificatins" && value == 1{
                request.meal_plan = 1
            }else if key == "Delivery notifications" && value == 1{
                request.delivery = 1
            }
        }
        if internetConnection.isConnectedToNetwork() == true {
        let bUserNotificationInfoVM = BUserNotificationVM()
        DispatchQueue.main.async {
            showLoading()
        }
        bUserNotificationInfoVM.updateNotificationInfo(request: request) { response in
            DispatchQueue.main.async {
                hideLoading()
                self.showAlertViewWithOne(title: "Batch", message: response.message ?? "", option1: "Ok") {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        } onError: { error in
            DispatchQueue.main.async {
                hideLoading()
                self.showAlert(message: error.localizedDescription)
            }
        }
    }else{
        self.showAlert(message: "Please check your internet", title: "Network issue")
    }
    }
}

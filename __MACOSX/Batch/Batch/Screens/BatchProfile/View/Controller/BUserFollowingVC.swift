//
//  BUserFollowingVC.swift
//  Batch
//
//  Created by Hari Mohan on 19/02/24.
//

import Foundation
import UIKit

class BUserFollowingVC: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var followingListTableView: UITableView!
    
    var followingData: GetFollowingResponse?{
        didSet{
            DispatchQueue.main.async{
                self.followingListTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView()
        
        followingListTableView.reloadData()
        getUserFollowingData()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    func unfollowCoach(coachId: Int){
        if internetConnection.isConnectedToNetwork(){
            let urlString = API.motivatorUnfollow + "\(coachId)"
            let bUserFollowingData = BUserFollowingVM()
            DispatchQueue.main.async {
                showLoading()
            }
            bUserFollowingData.followUnfollowApi(requestUrl: urlString) { response in
                DispatchQueue.main.async {
                    hideLoading()
                    self.showAlertViewWithOne(title: "Batch", message: response.message ?? "", option1: "Ok") {
                        self.getUserFollowingData()
                    }
                }
            } onError: { err in
                DispatchQueue.main.async {
                    hideLoading()
                    self.showAlert(message: err.localizedDescription)
                }
            }

        }else{
            self.showAlert(message: "Please check your internet", title: "Network issue")
        }
    }
    
    func getUserFollowingData(){
        if internetConnection.isConnectedToNetwork() == true {
        let bUserFollowingData = BUserFollowingVM()
        DispatchQueue.main.async {
            showLoading()
        }
        bUserFollowingData.getFolowingDetails { response in
            DispatchQueue.main.async {
                hideLoading()
                if response.data?.count ?? 0 > 0{
                    self.followingData = response
                }else{
                    self.showAlertViewWithOne(title: "Batch", message: "No Following records found", option1: "Ok") {
                        self.dismiss(animated: true, completion: nil)
                    }
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
    
    func registerTableView() {
        followingListTableView.register(UINib(nibName: "FollowingListTableCell", bundle: .main), forCellReuseIdentifier: "FollowingListTableCell")
    }
    
    @IBAction func onTapBackBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

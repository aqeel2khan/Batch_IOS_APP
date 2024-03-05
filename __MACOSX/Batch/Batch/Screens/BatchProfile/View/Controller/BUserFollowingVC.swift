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
    
    func getUserFollowingData(){
        let bUserFollowingData = BUserFollowingVM()
        DispatchQueue.main.async {
            showLoading()
        }
        bUserFollowingData.getFolowingDetails { response in
            DispatchQueue.main.async {
                hideLoading()
                self.followingData = response
            }
            
        } onError: { error in
            DispatchQueue.main.async {
                hideLoading()
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func registerTableView() {
        followingListTableView.register(UINib(nibName: "FollowingListTableCell", bundle: .main), forCellReuseIdentifier: "FollowingListTableCell")
    }
    
    @IBAction func onTapBackBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

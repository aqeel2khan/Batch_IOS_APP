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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView()
        
        followingListTableView.reloadData()
        
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    func registerTableView() {
        followingListTableView.register(UINib(nibName: "FollowingListTableCell", bundle: .main), forCellReuseIdentifier: "FollowingListTableCell")
    }
    
    @IBAction func onTapBackBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

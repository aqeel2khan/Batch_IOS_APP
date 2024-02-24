//
//  MealBatchVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//

import UIKit

class BatchDashboardVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    @IBOutlet weak var mealBatchCollView: UICollectionView!
    @IBOutlet weak var workoutBatchCollView: UICollectionView!
    //var courseList = [List]()
    var courseList = [DashboardWOList]()


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.courseList.removeAll()
        if internetConnection.isConnectedToNetwork() == true {
            // Call Api here
            self.getSubscribedCourseList()
        }
        else
        {
            self.showAlert(message: "Please check your internet", title: "Network issue")
        }
    }
    
    private func setupNavigationBar() {
        customNavigationBar.titleFirstLbl.text = CustomNavTitle.dashboardVCNavTitle
        self.registerCollTblView()
    }
    
    private func registerCollTblView(){
        
        mealBatchCollView.register(UINib(nibName: "MealBatchDashboardCollectionCell", bundle: .main), forCellWithReuseIdentifier: "MealBatchDashboardCollectionCell")
        workoutBatchCollView.register(UINib(nibName: "WorkoutBatchDashboardCollectionCell", bundle: .main), forCellWithReuseIdentifier: "WorkoutBatchDashboardCollectionCell")
    }
    
    private func getSubscribedCourseList(){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let dashboardViewModel = DashboardViewModel()
        let urlStr = API.courseSubscribeList
        
        dashboardViewModel.allCourseSubscribeList(requestUrl: urlStr)  { (response) in
            
            if response.status == true, response.data?.list?.count != 0 {
                self.courseList = response.data?.list ?? []
                print(self.courseList)

                DispatchQueue.main.async {
                    hideLoading()
                    self.workoutBatchCollView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    //makeToast(response.message!)
                }
            }
            
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                // makeToast(error.localizedDescription)
            }
        }
    }
}

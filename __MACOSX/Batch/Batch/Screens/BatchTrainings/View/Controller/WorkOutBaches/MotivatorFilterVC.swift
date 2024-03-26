//
//  BWorkOutDetailVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 17/12/23.
//
/*
 @IBOutlet weak var CollectionViewLayout: UICollectionViewFlowLayout!{
 
 }
 */

import UIKit

class MotivatorFilterVC: UIViewController {
    var isAlreadyAnimated : Bool = false
    var completion: (([Int], [Int])->Void)? = nil

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var workOutCollectionView: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionHeight2: NSLayoutConstraint!
    
    var workOutArray = [Workouttype]()
    var experienceArray = [Experience]()
  
    var selectedWorkOut : [Int] = []
    var selectedExperience : [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        
        let leftLayout = leftSideDataInColl()
        leftLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        workOutCollectionView.collectionViewLayout = leftLayout
        
        let centerLayout = UICollectionViewCenterLayout()
        centerLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView2.collectionViewLayout = centerLayout
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"
        {
            if let newValue = change?[.newKey]
            {
                let newsize = newValue as! CGSize
                self.collectionHeight.constant = newsize.height
                self.collectionHeight2.constant = newsize.height
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update height constraint
        
        self.collectionHeight.constant = self.workOutCollectionView.collectionViewLayout.collectionViewContentSize.height
        workOutCollectionView.reloadData()
        
        self.collectionHeight2.constant = self.collectionView2.collectionViewLayout.collectionViewContentSize.height
        collectionView2.reloadData()
    }
    
    
    func setUpCollectionView(){
        
        workOutCollectionView.register(UINib(nibName: "TrainingFilterCollectionCell", bundle: .main), forCellWithReuseIdentifier: "TrainingFilterCollectionCell")
        
        collectionView2.register(UINib(nibName: "TrainingFilterCollectionCell", bundle: .main), forCellWithReuseIdentifier: "TrainingFilterCollectionCell")
    }
    
    //MARK: back Action Btn
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func applyBtnTap(_ sender: UIButton) {        
        print(selectedWorkOut)
        print(selectedExperience)
   
        self.dismiss(animated: true)
        completion?(selectedWorkOut, selectedExperience)
    }
    
}

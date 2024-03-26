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

class TrainingFilterVC: UIViewController {
    var isAlreadyAnimated : Bool = false
    var completion: (([Int], [Int], [Int]) ->Void)? = nil
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var lblTitleGoal: UILabel!
    @IBOutlet weak var lblTitleLevel: UILabel!
    @IBOutlet weak var lblTitleFilter: UILabel!
    @IBOutlet weak var lblTitleWorkOut: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionHeight2: NSLayoutConstraint!
    @IBOutlet weak var rightTagCollView: UICollectionView!
    @IBOutlet weak var rightTagCollHeight: NSLayoutConstraint!
    
    var workOutArray = [AllWorkoutTypeList]()
    var levelArray   = [AllBatchLevelList]()
    var goalArray    = [AllBatchGoalList]()
    
    var selectedWorkOut : [Int] = []
    var selectedLevel : [Int] = []
    var selectedGoal : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        
        let leftLayout = leftSideDataInColl()
        leftLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView.collectionViewLayout = leftLayout
        
        let centerLayout = UICollectionViewCenterLayout()
        centerLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView2.collectionViewLayout = centerLayout
        
        let rightSideLayout = leftSideDataInColl()
        rightSideLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        rightTagCollView.collectionViewLayout = rightSideLayout
        
        //        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        //        mainView.addGestureRecognizer(tap)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"
        {
            if let newValue = change?[.newKey]
            {
                let newsize = newValue as! CGSize
                self.collectionHeight.constant = newsize.height
                self.collectionHeight2.constant = newsize.height
                self.rightTagCollHeight.constant = newsize.height
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update height constraint
        
        self.collectionHeight.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionView.reloadData()
        
        self.collectionHeight2.constant = self.collectionView2.collectionViewLayout.collectionViewContentSize.height
        collectionView2.reloadData()
        
        self.rightTagCollHeight.constant = self.rightTagCollView.collectionViewLayout.collectionViewContentSize.height
        rightTagCollView.reloadData()
        
    }
    
    
    func setUpCollectionView(){
        
        collectionView.allowsSelection = true
        rightTagCollView.allowsSelection = true
        
        collectionView.register(UINib(nibName: "TrainingFilterCollectionCell", bundle: .main), forCellWithReuseIdentifier: "TrainingFilterCollectionCell")
        
        collectionView2.register(UINib(nibName: "TrainingFilterCollectionCell", bundle: .main), forCellWithReuseIdentifier: "TrainingFilterCollectionCell")
        
        rightTagCollView.register(UINib(nibName: "TrainingFilterCollectionCell", bundle: .main), forCellWithReuseIdentifier: "TrainingFilterCollectionCell")
    }
    
    //MARK: back Action Btn
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func applyBtnTap(_ sender: UIButton) {
        print(selectedWorkOut)
        print(selectedLevel)
        print(selectedGoal)
        
//        let workOutStrArray = selectedWorkOut.map{String($0)}
//        let commaSeparatedWorkOutStr = workOutStrArray.joined(separator: ",")
//        let levelStrArray = selectedLevel.map{String($0)}
//        let commaSeparatedLevelStr = levelStrArray.joined(separator: ",")
//        let goalStrArray = selectedGoal.map{String($0)}
//        let commaSeparatedGoalStr = goalStrArray.joined(separator: ",")
        self.dismiss(animated: true)
        completion?(selectedWorkOut, selectedLevel, selectedGoal)
    }
    
}

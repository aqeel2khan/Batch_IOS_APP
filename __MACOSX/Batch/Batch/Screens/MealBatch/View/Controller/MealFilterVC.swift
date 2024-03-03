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

class MealFilterVC: UIViewController {
    
    var completion: ((String, String, String) ->Void)? = nil
    
    var completionFilters: (([Int], [Int], [Int]) ->Void)? = nil

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionHeight2: NSLayoutConstraint!
    @IBOutlet weak var collectionView3: UICollectionView!
    @IBOutlet weak var rightTagCollHeight: NSLayoutConstraint!

    var firstArray = [MealCalory]()
    var secondArray   = [BatchGoal]()
    var thirdArray    = [MealTags]()
    
    var selectedWorkOut : [Int] = []
    var selectedLevel : [Int] = []
    var selectedGoal : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        
        let leftLayout = leftSideDataInColl()
        leftLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView1.collectionViewLayout = leftLayout
        
        let centerLayout = UICollectionViewCenterLayout()
        centerLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView2.collectionViewLayout = centerLayout
        
        let rightSideLayout = leftSideDataInColl()
        rightSideLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView3.collectionViewLayout = rightSideLayout
        
        //        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        //        mainView.addGestureRecognizer(tap)
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
                self.rightTagCollHeight.constant = newsize.height
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update height constraint
        
        self.collectionHeight.constant = self.collectionView1.collectionViewLayout.collectionViewContentSize.height
        self.collectionHeight2.constant = self.collectionView2.collectionViewLayout.collectionViewContentSize.height
        self.rightTagCollHeight.constant = self.collectionView3.collectionViewLayout.collectionViewContentSize.height
        
        self.collectionView1.reloadData()
        self.collectionView2.reloadData()
        self.collectionView3.reloadData()
    }
    
    
    func setUpCollectionView(){
        
        collectionView1.allowsSelection = true
        collectionView2.allowsSelection = true
        collectionView3.allowsSelection = true

        collectionView1.register(UINib(nibName: "TrainingFilterCollectionCell", bundle: .main), forCellWithReuseIdentifier: "TrainingFilterCollectionCell")
        
        collectionView2.register(UINib(nibName: "TrainingFilterCollectionCell", bundle: .main), forCellWithReuseIdentifier: "TrainingFilterCollectionCell")
        
        collectionView3.register(UINib(nibName: "TrainingFilterCollectionCell", bundle: .main), forCellWithReuseIdentifier: "TrainingFilterCollectionCell")
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
                
        let commaSeparatedWorkOutStr = selectedWorkOut.map{String($0)}.joined(separator: ",")
        let commaSeparatedLevelStr = selectedLevel.map{String($0)}.joined(separator: ",")
        let commaSeparatedGoalStr = selectedGoal.map{String($0)}.joined(separator: ",")
        
        self.dismiss(animated: true)
        completionFilters?(selectedWorkOut, selectedLevel,selectedGoal)
    }
}

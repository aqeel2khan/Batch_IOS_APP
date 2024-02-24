//
//  QuestionAllergyVC.swift
//  Batch
//
//  Created by Chawtech on 31/01/24.
//

import UIKit

class QuestionAllergyVC: UIViewController {
    
    @IBOutlet weak var customNavigationBar: CustomSecondNavigationBar!
    
    var algeryNames = ["Honey","Milk","Cheese","Nuts","Seafood","Chocolate","Mushrooms","Coffee","Berries",]
    var algeryImages = ["honey","milk-pack","cheese","hazelnut","fish","chocolate","mushrooms","coffee-cup","cherry",]
    @IBOutlet weak var allergyCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setupNavigationBar()
        
    }
    private func setupNavigationBar() {
        customNavigationBar.titleLbl.isHidden = false
        customNavigationBar.titleLbl.text = CustomNavTitle.qustionVCTitle
    }
    
    // MARK:- setUP CollectionView
    
    func setUpCollectionView() {
        allergyCollectionView.delegate = self
        allergyCollectionView.dataSource = self
        allergyCollectionView.register(UINib(nibName: "QuestionAllergyCollectionCell", bundle: .main), forCellWithReuseIdentifier: "QuestionAllergyCollectionCell")
        
    }
    
    @IBAction func nextActionBtn(_ sender: BatchButton) {
        
        let vc = WelcomeVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
}

extension QuestionAllergyVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return algeryNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(QuestionAllergyCollectionCell.self, indexPath)
        cell.alergyName.text = algeryNames[indexPath.row]
        cell.alergyImage.image = UIImage(named: algeryImages[indexPath.row])
        return cell
    }
    
    
}

extension QuestionAllergyVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = allergyCollectionView.frame.width / 3 - 10
        
        return CGSize(width:widthPerItem, height:100)
    }
    
    
}

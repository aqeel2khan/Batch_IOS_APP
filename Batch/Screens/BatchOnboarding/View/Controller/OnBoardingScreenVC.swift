//
//  OnBoardingScreenVC.swift
//  Batch
//
//  Created by shashivendra sengar on 17/12/23.
//

import UIKit

class OnBoardingScreenVC: UIViewController {

    var selectLang = [SelectLang]()

    //MARK:- Outlets
  
    @IBOutlet weak var bottomUIViewHeightConstant: NSLayoutConstraint!
  
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    @IBOutlet weak var btnLogin: BatchButton!
    @IBOutlet weak var btnLookAround: BatchButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var imgViewBG: UIImageView!
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    //MARK: - Didload func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setDrowerHeight()
        //bottomView.insetsLayoutMarginsFromSafeArea = false
        self.pageControl.numberOfPages = 3

    }
  
    override func viewWillAppear(_ animated: Bool) {
//        selectLang.append(SelectLang(languageName: "English"))

        // selectLang.append(SelectLang(languageName:LTYText.english))
   
        lblTitle.text = "Lorem ipsum dolor sit".localized()
        lblSubTitle.text = "Lorem ipsum dolor sit amet consectetur.".localized()
        btnLookAround.setTitle("I want to look around".localized(), for: .normal)
        btnLogin.setTitle("Select Country".localized(), for: .normal)

    }
    //MARK:- SetUp CollectionView
    
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
      /*
       if UIDevice.current.hasNotch {
           
           bottomUIViewHeightConstant.constant = DroverHeight.haveNotch
       } else {
           bottomUIViewHeightConstant.constant = DroverHeight.dontHaveNotch
           
       }
       */
    }
    
    //MARK: - login Action Btn
    @IBAction func loginActionBtn(_ sender: UIButton) {
        
//        L102Language.setAppleLAnguageTo(lang: "ar")
//        change(selectedLanguage: "ar")
        /*
        let vc = BLogInVC.instantiate(fromAppStoryboard: .batchLogInSignUp)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
         */
        
        let vc = BatchCountryLanguageVC.instantiate(fromAppStoryboard: .main)
        vc.modalPresentationStyle = .pageSheet
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
        
        
//        let vc = BWorkOutVC.instantiate(fromAppStoryboard: .batchTrainings)
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .coverVertical
//        self.present(vc, animated: true)
     /*
        let vc = TrainingFilterVC.instantiate(fromAppStoryboard: .batchTrainings)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
      */
    }
    
    func change(selectedLanguage: String){
        L102Language.setAppleLAnguageTo(lang: selectedLanguage)
//        if L102Language.currentAppleLanguage() == "en" {
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//        } else {
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//        }
        Bundle.setLanguage(selectedLanguage)
    }

}

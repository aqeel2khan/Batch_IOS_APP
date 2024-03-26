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
        self.pageControl.numberOfPages = 3
    }
  
    override func viewWillAppear(_ animated: Bool) {
        selectLang.append(SelectLang(languageName: "English"))

//         selectLang.append(SelectLang(languageName:LTYText.english))
   
        lblTitle.text = "Welcome to Batch!".localized
        lblSubTitle.text = "Lorem ipsum dolor sit amet consectetur.".localized
        btnLookAround.setTitle("Guests".localized, for: .normal)
        btnLogin.setTitle("Log In".localized, for: .normal)
  
    }
    
    //MARK:- SetUp CollectionView
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: - login Action Btn
    @IBAction func loginActionBtn(_ sender: UIButton) {
        UserDefaults.standard.setValue("true", forKey: USER_DEFAULTS_KEYS.INITIAL_SCREEN_APPEAR)

        let vc = BLogInVC.instantiate(fromAppStoryboard: .batchLogInSignUp)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.isCommingFrom = "OnBoarding"
        self.present(vc, animated: true)
    }
    
    @IBAction func workAroundActionBtn(_ sender: UIButton) {
        UserDefaults.standard.setValue("true", forKey: USER_DEFAULTS_KEYS.INITIAL_SCREEN_APPEAR)

        let tabbarVC = UIStoryboard(name: "BatchTabBar", bundle: nil).instantiateViewController(withIdentifier: "BatchTabBarNavigation")
        tabbarVC.modalPresentationStyle = .fullScreen
        present(tabbarVC, animated: true, completion: nil)
    }
    
    @IBAction func languageSelectionBtnTap(_ sender: UIButton) {
        let vc = BatchCountryLanguageVC.instantiate(fromAppStoryboard: .main)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
}

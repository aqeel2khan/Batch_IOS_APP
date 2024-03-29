import UIKit

class Country {
    var name, countryCode, currencyCode, currencySymbol, extensionCode: String?
    var flag: String?
}

struct Language {
    var code : String?
    var name : String?
}

class BatchCountryLanguageVC: UIViewController {
    @IBOutlet weak var CountryBackView: UIStackView!
    @IBOutlet weak var languageBackView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var countryTblView: UITableView!
    @IBOutlet weak var languageTblView: UITableView!
    @IBOutlet weak var bottomBackView: UIView!
    var timer: Timer? = nil

    var languageList : [Language] = [Language(code: "en", name: "English"), Language(code: "ar", name: "Arabic (اَلْعَرَبِيَّةُ)")]
    var selectedCountryName = ""
    var selectedLanguageCode = ""

    var list : [Country] = []
    var dupList : [Country] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.CountryBackView.isHidden = false
        self.languageBackView.isHidden = true
        
        self.selectedCountryName = UserDefaultUtility().getCountryName()
        self.selectedLanguageCode = UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.APP_LANGUAGE_CODE) as? String ?? ""

        countryTblView.register(UINib(nibName: "CountryListTableCell", bundle: .main), forCellReuseIdentifier: "CountryListTableCell")
        languageTblView.register(UINib(nibName: "QuestionLabelTVC", bundle: .main), forCellReuseIdentifier: "QuestionLabelTVC")
        configuration()
    }
    
    override func viewDidLayoutSubviews() {
        setupViews()
    }
   
    private func setupViews() {
        self.segmentControl.setTitle(SegmentControlTitle.countrySegmentTitle.localized, forSegmentAt: 0)
        self.segmentControl.setTitle(SegmentControlTitle.langaugeSegmentTitle.localized, forSegmentAt: 1)
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.CountryBackView.isHidden = false
            self.languageBackView.isHidden = true
        }
        else {
            self.CountryBackView.isHidden = true
            self.languageBackView.isHidden = false
        }
    }
    
    @IBAction func onTapNextBtn(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            segmentControl.selectedSegmentIndex = 1
            self.CountryBackView.isHidden = true
            self.languageBackView.isHidden = false
        }
        else {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: selectedLanguageCode)
            UserDefaults.standard.setValue(selectedLanguageCode, forKey: USER_DEFAULTS_KEYS.APP_LANGUAGE_CODE)
            UIView.appearance().semanticContentAttribute = (selectedLanguageCode == ENGLISH_LANGUAGE_CODE) ? .forceLeftToRight : .forceRightToLeft
            
            let tabbarVC = UIStoryboard(name: "BatchTabBar", bundle: nil).instantiateViewController(withIdentifier: "BatchTabBarNavigation")
            tabbarVC.modalPresentationStyle = .fullScreen
            AppDelegate.standard.window?.rootViewController = tabbarVC
        }
    }
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func onTapCrosskBtn(_ sender: Any) {
        searchTextField.text =  ""
        searchTextField.endEditing(true)
        
        self.dupList = self.list
        self.countryTblView.reloadData()
    }
    
    func configuration() {
        for code in NSLocale.isoCountryCodes  {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id)
            
            let locale = NSLocale.init(localeIdentifier: id)
            
            let countryCode = locale.object(forKey: NSLocale.Key.countryCode)
            let currencyCode = locale.object(forKey: NSLocale.Key.currencyCode)
            let currencySymbol = locale.object(forKey: NSLocale.Key.currencySymbol)
            
            if name != nil {
                let model = Country()
                model.name = name
                model.countryCode = countryCode as? String
                model.currencyCode = currencyCode as? String
                model.currencySymbol = currencySymbol as? String
                model.flag = String.flag(for: code)
                model.extensionCode = NSLocale().extensionCode(countryCode: model.countryCode)
                list.append(model)
            }
        }
        self.dupList = self.list
        self.countryTblView.reloadData()
    }
}

//extension BatchCountryLanguageVC : UISearchBarDelegate {
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text =  ""
//        searchBar.endEditing(true)
//        
//        self.dupList = self.list
//        self.countryTblView.reloadData()
//    }
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("search = \(searchText)" )
//        self.dupList = searchText.isEmpty ? list : list.filter({ (model) -> Bool in
//            return model.name!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        })
//        self.countryTblView.reloadData()
//    }
//}

extension BatchCountryLanguageVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == searchTextField {
            
            let placeTextFieldStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
            
            timer?.invalidate()
            timer = Timer.scheduledTimer(
                timeInterval: 0.5,
                target: self,
                selector: #selector(getHints),
                userInfo: placeTextFieldStr,
                repeats: false)
        }
          
       
        return true
    }
    
    @objc func getHints(timer: Timer) {
        let userInfo = timer.userInfo as! String
        
        if searchTextField.text == "" {
            self.dupList = self.list
        } else {
            self.dupList = self.list.filter{ $0.name!.lowercased().contains(userInfo.lowercased()) }
        }
        
        self.countryTblView.reloadData()
    }
}

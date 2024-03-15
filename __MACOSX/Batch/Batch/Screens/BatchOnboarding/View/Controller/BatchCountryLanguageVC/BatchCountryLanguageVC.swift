
import UIKit

class Country {
    var name, countryCode, currencyCode, currencySymbol, extensionCode: String?
    var flag: String?
}

class BatchCountryLanguageVC: UIViewController {
    @IBOutlet weak var CountryBackView: UIStackView!
    @IBOutlet weak var languageBackView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var countryTblView: UITableView!
    @IBOutlet weak var languageTblView: UITableView!
    @IBOutlet weak var bottomBackView: UIView!
    
    var languageList : [String] = ["English", "Arabic (اَلْعَرَبِيَّةُ)", "Dari Persian (دری)", "Arabic (اَلْعَرَبِيَّةُ)"]
    var selectedCountryName = ""
    var selectedLanguageCode = ""

    var list : [Country] = []
    var dupList : [Country] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.CountryBackView.isHidden = false
        self.languageBackView.isHidden = true
        
        countryTblView.register(UINib(nibName: "CountryListTableCell", bundle: .main), forCellReuseIdentifier: "CountryListTableCell")
        languageTblView.register(UINib(nibName: "QuestionLabelTVC", bundle: .main), forCellReuseIdentifier: "QuestionLabelTVC")
        configuration()
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
        if selectedLanguageCode == "" {
            showAlert(message: "Please select Langauge".localized)
        } else {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: selectedLanguageCode)
            UserDefaults.standard.setValue(selectedLanguageCode, forKey: USER_DEFAULTS_KEYS.APP_LANGUAGE_CODE)
            //UIView.appearance().semanticContentAttribute = (selectedLanguageCode == ENGLISH_LANGUAGE_CODE) ? .forceLeftToRight : .forceRightToLeft
        }
        
        let tabbarVC = UIStoryboard(name: "BatchTabBar", bundle: nil).instantiateViewController(withIdentifier: "BatchTabBarNavigation")
        tabbarVC.modalPresentationStyle = .fullScreen
        present(tabbarVC, animated: true, completion: nil)
    }
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        dismiss(animated: true)
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

extension BatchCountryLanguageVC : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text =  ""
        searchBar.endEditing(true)
        
        self.dupList = self.list
        self.countryTblView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search = \(searchText)" )
        self.dupList = searchText.isEmpty ? list : list.filter({ (model) -> Bool in
            return model.name!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        self.countryTblView.reloadData()
    }
}

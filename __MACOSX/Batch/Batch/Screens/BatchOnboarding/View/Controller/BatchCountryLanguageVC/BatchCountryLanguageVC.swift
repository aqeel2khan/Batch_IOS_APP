//
//  BatchCountryLanguageVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 21/02/24.
//

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
    
    @IBOutlet weak var englishL: BatchButton!
    @IBOutlet weak var arabicL: BatchButton!
    @IBOutlet weak var dariL: BatchButton!
    
    @IBOutlet weak var bottomBackView: UIView!
    
//    var selectedCountry : [String] = []
    var selectedCountryName = ""
    
    var list = [Country]()
    var dupList = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.CountryBackView.isHidden = false
        self.languageBackView.isHidden = true
        
        countryTblView.register(UINib(nibName: "CountryListTableCell", bundle: .main), forCellReuseIdentifier: "CountryListTableCell")
        
        configuration()
    }
 
    //MARK:-  check internet Connection
    
    //    func checkNetwork () {
    //
    //        Task{
    //            do{
    //                let response = try await self.callApiService.getOperation(requestUrl:"https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/by-code.json", response: Country.self)
    //
    //                countryListData = response
    //                //                    print(countryListData.count)
    //                //                    print(countryListData)
    //
    //                for (key,value) in countryListData{
    //                    countryName.append(value.name)
    //                    countryImage.append(value.image)
    //                }
    //
    //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.010) {
    //                    self.countryTblView.reloadData()
    //                }
    //            }
    //            catch{
    //                //                        self.ShowAlert(message: error.localizedDescription)
    //            }
    //        }
    //
    //    }
    
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
        change(selectedLanguage: selectedCountryName)
        
        let tabbarVC = UIStoryboard(name: "BatchTabBar", bundle: nil).instantiateViewController(withIdentifier: "BatchTabBarNavigation")
        tabbarVC.modalPresentationStyle = .fullScreen
        present(tabbarVC, animated: true, completion: nil)
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
    
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func onTapEnglishLBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.englishL.backgroundColor = Colors.appViewPinkBackgroundColor
        }
        else {
            self.englishL.backgroundColor = Colors.appViewBackgroundColor
        }
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

extension BatchCountryLanguageVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableCell", for: indexPath) as! CountryListTableCell
        cell.configure(selected: selectedCountryName == dupList[indexPath.row].name )

        let info = dupList[indexPath.row]
        if info.name != "Israel" {
            cell.lblCountryName.text = "\(info.flag!) \(info.name!)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCountryName = dupList[indexPath.row].name ?? ""
        countryTblView.reloadData()
    }
}

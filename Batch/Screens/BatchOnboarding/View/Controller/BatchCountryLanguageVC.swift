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
    
    //    var selectedCountry : [Int] = []
    var selectedCountry : [String] = []
    //var selectedCountryName: String?
    var selectedCountryName = ""
    
    
    //    var countryListData = [String:CountryListValue]()
    
    var list = [Country]()
    var dupList = [Country]()
    
    
    //    var countryName = [String]()
    //    var countryImage = [String]()
    //    var callApiService = HttpUtility1.shared
    
    // MARK: - Properties
    private let cornerRadius: CGFloat = 24
    var selectedIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.CountryBackView.isHidden = false
        self.languageBackView.isHidden = true
        
        countryTblView.register(UINib(nibName: "CountryListTableCell", bundle: .main), forCellReuseIdentifier: "CountryListTableCell")
        
        configuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // checkNetwork ()
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
        if sender.selectedSegmentIndex == 0
        {
            selectedIndex = 0
            self.CountryBackView.isHidden = false
            self.languageBackView.isHidden = true
        }
        else
        {
            selectedIndex = 1
            self.CountryBackView.isHidden = true
            self.languageBackView.isHidden = false
        }
        DispatchQueue.main.async {
        }
    }
    
    @IBAction func onTapNextBtn(_ sender: Any) {
        
        if selectedCountryName != ""
        {
            UserDefaults.standard.set(selectedCountryName, forKey: "isCountrySelected")
            // Synchronize UserDefaults to make sure the value is saved immediately
            UserDefaults.standard.synchronize()
            
            let tabbarVC = UIStoryboard(name: "BatchTabBar", bundle: nil).instantiateViewController(withIdentifier: "BatchTabBarNavigation")
            tabbarVC.modalPresentationStyle = .fullScreen
            present(tabbarVC, animated: true, completion: nil)
        }
        else
        {
            showAlert(message: "Please select country")
        }
        
    }
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func onTapEnglishLBtn(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected
        {
            self.englishL.backgroundColor = Colors.appViewPinkBackgroundColor
        }
        else
        {
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


extension BatchCountryLanguageVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dupList.count//countryName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableCell", for: indexPath) as! CountryListTableCell
        
        let info = dupList[indexPath.row]
        if info.name != "Israel"
        {
            cell.lblCountryName.text = "\(info.flag!) \(info.name!)"
        }
        
        cell.backGroundUIView.backgroundColor = Colors.appViewBackgroundColor
        if info.name != ""
        {
            if self.selectedCountry.contains(info.name!) {
                cell.backGroundUIView.backgroundColor = Colors.appViewPinkBackgroundColor
                
                selectedCountryName = info.name!
                //1
                UserDefaults.standard.set(selectedCountryName, forKey: "country")
                // Synchronize UserDefaults to make sure the value is saved immediately
                UserDefaults.standard.synchronize()
                
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50//UIScreen.main.bounds.height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selectedCountry.count == 0 {
            self.selectedCountry.append(self.list[indexPath.row].name ?? "")
        } else {
            self.selectedCountry.removeAll()
            self.selectedCountry.append(self.list[indexPath.row].name ?? "")
        }
        // Reload table here
        self.countryTblView.reloadData()

    }
    
}

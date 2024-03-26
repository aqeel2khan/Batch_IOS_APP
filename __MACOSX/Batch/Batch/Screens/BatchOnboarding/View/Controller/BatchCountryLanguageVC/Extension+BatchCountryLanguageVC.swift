
import UIKit

extension BatchCountryLanguageVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == countryTblView {
            return self.dupList.count
            
        } else {
            return self.languageList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == countryTblView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableCell", for: indexPath) as! CountryListTableCell
            
            cell.configure(selected: selectedCountryName == dupList[indexPath.row].name)
            
            let info = dupList[indexPath.row]
            if info.name != "Israel" {
                cell.lblCountryName.text = "\(info.flag!) \(info.name!)"
            }
            return cell
        } else {
            let cell = tableView.dequeueCell(QuestionLabelTVC.self, for: indexPath)
            cell.titleLbl.text = self.languageList[indexPath.row].name
            
            if self.selectedLanguageCode == self.languageList[indexPath.row].code {
                cell.questionUIView.backgroundColor = Colors.appThemeBackgroundColor
            } else {
                cell.questionUIView.backgroundColor = Colors.appViewBackgroundColor
            }
              
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == countryTblView {
            self.selectedCountryName = dupList[indexPath.row].name ?? ""
            UserDefaultUtility().saveCountryName(nameStr: self.selectedCountryName)
            countryTblView.reloadData()
        } else {
            if indexPath.row == 0 {
                selectedLanguageCode = ENGLISH_LANGUAGE_CODE
            } else {
                selectedLanguageCode = ARABIC_LANGUAGE_CODE 
            }
            self.languageTblView.reloadData()
        }
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        if tableView == languageTblView {
//            let cell : QuestionLabelTVC = languageTblView.cellForRow(at: indexPath) as! QuestionLabelTVC
//            cell.questionUIView.backgroundColor = Colors.appViewBackgroundColor
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == countryTblView {
            return 50
        } else {
            return 60
        }
    }
}

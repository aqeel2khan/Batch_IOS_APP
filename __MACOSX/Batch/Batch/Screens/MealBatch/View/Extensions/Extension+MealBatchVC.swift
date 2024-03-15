//
//  Extension+MealBatchVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//

import Foundation
import UIKit

extension MealBatchVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchTextField.text == "" {
            if self.mealListData.count > 0 {
                return self.mealListData.count
            }
        } else {
            if self.searchmealListData.count > 0 {
                return self.searchmealListData.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchTextField.text == "" && indexPath.row == 2 &&  mealListData.count > 0 {
            let cell = tableView.dequeueCell(MealPlanBannerViewTVC.self, for: indexPath)
            cell.calculateBtn.addTarget(self, action: #selector(openQuestionModule), for: .touchUpInside)
            cell.calculateBtn.tag = indexPath.row
            return cell
        } else {
                if indexPath.row < 2 {
                    if searchTextField.text == "" {
                        let cell = tableView.dequeueCell(MealPlanTVC.self, for: indexPath)
                        cell.titleLbl.text = self.mealListData[indexPath.row].name
                        let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(self.mealListData[indexPath.row].price ?? "")", prefixFont: UIFont(name:"Outfit-Medium",size:10)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
                        cell.priceLbl.attributedText = attributedPriceString

                        let original1String = "\(self.mealListData[indexPath.row].avgCalPerDay ?? "") \(BatchConstant.kcalSuffix)"
                        let keyword1 = BatchConstant.kcalSuffix
                        let attributedString = NSAttributedString.attributedStringWithDifferentFonts(for: original1String, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword1)
                        cell.kclLbl.attributedText = attributedString
                        cell.mealsLbl.text = "\(self.mealListData[indexPath.row].mealCount ?? 0) \(BatchConstant.meals)"
                        
                        let original2String = "\(self.mealListData[indexPath.row].mealCount ?? 0) \(BatchConstant.meals)"
                        let keyword2 = BatchConstant.meals
                        let attributedString1 = NSAttributedString.attributedStringWithDifferentFonts(for: original2String, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword2)
                        cell.mealsLbl.attributedText = attributedString1
                        return cell
                    } else {
                        let cell = tableView.dequeueCell(MealPlanTVC.self, for: indexPath)
                        cell.titleLbl.text = self.searchmealListData[indexPath.row].name
                        let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(self.searchmealListData[indexPath.row].price ?? "")", prefixFont: UIFont(name:"Outfit-Medium",size:10)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
                        cell.priceLbl.attributedText = attributedPriceString

                        let originalString = "\(self.searchmealListData[indexPath.row].avgCalPerDay ?? "") \(BatchConstant.kcalSuffix)"
                        let keyword = BatchConstant.kcalSuffix
                        let attributedString = NSAttributedString.attributedStringWithDifferentFonts(for: originalString, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword)
                        cell.kclLbl.attributedText = attributedString
                        let original2String = "\(self.searchmealListData[indexPath.row].mealCount ?? 0) " + BatchConstant.meals
                        let keyword2 = BatchConstant.meals
                        let attributedString1 = NSAttributedString.attributedStringWithDifferentFonts(for: original2String, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword2)
                        cell.mealsLbl.attributedText = attributedString1
                        return cell
                    }
                } else {
                    if searchTextField.text == "" {
                        let cell = tableView.dequeueCell(MealPlanTVC.self, for: indexPath)
                        cell.titleLbl.text = self.mealListData[indexPath.row].name
                        let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(self.mealListData[indexPath.row].price ?? "")", prefixFont: UIFont(name:"Outfit-Medium",size:10)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
                        cell.priceLbl.attributedText = attributedPriceString
                        let originalString = "\(self.mealListData[indexPath.row].avgCalPerDay ?? "") " + BatchConstant.kcalSuffix
                        let keyword = BatchConstant.kcalSuffix
                        let attributedString = NSAttributedString.attributedStringWithDifferentFonts(for: originalString, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword)
                        cell.kclLbl.attributedText = attributedString
                        let original2String = "\(self.mealListData[indexPath.row].mealCount ?? 0) " + BatchConstant.meals
                        let keyword2 = BatchConstant.meals
                        let attributedString1 = NSAttributedString.attributedStringWithDifferentFonts(for: original2String, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword2)
                        cell.mealsLbl.attributedText = attributedString1
                        return cell
                    } else {
                        let cell = tableView.dequeueCell(MealPlanTVC.self, for: indexPath)
                        cell.titleLbl.text = self.searchmealListData[indexPath.row].name
                        let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(self.searchmealListData[indexPath.row].price ?? "")", prefixFont: UIFont(name:"Outfit-Medium",size:10)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
                        cell.priceLbl.attributedText = attributedPriceString
                        let originalString = "\(self.searchmealListData[indexPath.row].avgCalPerDay ?? "") " + BatchConstant.kcalSuffix
                        let keyword = BatchConstant.kcalSuffix
                        let attributedString = NSAttributedString.attributedStringWithDifferentFonts(for: originalString, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword)
                        cell.kclLbl.attributedText = attributedString
                        let original2String = "\(self.searchmealListData[indexPath.row].mealCount ?? 0) " + BatchConstant.meals
                        let keyword2 = BatchConstant.meals
                        let attributedString1 = NSAttributedString.attributedStringWithDifferentFonts(for: original2String, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword2)
                        cell.mealsLbl.attributedText = attributedString1
                        return cell
                    }
                }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < 2 {
            if searchTextField.text == "" {
                let vc = MealBatchUnSubscribeDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .coverVertical
                vc.mealData = self.mealListData[indexPath.item]
                self.present(vc, animated: true)
            } else {
                let vc = MealBatchUnSubscribeDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .coverVertical
                vc.mealData = self.searchmealListData[indexPath.item]
                self.present(vc, animated: true)
            }
        }
        else if indexPath.row > 2 {
            if searchTextField.text == "" {
                let vc = MealBatchUnSubscribeDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .coverVertical
                vc.mealData = self.mealListData[indexPath.item]
                self.present(vc, animated: true)
            } else {
                let vc = MealBatchUnSubscribeDetailVC.instantiate(fromAppStoryboard: .batchMealPlans)
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .coverVertical
                vc.mealData = self.searchmealListData[indexPath.item]
                self.present(vc, animated: true)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240 //UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
    }
    
    @objc func openQuestionModule() {
        let vc = QuestionGoalVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
}

extension MealBatchVC : UITextFieldDelegate {
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
        self.searchmealListData = self.mealListData.filter{ $0.name!.lowercased().contains(userInfo.lowercased()) }

            self.mealPlanTblView.reloadData()
    }
}

extension NSAttributedString {
    static func attributedStringWithDifferentFonts(for string: String, prefixFont: UIFont, suffixFont: UIFont, keyword: String) -> NSAttributedString {
        // Find the range for keyword
        guard let rangeOfKeyword = string.range(of: keyword) else {
            // Return the original string if keyword is not found
            return NSAttributedString(string: string)
        }
        
        // Split the original string into two parts: before and after the keyword
        let prefix = string[..<rangeOfKeyword.lowerBound]
        let suffix = string[rangeOfKeyword.lowerBound...]
        
        // Create attributed string for the prefix part
        let attributedStringPrefix = NSAttributedString(string: String(prefix), attributes: [.font: prefixFont])
        
        // Create attributed string for the suffix part (including keyword)
        let attributedStringSuffix = NSAttributedString(string: String(suffix), attributes: [.font: suffixFont])
        
        // Combine the attributed strings
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(attributedStringPrefix)
        combinedAttributedString.append(attributedStringSuffix)
        
        return combinedAttributedString
    }
    
    static func attributedStringForPrice(prefix: String, value: String, prefixFont: UIFont, valueFont: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: prefix + value)
        let rangeOfValue = (prefix + value).range(of: value)
        
        attributedString.addAttributes([.font: prefixFont], range: NSRange(location: 0, length: prefix.count))
        attributedString.addAttributes([.font: valueFont], range: NSRange(rangeOfValue!, in: prefix + value))
        
        return attributedString
    }
}

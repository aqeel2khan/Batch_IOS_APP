//
//  Extension+MealBatchDetailVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 28/01/24.
//

import Foundation
import UIKit

extension MealBatchDetailVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedWeekDay?.dishes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(BMealTblCell.self, for: indexPath)
        cell.selectionStyle = .none
        if let dish = self.selectedWeekDay?.dishes?[indexPath.row] {
            if let category = getCategory(from: dish.dishCategory) {
                cell.sectionTitleLbl.text = category.categoryName
            } else {
                cell.sectionTitleLbl.text = ""
            }
            cell.dishName.text = dish.dishName
            let original1String = "\(dish.calories) kcal"
            let keyword1 = "kcal"
            let attributedString = NSAttributedString.attributedStringWithDifferentFonts(for: original1String, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword1)
            cell.dishCalory.attributedText = attributedString
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tap On Collection")
        if let dish = self.selectedWeekDay?.dishes?[indexPath.row] {
            openMealIngredientView(dishId: "\(dish.dishID)", dishName: dish.dishName ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140 //UITableView.automaticDimension
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
    
}

extension MealBatchDetailVC: UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 201 {
            return self.tagTitleArray.count
        }
        else if collectionView.tag == 202 {
            return self.weekDays.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 201 {
            let cell = collectionView.dequeue(BatchTrainingDetailCollCell.self, indexPath)
            cell.imgWorkOut.image = tagIconArray[indexPath.row]
            cell.lblWorkoutName.text = tagTitleArray[indexPath.row]
            return cell
        } else if collectionView.tag == 202 {
            let cell = collectionView.dequeue(weekCalenderCollCell.self, indexPath)
            cell.weekDayNameLbl.text = self.weekDays[indexPath.row].dayName
            cell.weekDateLbl.text = self.weekDays[indexPath.row].dayOfMonth
            cell.greenDotImgView.isHidden = !DateHelper.isOldDate(self.weekDays[indexPath.row].date)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 202 {
            let weekday = self.weekDays[indexPath.item]
            self.selectedWeekDay = weekday
            self.mealTblView.reloadData()
            if let dish = self.selectedWeekDay?.dishes, dish.count > 0 {
                self.mealMsgBackView.isHidden = true
            } else {
                self.mealMsgBackView.isHidden = false
            }
        }
    }
}


extension MealBatchDetailVC {
    enum DishCategory: Int {
        case breakfast = 1
        case lunch = 2
        case snack = 3
        case dinner = 4
        
        var categoryName: String {
            switch self {
            case .breakfast:
                return "Breakfast"
            case .lunch:
                return "Lunch"
            case .snack:
                return "Snack"
            case .dinner:
                return "Dinner"
            }
        }
    }
    
    func getCategory(from value: Int) -> DishCategory? {
        return DishCategory(rawValue: value)
    }
}

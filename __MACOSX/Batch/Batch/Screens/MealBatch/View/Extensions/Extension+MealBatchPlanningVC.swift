//
//  Extension+MealBatchPlanningVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 28/01/24.
//

import Foundation
import UIKit

extension MealBatchPlanningVC: UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 601 {
            return self.weekDays.count
        }
        else if collectionView.tag == 602 {
            return self.subscribedMealDetails?.mealDetails.categoryList.count ?? 0
        }
        else if collectionView.tag == 603 {
            return self.dishesList.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 601 {
            let cell = collectionView.dequeue(weekCalenderCollCell.self, indexPath)
            cell.weekDayNameLbl.text = self.weekDays[indexPath.item].dayName
            cell.weekDateLbl.text = self.weekDays[indexPath.item].dayOfMonth
            cell.greenDotImgView.isHidden = isOldDate(self.weekDays[indexPath.row].date)
            return cell
        } else if collectionView.tag == 602 {
            let cell = collectionView.dequeue(BMealCategoryCollCell.self, indexPath)
            if let categoryArray = self.subscribedMealDetails?.mealDetails.categoryList {
                cell.categoryTitleLbl.text = categoryArray[indexPath.item].categoryName
            }
            return cell
        } else if collectionView.tag == 603 {
            let cell = collectionView.dequeue(BMealDishCollCell.self, indexPath)
            cell.nameLbl.text = self.dishesList[indexPath.item].name
            
            if let selectedDayDishes = selectedWeekDay?.dishes {
                // Check if the dish is selected for the current day
                let dishID = self.dishesList[indexPath.item].dishID
                let isSelected = selectedDayDishes.contains(where: { $0.dishID == dishID && $0.selected == 1 })
                // Set radio button to true if the dish is selected for the current day
                cell.radioBtn.isSelected = isSelected
            } else {
                cell.radioBtn.isSelected = false
            }
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
        if collectionView.tag == 601 {
            let weekday = self.weekDays[indexPath.item]
            self.selectedWeekDay = weekday
            collectionView.deselectAllItems(animated: false)
        } else if collectionView.tag == 602 {
            if let cell = self.mealCategoryCollView.cellForItem(at: indexPath) as? BMealCategoryCollCell {
                cell.bgView.backgroundColor = Colors.appViewBackgroundColor
            } else {
                // Handle the case when the cell is not available
                print("Cell is not available")
            }
        } else if collectionView.tag == 603 {
            let tappedDish = self.dishesList[indexPath.item]

            if let existingDishIndex = selectedWeekDay?.dishes?.firstIndex(where: { $0.dishCategory == selectedMealCategory?.categoryID }) {
                // There is an existing dish in the selected category
                if let selectedDish = selectedWeekDay?.dishes?[existingDishIndex] {
                    if selectedDish.dishID == tappedDish.dishID {
                        print("User tapped on the same item of the same category")
                        // Do nothing
                    } else {
                        // Replace the existing dish with the tapped dish in the array
                        if let foundDayDish = convertDishesToDaysDish(dish: tappedDish) {
                            selectedWeekDay?.dishes?[existingDishIndex] = foundDayDish
                            reloadTheMealCollectionView()
                        }
                        print("User tapped on a different item of the same category, replaced it in the array")
                    }
                }
            } else {
                // No dish exists in the selected category, so append the tapped dish
                if let foundDayDish = convertDishesToDaysDish(dish: tappedDish) {
                    selectedWeekDay?.dishes?.append(foundDayDish)
                    reloadTheMealCollectionView()
                }
                print("User tapped on a dish in a new category, added it to the array")
            }

//            if let selectedDish = selectedWeekDay?.dishes?.first(where: { $0.dishCategory == selectedMealCategory?.categoryID }) {
//                if selectedDish.dishID == tappedDish.dishID {
//                    print("User tapped on the same item of the same category")
//                    // Do nothing
//                } else {
//                    // Replace the existing dish with the tapped dish in the array
//                    if let index = selectedWeekDay?.dishes?.firstIndex(where: { $0.dishID == selectedDish.dishID }) {
//                        if let foundDayDish = convertDishesToDaysDish(dish: tappedDish) {
//                            selectedWeekDay?.dishes?[index] = foundDayDish
//                            reloadTheMealCollectionView()
//                        }
//                        print("User tapped on a different item of the same category, replaced it in the array")
//                    }
//                }
//            } else {
//                // If no dish exists in the category, simply append the tapped dish
//                if let foundDayDish = convertDishesToDaysDish(dish: tappedDish) {
//                    selectedWeekDay?.dishes?.append(foundDayDish)
//                    reloadTheMealCollectionView()
//                }
//                print("User tapped on a dish in a new category, added it to the array")
//            }

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView.tag == 602 {
            if let cell = self.mealCategoryCollView.cellForItem(at: indexPath) as? BMealCategoryCollCell {
                cell.bgView.backgroundColor = Colors.appViewBackgroundColor
            } else {
                // Handle the case when the cell is not available
                print("Cell is not available")
            }
        }
    }

    func convertDishesToDaysDish(dish: Dishes) -> DaysDish? {
        guard let aSelectedWeekday = self.selectedWeekDay else {
            return nil
        }
        return DaysDish(dishID: dish.dishID ?? 0,
                        dishName: dish.name ?? "",
                        dishImage: "", // You need to set the dish image from somewhere
                        dishCategory: dish.categoryID ?? 0,
                        month: aSelectedWeekday.month, // You need to set the month from somewhere
                        day: aSelectedWeekday.day, // You need to set the day from somewhere
                        selected: 1) // You need to set the selected from somewhere
    }
    
    func isOldDate(_ date: Date) -> Bool {
        let currentDate = Date()
        return date < currentDate
    }
    
    func isDateGreaterThanTwoDays(_ date: Date) -> Bool {
        let currentDate = Date()
        let twoDaysFromNow = Calendar.current.date(byAdding: .day, value: 2, to: currentDate)!
        return date > twoDaysFromNow
    }
}

extension MealBatchPlanningVC {
    @objc(collectionView:layout:sizeForItemAtIndexPath:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView.tag == 603 {
            let screenSize              = collectionView.frame.size //UIScreen.main.bounds
            let screenWidth             = screenSize.width
            let cellSquareSize: CGFloat = screenWidth
            return CGSize.init(width: cellSquareSize/2 - 20, height: 180) //250
        } else {
            let screenSize              = collectionView.frame.size //UIScreen.main.bounds
            let screenWidth             = screenSize.width
            return CGSize(width: screenWidth, height: 80)
        }
    }
    
    @objc(collectionView:layout:insetForSectionAtIndex:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: CGFloat(), right: 0)
    }
    
    @objc(collectionView:layout:minimumLineSpacingForSectionAtIndex:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    
    @objc(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
}

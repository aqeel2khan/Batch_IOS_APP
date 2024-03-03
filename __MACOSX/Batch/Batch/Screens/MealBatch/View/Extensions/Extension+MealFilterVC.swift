//
//  Extension+TrainingFilterVC.swift
//  Batch
//
//  Created by shashivendra sengar on 17/12/23.
//

import UIKit
import Foundation

extension MealFilterVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 901
        {
            return firstArray.count
        }
        else if collectionView.tag == 902{
            return secondArray.count
        }
        else if collectionView.tag == 903{
            return thirdArray.count
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(TrainingFilterCollectionCell.self, indexPath)
        
        if collectionView.tag == 901
        {
            let info = firstArray[indexPath.row]
            cell.lblWorkoutName.text = "\(info.fromValue ?? 0) - \(info.toValue ?? 0 )"
            
            cell.backGroundUIView.backgroundColor = Colors.appViewBackgroundColor
            if self.selectedWorkOut.contains(info.id ?? 0) {
                cell.backGroundUIView.backgroundColor = Colors.appViewPinkBackgroundColor
            }
            
            
        }
        else if collectionView.tag == 902
        {
            let info = secondArray[indexPath.row]
            cell.lblWorkoutName.text = "\(info.name ?? "")"
            
            cell.backGroundUIView.backgroundColor = Colors.appViewBackgroundColor
            if self.selectedLevel.contains(info.id ?? 0) {
                cell.backGroundUIView.backgroundColor = Colors.appViewPinkBackgroundColor
            }
        }
        else if collectionView.tag == 903
        {
            let info = thirdArray[indexPath.row]
            cell.lblWorkoutName.text = "\(info.name ?? "")"
            
            cell.backGroundUIView.backgroundColor = Colors.appViewBackgroundColor
            if self.selectedGoal.contains(info.id ?? 0) {
                cell.backGroundUIView.backgroundColor = Colors.appViewPinkBackgroundColor
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
        //        UIView.animate(
        //            withDuration: 0.5,
        //            delay: 0.05 * Double(indexPath.row),
        //            options: [.curveEaseInOut],
        //            animations: {
        //                cell.transform = CGAffineTransform(translationX: 0, y: 0)
        //            })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView1 {
            if self.selectedWorkOut.count == 0 {
                self.selectedWorkOut.append(self.firstArray[indexPath.item].id ?? 0)
                self.collectionView1.reloadData()
            } else {
                if self.selectedWorkOut.contains(self.firstArray[indexPath.item].id ?? 0) {
                    if let selectedIndex = selectedWorkOut.firstIndex(where: {$0 == self.firstArray[indexPath.item].id}) {
                        self.selectedWorkOut.remove(at: selectedIndex)
                    }
                } else {
                    self.selectedWorkOut.removeAll()
                    self.selectedWorkOut.append(self.firstArray[indexPath.item].id ?? 0)
                }
                self.collectionView1.reloadData()
            }
        } else if collectionView == collectionView2 {
            if self.selectedLevel.count == 0 {
                self.selectedLevel.append(self.secondArray[indexPath.item].id ?? 0)
                self.collectionView2.reloadData()
            } else {
                if self.selectedLevel.contains(self.secondArray[indexPath.item].id ?? 0) {
                    if let selectedIndex = selectedLevel.firstIndex(where: {$0 == self.secondArray[indexPath.item].id}) {
                        self.selectedLevel.remove(at: selectedIndex)
                    }
                } else {
                    self.selectedLevel.removeAll()
                    self.selectedLevel.append(self.secondArray[indexPath.item].id ?? 0)
                }
                self.collectionView2.reloadData()
            }
        }
        else if collectionView == collectionView3 {
            if self.selectedGoal.contains(self.thirdArray[indexPath.item].id ?? 0) {
                if let selectedIndex = selectedGoal.firstIndex(where: {$0 == self.thirdArray[indexPath.item].id}) {
                    self.selectedGoal.remove(at: selectedIndex)
                }
            }
            else {
                self.selectedGoal.append(self.thirdArray[indexPath.item].id ?? 0)
            }
            self.collectionView3.reloadData()
            
        }
    }
    
}

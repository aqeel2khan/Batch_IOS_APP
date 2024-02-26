//
//  Extension+TrainingFilterVC.swift
//  Batch
//
//  Created by shashivendra sengar on 17/12/23.
//

import UIKit
import Foundation

extension MotivatorFilterVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 901
        {
            return workOutArray.count
        }
        else if collectionView.tag == 902{
            return experienceArray.count
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(TrainingFilterCollectionCell.self, indexPath)
        
        if collectionView.tag == 901
        {
            let info = workOutArray[indexPath.row]
            cell.lblWorkoutName.text = "\(info.workoutType )"
            
            cell.backGroundUIView.backgroundColor = Colors.appViewBackgroundColor
            if self.selectedWorkOut.contains(info.id) {
                cell.backGroundUIView.backgroundColor = Colors.appViewPinkBackgroundColor
            }
        }
        else if collectionView.tag == 902
        {
            let info = experienceArray[indexPath.row]
            cell.lblWorkoutName.text = "\(info.experience)"
            
            cell.backGroundUIView.backgroundColor = Colors.appViewBackgroundColor
            if self.selectedExperience.contains(info.id) {
                cell.backGroundUIView.backgroundColor = Colors.appViewPinkBackgroundColor
            }
        }
        return cell
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
        if collectionView == workOutCollectionView {
            if self.selectedWorkOut.contains(self.workOutArray[indexPath.item].id) {
                if let selectedIndex = selectedWorkOut.firstIndex(where: {$0 == self.workOutArray[indexPath.item].id}) {
                    self.selectedWorkOut.remove(at: selectedIndex)
                }
            }
            else {
                self.selectedWorkOut.append(self.workOutArray[indexPath.item].id)
            }
            self.workOutCollectionView.reloadData()
        }
        else if collectionView == collectionView2 {
                if self.selectedExperience.count == 0 {
                self.selectedExperience.append(self.experienceArray[indexPath.item].id)
                self.collectionView2.reloadData()
            } else {
                self.selectedExperience.removeAll()
                self.selectedExperience.append(self.experienceArray[indexPath.item].id)
                self.collectionView2.reloadData()
            }
        }
    }
}




//
//  Extension+TrainingFilterVC.swift
//  Batch
//
//  Created by shashivendra sengar on 17/12/23.
//

import UIKit
import Foundation

extension TrainingFilterVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 901
        {
            return workOutArray.count
        }
        else if collectionView.tag == 902{
            return levelArray.count
        }
        else if collectionView.tag == 903{
            return goalArray.count
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
            cell.lblWorkoutName.text = "\(info.workoutType ?? "")"
            
            cell.backGroundUIView.backgroundColor = Colors.appViewBackgroundColor
            if self.selectedWorkOut.contains(info.id ?? 0) {
                cell.backGroundUIView.backgroundColor = Colors.appViewPinkBackgroundColor
            }
            
            
        }
        else if collectionView.tag == 902
        {
            let info = levelArray[indexPath.row]
            cell.lblWorkoutName.text = "\(info.levelName ?? "")"
            
            cell.backGroundUIView.backgroundColor = Colors.appViewBackgroundColor
            if self.selectedLevel.contains(info.id ?? 0) {
                cell.backGroundUIView.backgroundColor = Colors.appViewPinkBackgroundColor
            }
        }
        else if collectionView.tag == 903
        {
            let info = goalArray[indexPath.row]
            cell.lblWorkoutName.text = "\(info.goalName ?? "")"
            
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
        if collectionView == self.collectionView {
//            self.selectedWorkOut.append(self.workOutArray[indexPath.item].id ?? 0)
//            self.collectionView.reloadData()
            
                if self.selectedWorkOut.contains(self.workOutArray[indexPath.item].id ?? 0) {
                    if let selectedIndex = selectedWorkOut.firstIndex(where: {$0 == self.workOutArray[indexPath.item].id}) {
                        self.selectedWorkOut.remove(at: selectedIndex)
                    }
                }
                else {
                    self.selectedWorkOut.append(self.workOutArray[indexPath.item].id ?? 0)
                }
                self.collectionView.reloadData()
            
                        
        } else if collectionView == collectionView2 {
            if self.selectedLevel.count == 0 {
                self.selectedLevel.append(self.levelArray[indexPath.item].id ?? 0)
                self.collectionView2.reloadData()
            } else {
                self.selectedLevel.removeAll()
                self.selectedLevel.append(self.levelArray[indexPath.item].id ?? 0)
                self.collectionView2.reloadData()
            }
        }
        else if collectionView == rightTagCollView {
//            self.selectedGoal.append(self.goalArray[indexPath.item].id ?? 0)
//            self.rightTagCollView.reloadData()
            
            if self.selectedGoal.contains(self.goalArray[indexPath.item].id ?? 0) {
                if let selectedIndex = selectedGoal.firstIndex(where: {$0 == self.goalArray[indexPath.item].id}) {
                    self.selectedGoal.remove(at: selectedIndex)
                }
            }
            else {
                self.selectedGoal.append(self.goalArray[indexPath.item].id ?? 0)
            }
            self.rightTagCollView.reloadData()
            
        }
    }
    
}

//MARK:  set collectionview cell data in center

class CollectionViewRow {
    var attributes = [UICollectionViewLayoutAttributes]()
    var spacing: CGFloat = 0
    
    init(spacing: CGFloat) {
        self.spacing = spacing
    }
    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }
    var rowWidth: CGFloat {
        return attributes.reduce(0, { result, attribute -> CGFloat in
            return result + attribute.frame.width
        }) + CGFloat(attributes.count - 1) * spacing
    }
    func centerLayout(collectionViewWidth: CGFloat) {
        let padding = (collectionViewWidth - rowWidth) / 2
        var offset = padding
        for attribute in attributes {
            attribute.frame.origin.x = offset
            offset += attribute.frame.width + spacing
        }
    }
}

class UICollectionViewCenterLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        var rows = [CollectionViewRow]()
        var currentRowY: CGFloat = -1
        
        for attribute in attributes {
            if currentRowY != attribute.frame.midY {
                currentRowY = attribute.frame.midY
                rows.append(CollectionViewRow(spacing: 10))
            }
            rows.last?.add(attribute: attribute)
        }
        rows.forEach { $0.centerLayout(collectionViewWidth: collectionView?.frame.width ?? 0) }
        return rows.flatMap { $0.attributes }
    }
}


//MARK:  set collectionview cell data in left Side

class SingleColumnLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        let attributes = super.layoutAttributesForElements(in: rect)
        let ltr = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight
        var leftMargin = ltr ? sectionInset.left : (rect.maxX - sectionInset.right)
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY
            {
                leftMargin = ltr ? sectionInset.left : (rect.maxX - sectionInset.right)
            }
            
            layoutAttribute.frame.origin.x = leftMargin - (ltr ? 0 : layoutAttribute.frame.width)
            
            if (ltr)
            {
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            }
            else
            {
                leftMargin -= layoutAttribute.frame.width + minimumInteritemSpacing
            }
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        
        return attributes
    }
}

class leftSideDataInColl: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        return attributes
    }
}



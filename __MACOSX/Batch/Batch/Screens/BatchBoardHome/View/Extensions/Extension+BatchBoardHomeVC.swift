//
//  Extension+BatchBoardHomeVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//
// com.BatchiOS - clint Bundle id
// com.demoAppJay - jay

import Foundation
import UIKit

extension BatchBoardHomeVC : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.tag == 1501)
        {
            return self.imgArr.count
        }
        else if (collectionView.tag == 1502)
        {
            return 6
        }
        else if (collectionView.tag == 1503)
        {
            return 6
        }
        else if (collectionView.tag == 1504)
        {
            return 6
        }
        else if (collectionView.tag == 1505)
        {
            return 6
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView.tag == 1501)
        {
            let cell = collectionView.dequeue(BatchHomePageContCollViewCell.self, indexPath)
            cell.pageControllImgView.image = UIImage(named: self.imgArr[indexPath.item])
            
            return cell
        }
        else if (collectionView.tag == 1502)
        {
            let cell = collectionView.dequeue(BWOBatchesListCollCell.self, indexPath)
            return cell
        }
        else if (collectionView.tag == 1503)
        {
            let cell = collectionView.dequeue(BWOMotivatorsListCollCell.self, indexPath)
            return cell
        }
        else if (collectionView.tag == 1504)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealPlanCollectionCell", for: indexPath)  as! MealPlanCollectionCell
            return cell
        }
        else if (collectionView.tag == 1505)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealPlanCollectionCell", for: indexPath)  as! MealPlanCollectionCell
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
         let vc = BWorkOutMotivatorDetailVC.instantiate(fromAppStoryboard: .batchTrainings)
         vc.modalPresentationStyle = .overFullScreen
         vc.modalTransitionStyle = .coverVertical
         self.present(vc, animated: true)
         */
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //        if (collectionView.tag == 1501)
        //        {
        //            pageControl.currentPage = indexPath.item
        //             
        //             let indexValue = indexPath.item //Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        //             pageControl?.currentPage = indexValue
        //        }
    }
    
    /*
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
     */
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView == pageControllCollView)
        {
            let width = scrollView.frame.width
            currentPage = Int(scrollView.contentOffset.x / width)
        }
    }
    
}

extension BatchBoardHomeVC : UICollectionViewDelegateFlowLayout
{
    @objc(collectionView:layout:sizeForItemAtIndexPath:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let screenSize              = collectionView.frame.size //UIScreen.main.bounds
        //        let screenSize              = UIScreen.main.bounds
        let screenWidth             = screenSize.width
        let cellSquareSize: CGFloat = screenWidth
        
        if (collectionView.tag == 1501)
        {
            return CGSize.init(width: cellSquareSize - 20 , height: 100)//140
        }
        else if (collectionView.tag == 1502)
        {
            return CGSize.init(width: cellSquareSize, height: 120)
        }
        else if (collectionView.tag == 1503)
        {
            return CGSize.init(width: cellSquareSize, height: 120)
        }
        else if (collectionView.tag == 1504)
        {
            return CGSize.init(width: cellSquareSize, height: 120)
        }
        else if (collectionView.tag == 1505)
        {
            return CGSize.init(width: cellSquareSize, height: 120)
        }
        else
        {
            return CGSize.init(width: cellSquareSize, height: 120)
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
        return 5
    }
    
    @objc(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 5
    }
}

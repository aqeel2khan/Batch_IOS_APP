//
//  Extension+OnBoardingScreenVC.swift
//  Batch
//
//  Created by shashivendra sengar on 17/12/23.
//

import UIKit
import Foundation

extension OnBoardingScreenVC : UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(OnBoardingCollectionCell.self, indexPath)
        let imgArr = ["image1","image2","image3"]
//        cell.imgOnBoarding.image = UIImage(named: "image1")
        cell.imgOnBoarding.image = UIImage(named: imgArr[indexPath.item])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let wid = (collectionView.frame.width - 10)
//        return CGSize(width: wid, height: 300)
        let wid = (collectionView.frame.width )
        let height = (collectionView.frame.height )
        return CGSize(width: wid, height: height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}

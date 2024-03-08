//
//  Extension+MealBatchVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//

import Foundation
import UIKit

extension QuestionAllergyVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return algeryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(QuestionAllergyCollectionCell.self, indexPath)
        cell.alergyName.text = algeryList[indexPath.row].name
        cell.alergyImage.sd_setImage(with: URL(string: BaseUrl.imageBaseUrl + (algeryList[indexPath.row].icon)) , placeholderImage:nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell : QuestionAllergyCollectionCell = collectionView.cellForItem(at: indexPath) as! QuestionAllergyCollectionCell
        cell.optionUIView.backgroundColor = Colors.appThemeBackgroundColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell : QuestionAllergyCollectionCell = collectionView.cellForItem(at: indexPath) as! QuestionAllergyCollectionCell
        cell.optionUIView.backgroundColor = Colors.appViewBackgroundColor
    }
}

extension QuestionAllergyVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = allergyCollectionView.frame.width / 3 - 10
        
        return CGSize(width:widthPerItem, height:100)
    }
    
    
}

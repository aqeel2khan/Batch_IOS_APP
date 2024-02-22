//
//  MealplanRatingVC.swift
//  Batch
//
//  Created by Chawtech on 29/01/24.
//

import UIKit
import SwiftyStarRatingView

class MealplanRatingVC: UIViewController {

    @IBOutlet weak var ratingView: SwiftyStarRatingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK:= chnage rating Value
    
    @IBAction func chnageRatingValueAction(_ sender: SwiftyStarRatingView) {
        print(ratingView.value)
        
    }
    
    
    @IBAction func skipActionBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    


}

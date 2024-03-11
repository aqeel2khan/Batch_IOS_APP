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
    
    @IBOutlet weak var reviewTextView: UITextView!
    var postReviewRequest: PostReviewRequest?
    override func viewDidLoad() {
        super.viewDidLoad()
        postReviewRequest?.rating = "\(ratingView.value)"
    }
    //MARK:= change rating Value
    @IBAction func chnageRatingValueAction(_ sender: SwiftyStarRatingView) {
        print(ratingView.value)
        postReviewRequest?.rating = "\(ratingView.value)"
    }
    
    @IBAction func skipActionBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        postReviewRequest?.review = reviewTextView.text
        guard let review = postReviewRequest?.review, !review.isEmpty else {
            self.showAlert(message: "Please enter review text")
            return
        }
        guard let rating = postReviewRequest?.rating, !rating.isEmpty else {
            self.showAlert(message: "Please select rating")
            return
        }
        self.postDishReview()
    }
    
    public func postDishReview() {
        
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        var urlStr = API.postDishReview
        postReviewRequest?.userName = "Anonymous"
        guard let reviewRequest = postReviewRequest else {
            return
        }
        bMealViewModel.postReviewForDish(urlStr: urlStr, request: reviewRequest) { (response) in
            if response.status == true {
                DispatchQueue.main.async {
                    hideLoading()
                    self.dismiss(animated: true) {
                    }
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.dismiss(animated: true)
                    self.showAlert(message: "Something Went wrong")
                }
            }
            
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.dismiss(animated: true)
                self.showAlert(message: error.localizedDescription)

            }
        }
    }
}

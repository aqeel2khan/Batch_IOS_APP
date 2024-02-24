//
//  BPromoCodePopUpVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 21/01/24.
//

import UIKit
import DropDown


class BPromoCodePopUpVC: UIViewController {
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var addPromoCodeTextField: UITextField!
    
    @IBOutlet weak var dropDownBtn: UIButton!
    
    lazy var promoCodeDropDown = DropDown()
    var promocodeDDArr = [GetPromocodeList]()
    var promocodeArr   = [String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
        if internetConnection.isConnectedToNetwork() == true {
            // Call Api here
            getPromoCodes()
        }
        else
        {
            self.showAlert(message: "Please check your internet", title: "Network issue")
        }
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    private func createDropDownForPromoCode(){
        
        promoCodeDropDown.anchorView = dropDownBtn
        promoCodeDropDown.dismissMode = .automatic
        promoCodeDropDown.direction = .bottom
        promoCodeDropDown.bottomOffset = CGPoint(x: 10, y: dropDownBtn.bounds.height)
        promoCodeDropDown.width = dropDownBtn.frame.width - 20
        //        var countryList = [String]()
        //        countries.forEach { (country) in
        //            countryList.append(country.country!)
        //        }
        promoCodeDropDown.dataSource = promocodeArr
        promoCodeDropDown.show()
        
        promoCodeDropDown.selectionAction  = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.addPromoCodeTextField.text = item
            
        }
    }
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func onTapSaveBtn(_ sender: Any) {
        
        self.dismiss(animated: true)
        
//        let promoCodeStr = self.addPromoCodeTextField.text ?? ""
//        if promoCodeStr != ""
//        {
//        if internetConnection.isConnectedToNetwork() == true {
//            // Call Api here
//            //            self.addPromoCodes(courseId: "28", promoCode: promoCodeStr)
//        }
//        else
//        {
//            self.showAlert(message: "Please check your internet", title: "Network issue")
//        }
        
//        }
        
        //        let vc = BPromoCodeSucessfulPopUpVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
        //        vc.modalPresentationStyle = .overFullScreen
        //        vc.modalTransitionStyle = .coverVertical
        //        self.present(vc, animated: true)
    }
    
    @IBAction func onTapAddPromoCodeBtn(_ sender: Any) {
        self.createDropDownForPromoCode()
    }
    
    
    private func getPromoCodes(){
        DispatchQueue.main.async {
            showLoading()
        }
        let bPromoCodePopUpViewModel = BPromoCodePopUpViewModel()
        let urlStr = API.getPromoCodeList
        bPromoCodePopUpViewModel.getPromoCodeApi(requestUrl: urlStr)  { (response) in
            
            if response.status == true, response.data?.count != 0 {
                print(response.data)
                self.promocodeDDArr = response.data?.list ?? []
                
                self.promocodeArr.removeAll()
                for i in 0..<self.promocodeDDArr.count
                {
                    let promoCode = self.promocodeDDArr[i].promoCode
                    if promoCode != ""
                    {
                        self.promocodeArr.append(promoCode ?? "")
                    }
                }
                DispatchQueue.main.async {
                    hideLoading()
                    // self.blogTableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    //makeToast(response.message!)
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                // makeToast(error.localizedDescription)
            }
        }
    }
    
    private func addPromoCodes(courseId:String, promoCode:String){
        
        let request = PromoCodeRequest(courseID: "\(courseId)", promoCode: "\(promoCode)")
        DispatchQueue.main.async {
            showLoading()
        }
        let bPromoCodePopUpViewModel = BPromoCodePopUpViewModel()
        let urlStr = API.addPromoCode
        bPromoCodePopUpViewModel.addPromoCodeApi(request: request) { (response) in
            
            if response.status == true {
                print(response.data)
                // self.blogsArray = response.data!
                DispatchQueue.main.async {
                    hideLoading()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    //makeToast(response.message!)
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                // makeToast(error.localizedDescription)
            }
        }
    }
}

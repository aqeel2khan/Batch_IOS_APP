//
//  BPaymentGatewayPopUpVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 29/02/24.
//

import UIKit
import MFSDK

class BPaymentGatewayPopUpVC: UIViewController {
    //MARK: Outlet
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    //MARK: Variables
    var paymentMethods: [MFPaymentMethod]?
    var selectedPaymentMethodIndex: Int?
    var amountStr: String?
    var errorCodeStr: String?
    var resultStr:String?
    //at list one product Required
    let productList = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payButton.isEnabled = false
        //Initiate Payment
        initiatePayment()
        // set delegate
        MFSettings.shared.delegate = self
        
        //Register Table cell
        tblView.register(UINib(nibName: "PaymentMethodTblViewCell", bundle: .main), forCellReuseIdentifier: "PaymentMethodTblViewCell")
        
        amountStr = "0.1"
        
    }
    @IBAction func payDidPressed(_ sender: Any) {
        if let paymentMethods = paymentMethods, !paymentMethods.isEmpty {
            if let selectedIndex = selectedPaymentMethodIndex {
                
                executePayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
                
                /*
                 if paymentMethods[selectedIndex].paymentMethodCode == MFPaymentMethodCode.applePay.rawValue {
                 executeApplePayPayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
                 } else if paymentMethods[selectedIndex].isDirectPayment {
                 executeDirectPayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
                 } else {
                 executePayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
                 }
                 */
            }
        }
    }
    
}

extension BPaymentGatewayPopUpVC  {
    
    func showSuccess(_ message: String) {
        errorCodeStr = "Succes"
        resultStr = "result: \(message)"
    }
    
    func showFailError(_ error: MFFailResponse) {
        errorCodeStr = "responseCode: \(error.statusCode)"
        resultStr = "Error: \(error.errorDescription)"
    }
}

extension BPaymentGatewayPopUpVC: MFPaymentDelegate {
    func didInvoiceCreated(invoiceId: String) {
        print("#Invoice id:", invoiceId)
    }
}

//
//  MFSDKServicesCall+BPaymentGatewayPopUpVC .swift
//  Batch
//
//  Created by CTS-Jay Gupta on 29/02/24.
//

import MFSDK

extension BPaymentGatewayPopUpVC {
    func initiatePayment() {
        let request = generateInitiatePaymentModel()
        DispatchQueue.main.async {
            showLoading()
        }
        MFPaymentRequest.shared.initiatePayment(request: request, apiLanguage: .english, completion: { [weak self] (result) in
            DispatchQueue.main.async {
                hideLoading()
            }
            switch result {
            case .success(let initiatePaymentResponse):
                self?.paymentMethods = initiatePaymentResponse.paymentMethods
                self?.tblView.reloadData()
            case .failure(let failError):
                self?.showFailError(failError)
            }
        })
    }
    
    func executePayment(paymentMethodId: Int) {
        let request = getExecutePaymentRequest(paymentMethodId: paymentMethodId)
        DispatchQueue.main.async {
            showLoading()
        }
        MFPaymentRequest.shared.executePayment(request: request, apiLanguage: .english) { [weak self] response, invoiceId  in
            DispatchQueue.main.async {
                hideLoading()
            }
            switch response {
            case .success(let executePaymentResponse):
                
                if let invoiceStatus = executePaymentResponse.invoiceStatus {
                    self?.showSuccess(invoiceStatus)
                    self?.dismiss(animated: true)
                    self?.completion?(executePaymentResponse.invoiceTransactions?[0].transactionID ?? "0")

//                    self?.dismiss(animated: false, completion: {
//                        self?.completion?(executePaymentResponse.invoiceTransactions?[0].transactionID ?? "0")
//                    })
                }
            case .failure(let failError):
                self?.showFailError(failError)
            }
        }
    }
}

extension BPaymentGatewayPopUpVC {
    private func generateInitiatePaymentModel() -> MFInitiatePaymentRequest {
        // you can create initiate payment request with invoice value and currency
        // let invoiceValue = Double(amountTextField.text ?? "") ?? 0
        // let request = MFInitiatePaymentRequest(invoiceAmount: invoiceValue, currencyIso: .kuwait_KWD)
        // return request
        
        let request = MFInitiatePaymentRequest()
        return request
    }
    private func getExecutePaymentRequest(paymentMethodId: Int) -> MFExecutePaymentRequest {
        let invoiceValue = Decimal(string: totalOrderAmount ?? "0") ?? 0
        let request = MFExecutePaymentRequest(invoiceValue: invoiceValue , paymentMethod: paymentMethodId)
        //request.userDefinedField = ""
        request.customerEmail = "test@myfatoorah.com"// must be email
        request.customerMobile = "112233"
        request.customerCivilId = "1234567890"
        request.customerName = "Test MyFatoorah"
        let address = MFCustomerAddress(block: "ddd", street: "sss", houseBuildingNo: "sss", address: "sss", addressInstructions: "sss")
        request.customerAddress = address
        request.customerReference = "Test MyFatoorah Reference"
        request.language = .english
        request.mobileCountryCode = MFMobileCountryCodeISO.kuwait.rawValue
        request.displayCurrencyIso = .kuwait_KWD
        //        request.recurringModel = MFRecurringModel(recurringType: .weekly, iteration: 2)
        //        request.supplierValue = 1
        //        request.supplierCode = 2
        //        request.suppliers.append(MFSupplier(supplierCode: 1, proposedShare: 2, invoiceShare: invoiceValue))
        
        // Uncomment this to add products for your invoice
        //         var productList = [MFProduct]()
        //        let product = MFProduct(name: "ABC", unitPrice: 1.887, quantity: 1)
        //         productList.append(product)
        //         request.invoiceItems = productList
        return request
    }
 
}

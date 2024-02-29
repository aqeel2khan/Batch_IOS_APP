//
//  Extension+BPaymentGatewayPopUpVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 29/02/24.
//

import Foundation
import UIKit

extension BPaymentGatewayPopUpVC:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let paymentMethods = paymentMethods else {
            return 0
        }
        return paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(PaymentMethodTblViewCell.self,for: indexPath)
        
        if let paymentMethods = paymentMethods, !paymentMethods.isEmpty {
            let selectedIndex = selectedPaymentMethodIndex ?? -1
            cell.configure(paymentMethod: paymentMethods[indexPath.row], selected: selectedIndex == indexPath.row)
        }
        return cell
    }
}

extension BPaymentGatewayPopUpVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedPaymentMethodIndex = indexPath.row
        payButton.isEnabled = true
        
        //if let paymentMethods = paymentMethods {}
        tblView.reloadData()
    }
}

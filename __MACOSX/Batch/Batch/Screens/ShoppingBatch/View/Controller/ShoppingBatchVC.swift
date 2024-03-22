//
//  ShoppingBatchVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//

import UIKit

class ShoppingBatchVC: UIViewController {
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        customNavigationBar.titleFirstLbl.text = "Shopping"

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

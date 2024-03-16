//
//  MealPlanDeliveryTimeVC.swift
//  Batch
//
//  Created by Krupanshu Sharma on 15/03/24.
//

import UIKit

class MealPlanDeliveryTimeVC: UIViewController, UITableViewDelegate {
    @IBOutlet var mainView: UIView!
    @IBOutlet var tableDeliveryTime: UITableView!
    @IBOutlet var selectedTimeSlotLabel: UITextField!
    var deliveryTimeSlots: [DeliveryTimeSlots] = []
    var selectedTimeSlot: DeliveryTimeSlots?
    var selectedRowIndex: Int?
    var completion: (() ->Void)? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableDeliveryTime.delegate = self
        tableDeliveryTime.dataSource = self
        tableDeliveryTime.register(UINib(nibName: "DeliveryTimeSlotCell", bundle: .main), forCellReuseIdentifier: "DeliveryTimeSlotCell")
        tableDeliveryTime.allowsSelection = true
        getDeliveryTimeSlots()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // self.dismiss(animated: true)
    }
    
    @IBAction func backactionBtn(_ sender: UIButton) {
        MealSubscriptionManager.shared.deliveryTime = selectedTimeSlot?.timeSlot
        MealSubscriptionManager.shared.deliveryTimeId = selectedTimeSlot?.id
        self.dismiss(animated: true)
    }

    @IBAction func btnApplyAction(_ sender: UIButton) {
        MealSubscriptionManager.shared.deliveryTime = selectedTimeSlot?.timeSlot
        MealSubscriptionManager.shared.deliveryTimeId = selectedTimeSlot?.id
        self.dismiss(animated: true)
        completion?()
    }
    
    func getDeliveryTimeSlots() {
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealCoViewModel = BMealPlanCheckoutViewModel()
        let urlStr = API.deliveryTimeList
        bMealCoViewModel.getDeliveryTimeSlots(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.data?.count != 0 {
                self.deliveryTimeSlots.removeAll()
                self.deliveryTimeSlots = response.data?.data ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    self.tableDeliveryTime.reloadData()
                    self.selectFirstRow()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
            }
        }
    }
    
    func selectFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableDeliveryTime.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        tableView(tableDeliveryTime, didSelectRowAt: indexPath)
    }

}

extension MealPlanDeliveryTimeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.deliveryTimeSlots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(DeliveryTimeSlotCell.self, for: indexPath)
        cell.selectionStyle = .default
        cell.lblTimeSlot.text = self.deliveryTimeSlots[indexPath.row].timeSlot
        if let selectedRowIndex = selectedRowIndex, selectedRowIndex == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTimeSlot = self.deliveryTimeSlots[indexPath.row]
        
        if let selectedRowIndex = selectedRowIndex {
            let previousSelectedIndexPath = IndexPath(row: selectedRowIndex, section: 0)
            tableView.cellForRow(at: previousSelectedIndexPath)?.accessoryType = .none
        }
        
        // Update the selected row index
        selectedRowIndex = indexPath.row
        
        // Update the selection state of the current row
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        selectedTimeSlotLabel.text = selectedTimeSlot?.timeSlot
    }
}


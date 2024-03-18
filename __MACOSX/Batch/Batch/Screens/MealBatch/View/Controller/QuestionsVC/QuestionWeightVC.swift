//
//  QuestionWeightVC.swift
//  Batch
//
//  Created by Chawtech on 31/01/24.
//

import UIKit

class QuestionWeightVC: UIViewController {    
    @IBOutlet weak var customNavigationBar: CustomSecondNavigationBar!
    @IBOutlet weak var currentWeightPicker: LKRulerPicker!
    @IBOutlet weak var targetWeightPicker: LKRulerPicker!
    @IBOutlet weak var currentWeightSegmentControl: UISegmentedControl!
    @IBOutlet weak var targetWeightSegmentControl: UISegmentedControl!

    let weightMetrics = LKRulerPickerConfiguration.Metrics(
        minimumValue: 0,
        defaultValue: 50,
        maximumValue: 250,
        divisions: 10,
        fullLineSize: 50,
        midLineSize: 40,
        smallLineSize: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()  
        
        setupNavigationBar()
        configureCurrentWeightPicker()
        configureTargetWeightPicker()
        
        
    }
    
    // MARK: - UI
    private func setupNavigationBar() {
        customNavigationBar.titleLbl.isHidden = false
        customNavigationBar.titleLbl.text = CustomNavTitle.qustionVCTitle.localized
    }
    
    @IBAction func nextActionBtn(_ sender: BatchButton) {
        AnswerStruct.current_weight = rulerPicker(currentWeightPicker, highlightTitleForIndex: currentWeightPicker.highlightedIndex) ?? "0"
        AnswerStruct.target_weight = rulerPicker(currentWeightPicker, highlightTitleForIndex: targetWeightPicker.highlightedIndex) ?? "0"
        
        if AnswerStruct.current_weight == "0" || AnswerStruct.current_weight == "0.0" {
            showAlert(message: "Please select Current Weight".localized)
        } else if AnswerStruct.target_weight == "0" || AnswerStruct.target_weight == "0.0" {
            showAlert(message: "Please select Target Weight".localized)
        } else {
            let vc = QuestionActivityVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
    }
    
    private func configureCurrentWeightPicker() {
        currentWeightPicker.configuration = LKRulerPickerConfiguration(scrollDirection: .horizontal, alignment: .end, metrics: weightMetrics)

        currentWeightPicker.font = UIFont.systemFont(ofSize: 16)
        currentWeightPicker.highlightFont = UIFont.boldSystemFont(ofSize: 24)

        currentWeightPicker.dataSource = self
        currentWeightPicker.delegate = self
        
        currentWeightPicker.tintColor = UIColor.black.withAlphaComponent(0.5)
        currentWeightPicker.highlightLineColor = .black
        currentWeightPicker.highlightTextColor = .black
        currentWeightPicker.backgroundColor = .white
        currentWeightPicker.layoutIfNeeded()

    }
    
    
    private func configureTargetWeightPicker() {
        targetWeightPicker.configuration = LKRulerPickerConfiguration(scrollDirection: .horizontal, alignment: .end, metrics: weightMetrics)

        targetWeightPicker.font = UIFont.systemFont(ofSize: 16)
        targetWeightPicker.highlightFont = UIFont.boldSystemFont(ofSize: 24)

        targetWeightPicker.dataSource = self
        targetWeightPicker.delegate = self
        
        targetWeightPicker.tintColor = UIColor.black.withAlphaComponent(0.5)
        targetWeightPicker.highlightLineColor = .black
        targetWeightPicker.highlightTextColor = .black
        targetWeightPicker.backgroundColor = .white
    }
    
    @IBAction func currentSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        currentWeightPicker.reload()
        if let WeightText = rulerPicker(currentWeightPicker, highlightTitleForIndex: currentWeightPicker.highlightedIndex) {
            currentWeightPicker.updateCenterText(highlightText: WeightText)
            print("Current Weight: \(WeightText)")
        }
    }
    
    @IBAction func targetSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        targetWeightPicker.reload()
        if let WeightText = rulerPicker(targetWeightPicker, highlightTitleForIndex: targetWeightPicker.highlightedIndex) {
            targetWeightPicker.updateCenterText(highlightText: WeightText)
            print("Target Weight: \(WeightText)")
        }
    }
}


extension QuestionWeightVC: LKRulerPickerDelegate {
    func rulerPicker(_ picker: LKRulerPicker, didSelectItemAtIndex index: Int) {
        print(rulerPicker(picker, highlightTitleForIndex: index) ?? "")
    }
}

extension QuestionWeightVC: LKRulerPickerDataSource {
    func rulerPicker(_ picker: LKRulerPicker, titleForIndex index: Int) -> String? {
        guard index % picker.configuration.metrics.divisions == 0 else { return nil }
        switch picker {
         case currentWeightPicker:
            return currentWeightSegmentControl.selectedSegmentIndex == 0 ? "\(picker.configuration.metrics.minimumValue + index)" :
            "\(Double(Double(picker.configuration.metrics.minimumValue + index) * 2.20462).rounded(toPlaces: 2))"
        case targetWeightPicker:
           return targetWeightSegmentControl.selectedSegmentIndex == 0 ? "\(picker.configuration.metrics.minimumValue + index)" :
           "\(Double(Double(picker.configuration.metrics.minimumValue + index) * 2.20462).rounded(toPlaces: 2))"
        default:
            fatalError("Handler picker")

        }
        
    }
    
    func rulerPicker(_ picker: LKRulerPicker, highlightTitleForIndex index: Int) -> String? {
        switch picker {
        case currentWeightPicker:
            return currentWeightSegmentControl.selectedSegmentIndex == 0 ? "\(picker.configuration.metrics.minimumValue + index)" :             "\(Double(Double(picker.configuration.metrics.minimumValue + index) * 2.20462).rounded(toPlaces: 2))"
        case targetWeightPicker:
            return targetWeightSegmentControl.selectedSegmentIndex == 0 ? "\(picker.configuration.metrics.minimumValue + index)" :             "\(Double(Double(picker.configuration.metrics.minimumValue + index) * 2.20462).rounded(toPlaces: 2))"
        default:
            fatalError("Handler picker")

        }
    }
}

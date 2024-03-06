//
//  QuestionHeightVC.swift
//  Batch
//
//  Created by Chawtech on 31/01/24.
//

import UIKit

class QuestionHeightVC: UIViewController {
    @IBOutlet weak var customNavigationBar: CustomSecondNavigationBar!
    @IBOutlet weak var heightPickerUIView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // Added Programatically
    private lazy var heightPicker: LKRulerPicker = {
        $0.dataSource = self
        $0.delegate = self
        $0.tintColor = UIColor.black.withAlphaComponent(0.5)
        $0.highlightLineColor = .black
        $0.highlightTextColor = .black
        $0.backgroundColor = .clear
        return $0
    }(LKRulerPicker())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHeightPicker()
        
        setupNavigationBar()
    }
    
    // MARK: - UI
    
    private func setupNavigationBar() {
        customNavigationBar.titleLbl.isHidden = false
        customNavigationBar.titleLbl.text = CustomNavTitle.qustionVCTitle
    }
    
    private func addHeightPicker() {
        //        let _ = view
        heightPickerUIView.addSubview(heightPicker)
        heightPicker.translatesAutoresizingMaskIntoConstraints = false
        heightPicker.backgroundColor = Colors.appViewBackgroundColor
        heightPicker.font = UIFont.systemFont(ofSize: 16)
        heightPicker.highlightFont = UIFont.boldSystemFont(ofSize: 24)

        NSLayoutConstraint.activate([
            heightPicker.topAnchor.constraint(equalTo: heightPicker.superview!.topAnchor, constant: 0),
            heightPicker.bottomAnchor.constraint(equalTo: heightPicker.superview!.bottomAnchor, constant: 0),
            heightPicker.centerXAnchor.constraint(equalTo: heightPicker.superview!.centerXAnchor, constant: 0),
            heightPicker.widthAnchor.constraint(equalToConstant: 125),
        ])
        
        //        heightPicker.layoutSubviews()
        //        heightPicker.reload()
        heightPicker.layoutIfNeeded()
        
        let heightMetrics = LKRulerPickerConfiguration.Metrics(
            minimumValue: 50,
            defaultValue: 150,
            maximumValue: 300,
            divisions: 5,
            fullLineSize: 60,
            midLineSize: 35,
            smallLineSize: 25)
        heightPicker.configuration = LKRulerPickerConfiguration(
            scrollDirection: .vertical,
            alignment: .start,
            metrics: heightMetrics,
            isHapticsEnabled: false)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        heightPicker.reload()
        if let heightText = rulerPicker(heightPicker, highlightTitleForIndex: heightPicker.highlightedIndex) {
            heightPicker.updateCenterText(highlightText: heightText)
            print("Height: \(heightText)")
        }  
    }
 
    @IBAction func nextActionBtn(_ sender: BatchButton) {
        let vc = QuestionWeightVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
}

extension QuestionHeightVC: LKRulerPickerDelegate {
    func rulerPicker(_ picker: LKRulerPicker, didSelectItemAtIndex index: Int) {
        print(rulerPicker(picker, highlightTitleForIndex: index) ?? 0)
    }
}

extension QuestionHeightVC: LKRulerPickerDataSource {
    func rulerPicker(_ picker: LKRulerPicker, titleForIndex index: Int) -> String? {
        guard index % picker.configuration.metrics.divisions == 0 else { return nil }
        switch picker {
        case heightPicker:
            return segmentControl.selectedSegmentIndex == 0 ? "\(picker.configuration.metrics.minimumValue + index)" :
            "\(Double(Double(picker.configuration.metrics.minimumValue + index) * 0.0328084).rounded(toPlaces: 2))"
                default:
            fatalError("Handler picker")
        }
    }
    
    func rulerPicker(_ picker: LKRulerPicker, highlightTitleForIndex index: Int) -> String? {
        switch picker {
        case heightPicker:
            return segmentControl.selectedSegmentIndex == 0 ? "\(picker.configuration.metrics.minimumValue + index)" :             "\(Double(Double(picker.configuration.metrics.minimumValue + index) * 0.0328084).rounded(toPlaces: 2))"
        default:
            fatalError("Handler picker")
        }
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

//
//  BatchSegmentedControl.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//

import UIKit

class BatchSegmentedControl: UISegmentedControl {
    
    private(set) lazy var radius:CGFloat = bounds.height / 2
    
    /// Configure selected segment inset, can't be zero or size will error when click segment
    private var segmentInset: CGFloat = 5.0{
        didSet{
            if segmentInset == 0{
                segmentInset = 5
            }
        }
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        selectedSegmentIndex = 0
    }
    
    required init?(coder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
    }
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
        self.backgroundColor = Colors.appViewBackgroundColor
        
        /// Set the title for the first segment (index 0)
        self.setTitle(self.titleForSegment(at: 0)?.localized, forSegmentAt: 0)
        
        // Set the title for the second segment (index 1)
        self.setTitle(self.titleForSegment(at: 1)?.localized, forSegmentAt: 1)
        
        /// Set font size and font color
        self.setTitleTextAttributes([.foregroundColor: UIColor.darkGray, .font: FontSize.mediumSize16!], for: .normal)
        self.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: FontSize.mediumSize16!], for: .selected)
        
        //MARK: - Configure Background Radius
        self.layer.cornerRadius = self.radius
        self.layer.masksToBounds = true
        
        //MARK: - Find selectedImageView
        let selectedImageViewIndex = numberOfSegments
        if let selectedImageView = subviews[selectedImageViewIndex] as? UIImageView
        {
            //MARK: - Configure selectedImageView Color
            selectedImageView.backgroundColor = Colors.appThemeSelectionColor
            selectedImageView.image = nil
            
            //MARK: - Configure selectedImageView Inset with SegmentControl
            selectedImageView.bounds = selectedImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            
            //MARK: - Configure selectedImageView cornerRadius
            selectedImageView.layer.masksToBounds = true
            selectedImageView.layer.cornerRadius = self.radius
            
            selectedImageView.layer.removeAnimation(forKey: "SelectionBounds")
            
        }
        
    }
    
}

//
//  SleepHealthCell.swift
//  Batch
//
//  Created by Vijay Singh on 11/03/24.
//

import UIKit
import DGCharts

class SleepHealthCell: UITableViewCell {

    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var sleepLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var sleepLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeIcon: UIImageView!

    @IBOutlet weak var pieChartView: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
   
    
}


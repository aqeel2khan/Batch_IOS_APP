//
//  Extension+QuestionGoalVC.swift
//  Batch
//
//  Created by Hari Mohan on 09/03/24.
//

import UIKit

extension QuestionActivityVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(QuestionLabelTVC.self, for: indexPath)
        cell.titleLbl.text = self.activityList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell : QuestionLabelTVC = tblView.cellForRow(at: indexPath) as! QuestionLabelTVC
        cell.questionUIView.backgroundColor = Colors.appThemeBackgroundColor
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell : QuestionLabelTVC = tblView.cellForRow(at: indexPath) as! QuestionLabelTVC
        cell.questionUIView.backgroundColor = Colors.appViewBackgroundColor
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 //UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
    }
}

//
//  VimoPlayerVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 18/02/24.
//

import UIKit
import HCVimeoVideoExtractor

class VimoPlayerVC: UIViewController {
    
    @IBOutlet weak var vimoVideoTbl: UITableView!
    @IBOutlet weak var dayCountLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var selectedVideoViewTbl: UITableView!
    @IBOutlet weak var timeTitleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    var courseDurationExerciseArr = [CourseDurationExercise]()
    var courseDetail: CourseDetail!
    var todayWorkoutsInfo : TodayWorkoutsElement!

    var refreshControl: UIRefreshControl!
    var completion: (()->Void)? = nil
    var viemoVideoArr = [String]()
    var titleText = "Lower-Body Burn"
    var dayNumberText : String!

    var selectedIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTimeValue()
        
        if dayNumberText.contains("Day") {
            dayCountLbl.text = dayNumberText.substring(fromIndex: 4)
        } else {
            dayCountLbl.text = "Day".localized + " : " + dayNumberText
        }
                
        print("OUR FINAL VIDEO URL")
        print(viemoVideoArr)
        
        self.vimoVideoTbl.delegate = self
        self.vimoVideoTbl.dataSource = self
        
        self.vimoVideoTbl.register(UINib(nibName: "VimoPlayerCell", bundle: .main), forCellReuseIdentifier: "VimoPlayerCell")
        self.selectedVideoViewTbl.register(UINib(nibName: "VideoThunbListTblCell", bundle: .main), forCellReuseIdentifier: "VideoThunbListTblCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.appEnteredFromBackground), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func setUpTimeValue() {
        titleLbl.text = self.courseDurationExerciseArr[selectedIndex].title
        
        var timeTextTitle = ""
        var timeText = ""
        if self.courseDurationExerciseArr[selectedIndex].exerciseSet != nil {
            timeTextTitle = "S/"
            timeText = "\(self.courseDurationExerciseArr[selectedIndex].exerciseSet ?? "")/"
        }
        
        if self.courseDurationExerciseArr[selectedIndex].exerciseWraps != nil {
            timeTextTitle = timeTextTitle + "R/"
            timeText = timeText + "\(self.courseDurationExerciseArr[selectedIndex].exerciseWraps ?? "")/"
        }
        
        if self.courseDurationExerciseArr[selectedIndex].exerciseTime != nil {
            timeTextTitle = timeTextTitle + "T/"
            timeText = timeText + "\(self.courseDurationExerciseArr[selectedIndex].exerciseTime ?? "")/"
        }
        
        timeTitleLbl.text = String(timeTextTitle.dropLast())
        timeLbl.text =  String(timeText.dropLast())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        vimoVideoSetUp(stingUrl:vimoBaseUrl + vimoVideoID[0])
        pausePlayeVideos()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ASVideoPlayerController.sharedVideoPlayer.currentLayer?.player?.pause()
        ASVideoPlayerController.sharedVideoPlayer.videoLayers.layers.removeAll()
    }
    
    //1
    func changeSecondTableViewCellColor(index:Int) {
        for i in 0..<self.viemoVideoArr.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell2 = selectedVideoViewTbl.cellForRow(at: indexPath) as? VideoThunbListTblCell
            
            if i == index {
                // Change the color of the selected index
                cell2?.selectedView.backgroundColor = Colors.appThemeButtonColor
            }
            else {
                // Keep the color white for other cells
                cell2?.selectedView.backgroundColor = Colors.appViewBackgroundColor
            }
            
        }
        
    }
    
    @IBAction func OnTapBackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        completion?()
    }
    
    @IBAction func infoBtnTap(_ sender: Any) {
        if let indexPaths = vimoVideoTbl.indexPathsForVisibleRows {
            for indexPath in indexPaths {
                if vimoVideoTbl.cellForRow(at: indexPath) != nil {
                    let vc = BWorkOutVideoInfoPopUp.instantiate(fromAppStoryboard: .batchTrainings)
                    vc.courseDurationExercise = self.courseDurationExerciseArr[indexPath.row]
                    vc.dayNumberText = self.dayNumberText
                    vc.courseDetail = courseDetail
                    vc.todayWorkoutsInfo = todayWorkoutsInfo
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .coverVertical
                    self.present(vc, animated: true)
                }
            }
        }
    }
}

extension VimoPlayerVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viemoVideoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.selectedVideoViewTbl {
            let cell = tableView.dequeueCell(VideoThunbListTblCell.self,for: indexPath)
            return cell
        }
        else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VimoPlayerCell", for: indexPath) as! VimoPlayerCell
            cell.configureCell(videoUrl: self.viemoVideoArr[indexPath.row])
                       
            cell.dragUpUIView.isHidden = indexPath.row == 0 ? false : true
            cell.bottomView.isHidden = indexPath.row == (self.viemoVideoArr.count - 1) ? false : true
          
            cell.bottomView.layer.zPosition = 1
            cell.dragUpUIView.layer.zPosition = 1

            cell.finishWorkOutBtn.tag = indexPath.row
            cell.finishWorkOutBtn.addTarget(self, action: #selector(finishWorkOutBtnAction(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func startNextWoBtnAction(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    @objc func finishWorkOutBtnAction(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.selectedVideoViewTbl {
            return 50 //UITableView.automaticDimension
        }
        else {
            return tableView.frame.height
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == vimoVideoTbl {
            if let videoCell = cell as? ASAutoPlayVideoLayerContainer, let _ = videoCell.videoURL {
                ASVideoPlayerController.sharedVideoPlayer.removeLayerFor(cell: videoCell)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        changeSecondTableViewCellColor(index:selectedIndex)
        setUpTimeValue()

        pausePlayeVideos()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            pausePlayeVideos()
        }
    }
    
    func pausePlayeVideos(){
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: vimoVideoTbl)
    }
    
    @objc func appEnteredFromBackground() {
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: vimoVideoTbl, appEnteredFromBackground: true)
    }
    
    //2
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        setUpTimeValue()

        print("play video \(indexPath.row)")
        
        if tableView == selectedVideoViewTbl
        {
            print("play video \(indexPath.row)")
            
            //changeSecondTableViewCellColor(index:indexPath.row)
            if self.viemoVideoArr.count != 0
            {
                let cell2 = selectedVideoViewTbl.cellForRow(at: indexPath) as? VideoThunbListTblCell
                
                
                cell2?.selectedView.backgroundColor = Colors.appThemeButtonColor
            }
            
            
        }
    }
}

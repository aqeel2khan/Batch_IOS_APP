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
    var courseDurationExerciseArr = [CourseDurationExercise]()

    var refreshControl: UIRefreshControl!
    var completion: (()->Void)? = nil
    var viemoVideoArr = [String]()
    var titleText = "Lower-Body Burn"
    var dayNumberText : String!

    var selectedIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = titleText
        dayCountLbl.text = dayNumberText
        
        self.vimoVideoTbl.delegate = self
        self.vimoVideoTbl.dataSource = self
        
        self.vimoVideoTbl.register(UINib(nibName: "VimoPlayerCell", bundle: .main), forCellReuseIdentifier: "VimoPlayerCell")
        self.selectedVideoViewTbl.register(UINib(nibName: "VideoThunbListTblCell", bundle: .main), forCellReuseIdentifier: "VideoThunbListTblCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.appEnteredFromBackground), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        vimoVideoSetUp(stingUrl:vimoBaseUrl + vimoVideoID[0])
        pausePlayeVideos()
    }
    
    //1
    func changeSecondTableViewCellColor(index:Int) {
        for i in 0..<self.viemoVideoArr.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell2 = selectedVideoViewTbl.cellForRow(at: indexPath) as? VideoThunbListTblCell
            
            if i == index
            {
                // Change the color of the selected index
                cell2?.selectedView.backgroundColor = Colors.appThemeButtonColor
            }
            else
            {
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

/*
 class VimoPlayerVC: UIViewController {
 
 @IBOutlet weak var vimoVideoTbl: UITableView!
 @IBOutlet weak var selectedVideoViewTbl: UITableView!
 var videoIdInfo: CourseDurationExercise?
 
 var refreshControl: UIRefreshControl!
 var completion: (()->Void)? = nil
 //    var viemoVideoArr = ["Video2", "Video3", "Video4", "Video5", "Video6"]
 var viemoVideoArr = [String]()
 
 //    var viemoVideoArr = ["https://cme-media.vimeocdn.com/f7e60824-9020-4c32-a49e-8c1eb9b4fb6b/edge-cache-token=Expires=1708458605&KeyName=media-cdn-key&Signature=Nxu8hKDckEoqW1OswrdyR8qnjKRXJ7Bp2yJsmut0cHI1JdZEOn1MOSz1qS83wPejzTBbV_jR4VtT3QOMEkJ0CA==/sep/video/55831e9d,615c310c,658851b2,9e926486,fa0eb36b/master.m3u8?query_string_ranges=1", "https://cme-media.vimeocdn.com/f7e60824-9020-4c32-a49e-8c1eb9b4fb6b/edge-cache-token=Expires=1708458605&KeyName=media-cdn-key&Signature=Nxu8hKDckEoqW1OswrdyR8qnjKRXJ7Bp2yJsmut0cHI1JdZEOn1MOSz1qS83wPejzTBbV_jR4VtT3QOMEkJ0CA==/sep/video/55831e9d,615c310c,658851b2,9e926486,fa0eb36b/master.m3u8?query_string_ranges=1"]
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 self.vimoVideoTbl.delegate = self
 self.vimoVideoTbl.dataSource = self
 
 self.vimoVideoTbl.register(UINib(nibName: "VimoPlayerCell", bundle: .main), forCellReuseIdentifier: "VimoPlayerCell")
 
 //        self.selectedVideoViewTbl.register(UINib(nibName: "VideoThunbListTblCell", bundle: .main), forCellReuseIdentifier: "VideoThunbListTblCell")
 
 NotificationCenter.default.addObserver(self, selector: #selector(self.appEnteredFromBackground), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
 }
 override func viewDidAppear(_ animated: Bool) {
 super.viewDidAppear(animated)
 //        vimoVideoSetUp(stingUrl:vimoBaseUrl + vimoVideoID[0])
 pausePlayeVideos()
 }
 
 
 //    func changeSecondTableViewCellColor(index:Int) {
 //        for i in 0..<5 {
 //            let indexPath = IndexPath(row: i, section: 0)
 //            let cell2 = selectedVideoViewTbl.cellForRow(at: indexPath) as? VideoThunbListTblCell
 //
 //            if i == index {
 //                // Change the color of the selected index
 //                cell2?.selectedView.backgroundColor = Colors.appThemeButtonColor
 //            } else {
 //                // Keep the color white for other cells
 //                cell2?.selectedView.backgroundColor = Colors.appViewBackgroundColor
 //            }
 //        }
 //
 //    }
 
 @IBAction func OnTapBackBtn(_ sender: Any) {
 dismiss(animated: true, completion: nil)
 completion?()
 
 }
 }
 
 
 extension VimoPlayerVC: UITableViewDelegate,UITableViewDataSource
 {
 func numberOfSections(in tableView: UITableView) -> Int {
 return 1
 }
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 self.viemoVideoArr.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 //
 //        if tableView == self.selectedVideoViewTbl
 //        {
 //            let cell = tableView.dequeueCell(VideoThunbListTblCell.self,for: indexPath)
 //            return cell
 //        }
 //        else
 //        {
 let cell = tableView.dequeueReusableCell(withIdentifier: "VimoPlayerCell", for: indexPath) as! VimoPlayerCell
 cell.configureCell(videoUrl: self.viemoVideoArr[indexPath.row])
 return cell
 //  }
 }
 
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 //        if tableView == self.selectedVideoViewTbl
 //        {
 //            return 50 //UITableView.automaticDimension
 //        }
 //        else
 //        {
 return tableView.frame.height
 //   }
 }
 
 func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
 //        if tableView == vimoVideoTbl
 //        {
 if let videoCell = cell as? ASAutoPlayVideoLayerContainer, let _ = videoCell.videoURL {
 ASVideoPlayerController.sharedVideoPlayer.removeLayerFor(cell: videoCell)
 //            }
 }
 }
 
 func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
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
 
 //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
 //        if tableView == vimoVideoTbl
 //        {
 //            print("play video \(indexPath.row)")
 //           // changeSecondTableViewCellColor(index:indexPath.row)
 //        }
 //    }
 }
 
 
 
 */

extension VimoPlayerVC {
    //MARK:- func play vimo video
    
    //    func vimoVideoSetUp() {
    //
    //        let info = videoIdInfo
    //        if info.count != 0
    //        {
    //            let idArray = videoIdInfo!.compactMap { $0.videoDetail }.compactMap {$0.videoID}
    //
    //            let farray = videoArr.filter {$0 != ""}
    //            if farray.count != 0 {
    //
    //                for i in 0..<(farray.count) {
    //                    if let url = URL(string: vimoBaseUrl + farray[i]) {
    //                        //                if let url = URL(string: stingUrl) {
    //                        HCVimeoVideoExtractor.fetchVideoURLFrom(url: url, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
    //
    //                            if let err = error {
    //
    //                                DispatchQueue.main.async() {
    //                                    self.videoURL = nil
    //
    //                                    let alert = UIAlertController(title: "InCorrect VideoId", message: err.localizedDescription, preferredStyle: .alert)
    //                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    //                                    self.present(alert, animated: true, completion: nil)
    //                                }
    //                                return
    //                            }
    //
    //                            guard let vid = video else {
    //                                print("Invalid video object")
    //                                return
    //                            }
    //
    //                            //                        print("Title = \(vid.title), url = \(vid.videoURL), thumbnail = \(vid.thumbnailURL)")
    //
    //
    //
    //                            DispatchQueue.main.async() {
    //                                /*
    //                                 if let url = vid.thumbnailURL[.qualityBase] {
    //                                 self.vimoImageView.contentMode = .scaleAspectFill
    //                                 self.vimoImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "Image"))
    //                                 }
    //                                 */
    //
    //
    //                                if let videoUrl = vid.videoURL[.quality1080p] {
    //                                    self.videoURL = videoUrl
    //                                } else if let videoUrl = vid.videoURL[.quality960p] {
    //                                    self.videoURL = videoUrl
    //                                } else if let videoUrl = vid.videoURL[.quality720p] {
    //                                    self.videoURL = videoUrl
    //                                } else if let videoUrl = vid.videoURL[.quality640p] {
    //                                    self.videoURL = videoUrl
    //                                } else if let videoUrl = vid.videoURL[.quality540p] {
    //                                    self.videoURL = videoUrl
    //                                } else if let videoUrl = vid.videoURL[.quality360p] {
    //                                    self.videoURL = videoUrl
    //                                } else if let videoUrl = vid.videoURL[.qualityUnknown] {
    //                                    self.videoURL = videoUrl
    //                                }
    //
    //                                guard let videoURL = self.videoURL else { return }
    //
    //                                self.videoURL = videoURL
    //                                if self.videoURL == nil {
    //                                    self.showAlert(message: "Invalid Id")
    //                                    self.dismiss(animated: true)
    //                                }else {
    //                                    self.vimoVideoURL.append(self.videoURL!.absoluteString)
    //                                    //                                self.vimoVideoURL.append(self.videoURL!.absoluteString)
    //                                    //                                self.setupVideo(videoPath: self.videoURL!)
    //
    //                                }
    //                            }
    //                        })
    //                    }
    //
    //                }
    //            }
    //
    //
    //        }
    //    }
    
}



















//class VimoPlayerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    @IBOutlet weak var vimoVideoTbl: UITableView!
//
//    var vimoVideoID = ["898220213","898877471","898220213"]//,"898877471","254597739","898220213"]
//    var vimoBaseUrl = "https://vimeo.com/"
//    var result = 0
//    var videoURL: URL?
//
//
//    // MARK: - Properties
//    private var playerLayer: AVPlayerLayer!
//    private var playerItem: AVPlayerItem!
//
//    private var player: AVPlayer?
//    private var playerObserver: Any?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //        setupVideo()
//        setupEvents()
//
//
//        vimoVideoTbl.register(UINib(nibName: "VimoPlayerCell", bundle: .main), forCellReuseIdentifier: "VimoPlayerCell")
//
//
//    }
//
//    //MARK:- func play vimo video
//
//    func vimoVideoSetUp(stingUrl:String) {
//
//        // MARK: Using Vimo video url
//
//        //        if let url = URL(string: vimoBaseUrl + vimoVideoID[0]) {
//        if let url = URL(string: stingUrl) {
//            HCVimeoVideoExtractor.fetchVideoURLFrom(url: url, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
//
//                if let err = error {
//
//                    print("Error = \(err.localizedDescription)")
//
//                    DispatchQueue.main.async() {
//                        self.videoURL = nil
//
//                        let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
//                    }
//                    return
//                }
//
//                guard let vid = video else {
//                    print("Invalid video object")
//                    return
//                }
//
//                print("Title = \(vid.title), url = \(vid.videoURL), thumbnail = \(vid.thumbnailURL)")
//
//
//
//                DispatchQueue.main.async() {
//                    /*
//                     if let url = vid.thumbnailURL[.qualityBase] {
//                     self.vimoImageView.contentMode = .scaleAspectFill
//                     self.vimoImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "Image"))
//                     }
//                     */
//
//                    self.videoURL = vid.videoURL[.quality1080p]
//                    if self.videoURL == nil {
//                        self.showAlert(message: "Invalid Id")
//                        self.dismiss(animated: true)
//                    }else {
//                        self.setupVideo(videoPath: self.videoURL!)
//
//                    }
//                }
//            })
//        }
//    }
//
//
//    // MARK: - Using Vimo Video Id
//
////    private func setupVideo(videoPath:URL) {
////
////        let player = AVPlayer(url: videoPath)
////        self.player = player
////
////        let playerLayer = AVPlayerLayer(player: player)
////        playerLayer.frame = self.view.frame
////        playerLayer.videoGravity = .resizeAspectFill
////        videoContainerView.layer.addSublayer(playerLayer)
////        player.play()
////
////        getVideoTimeObserver = NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
////
////        player.allowsExternalPlayback = false
////        player.usesExternalPlaybackWhileExternalScreenIsActive = false
////
////        player.play()
////    }
//
//
//
//    deinit {
//        guard let observer = playerObserver else { return }
//        NotificationCenter.default.removeObserver(observer)
//    }
//
//    // MARK: - Events
//    private func setupEvents() {
//        NotificationCenter.default.addObserver(self, selector: #selector(enteredBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(enteredForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
//    }
//
//
//    @objc private func enteredBackground() {
//        player?.pause()
//    }
//
//    @objc private func enteredForeground() {
//        player?.play()
//    }
//
//
//    @IBAction func btnRefresh(_ sender: UIButton) {
//        vimoVideoTbl.reloadData()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "VimoPlayerCell", for: indexPath) as! VimoPlayerCell
//
//
//
//        let player = AVPlayer(url: videoPath)
//        self.player = player
//
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.view.frame
////        playerLayer.videoGravity = .resizeAspectFill
//        cell.videoContainerView.layer.addSublayer(playerLayer)
//        player.play()
//
//        getVideoTimeObserver = NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
//
//        player.allowsExternalPlayback = false
//        player.usesExternalPlaybackWhileExternalScreenIsActive = false
//
//        player.play()
//
//        /*
//        let path = Bundle.main.path(forResource: "StarVideo", ofType: "mp4")!
//
//        let player = AVPlayer(url: URL(fileURLWithPath: path))
//        self.player = player
//
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.view.frame
//        playerLayer.videoGravity = .resizeAspectFill
//        cell.videoContainerView.layer.addSublayer(playerLayer)
//
//        playerObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { _ in
//
//            guard let frameRate = player.currentItem?.currentTime().timescale else {
//                return
//            }
//
//            player.currentItem?.seek(to: CMTimeMakeWithSeconds(0.1, preferredTimescale: frameRate), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero, completionHandler: { _ in
//                player.play()
//            })
//        }
//
//        player.allowsExternalPlayback = false
//        player.usesExternalPlaybackWhileExternalScreenIsActive = false
//
//        player.play()
//         */
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return vimoVideoTbl.frame.size.height//650//vimoVideoTbl.frame.height - 20//UIScreen.main.bounds.height
//    }
//
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        player?.pause()
//        print("pause video \(indexPath.row)")
//    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        player?.play()
//        print("play video \(indexPath.row)")
//        /*
//         cell.alpha = 0
//         UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
//         cell.alpha = 1
//         }
//         */
//
//        //        // Zooming Animation
//        //        cell.transform = CGAffineTransform(scaleX: 0, y: 0)
//        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
//        //            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
//        //        }
//
//        //        // Zooming Animation Left
//        //        cell.transform = CGAffineTransform(scaleX: 0, y: 1)
//        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
//        //            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
//        //        }
//
//        // Zooming Animation Right
//        //        cell.transform = CGAffineTransform(scaleX: 1, y: 0)
//        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
//        //            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
//        //        }
//
//        // Zooming Animation Right
//        //        cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
//        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
//        //            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
//        //        }
//
//        // Zooming Animation Right
//        //        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
//        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
//        //            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
//        //        }
//
//    }
//
//}


//import AVKit
//import AVFoundation
//import HCVimeoVideoExtractor
//
//class VimoPlayerVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
//
//    @IBOutlet weak var vimoVideoTbl: UITableView!
//    @IBOutlet weak var selectedVideoViewTbl: UITableView!
//
//    var viemoVideoArr = ["Video2", "Video3", "Video4", "Video5", "Video6"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //        setupVideo()
//        setupEvents()
//
//        self.vimoVideoTbl.delegate = self
//        self.vimoVideoTbl.dataSource = self
//
//        self.vimoVideoTbl.register(UINib(nibName: "VimoPlayerCell", bundle: .main), forCellReuseIdentifier: "VimoPlayerCell")
//
//        self.selectedVideoViewTbl.register(UINib(nibName: "VideoThunbListTblCell", bundle: .main), forCellReuseIdentifier: "VideoThunbListTblCell")
//    }
//    // MARK: - Properties
//    private var playerLayer: AVPlayerLayer!
//    private var playerItem: AVPlayerItem!
//
//    private var player: AVPlayer?
//    private var playerObserver: Any?
//
//
//    deinit {
//        guard let observer = playerObserver else { return }
//        NotificationCenter.default.removeObserver(observer)
//    }
//
//    // MARK: - Events
//    private func setupEvents() {
//        NotificationCenter.default.addObserver(self, selector: #selector(enteredBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(enteredForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
//    }
//
//
//    //    private func setupVideo() {
//    //        // Video downloaded from this url:
//    //        // "https://theformulaic.com/us/videos/mobile-intro-transcode-transcode-transcode.mp4"
//    //        guard let path = Bundle.main.path(forResource: "StarVideo", ofType: "mp4") else { return }
//    //
//    //
//    //                   // let url = NSURL(fileURLWithPath: path!)
//    //
//    //        let player = AVPlayer(url: URL(fileURLWithPath: path))
//    //        self.player = player
//    //
//    //        let playerLayer = AVPlayerLayer(player: player)
//    //        playerLayer.frame = self.view.frame
//    //        playerLayer.videoGravity = .resizeAspectFill
//    //        videoContainerView.layer.addSublayer(playerLayer)
//    //
//    //        playerObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { _ in
//    //
//    //            guard let frameRate = player.currentItem?.currentTime().timescale else {
//    //                return
//    //            }
//    //
//    //            player.currentItem?.seek(to: CMTimeMakeWithSeconds(0.1, preferredTimescale: frameRate), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero, completionHandler: { _ in
//    //                player.play()
//    //            })
//    //        }
//    //
//    //        player.allowsExternalPlayback = false
//    //        player.usesExternalPlaybackWhileExternalScreenIsActive = false
//    //
//    //        player.play()
//    //    }
//
//    @objc private func enteredBackground() {
//        player?.pause()
//    }
//
//    @objc private func enteredForeground() {
//        player?.play()
//    }
//
//
//    @IBAction func btnRefresh(_ sender: UIButton) {
//        vimoVideoTbl.reloadData()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.viemoVideoArr.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == self.selectedVideoViewTbl
//        {
//            let cell = tableView.dequeueCell(VideoThunbListTblCell.self,for: indexPath)
//            return cell
//        }
//        else
//        {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "VimoPlayerCell", for: indexPath) as! VimoPlayerCell
//
//            let path = Bundle.main.path(forResource:viemoVideoArr[indexPath.row], ofType: "mp4")!
//
//            let player = AVPlayer(url: URL(fileURLWithPath: path))
//            self.player = player
//
//            let playerLayer = AVPlayerLayer(player: player)
//            playerLayer.frame = self.view.frame
//            playerLayer.videoGravity = .resizeAspectFill
//            cell.videoContainerView.layer.addSublayer(playerLayer)
//
//            playerObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { _ in
//
//                guard let frameRate = player.currentItem?.currentTime().timescale else {
//                    return
//                }
//
//                player.currentItem?.seek(to: CMTimeMakeWithSeconds(0.1, preferredTimescale: frameRate), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero, completionHandler: { _ in
//                    player.play()
//                })
//            }
//
//            player.allowsExternalPlayback = false
//            player.usesExternalPlaybackWhileExternalScreenIsActive = false
//
//            player.play()
//
//            return cell
//
//            //            let cell = tableView.dequeueReusableCell(withIdentifier: "VimoPlayerCell", for: indexPath) as! VimoPlayerCell
//            //
//            //            // Video downloaded from this url:
//            //            // "https://theformulaic.com/us/videos/mobile-intro-transcode-transcode-transcode.mp4"
//            //            //        guard let path = Bundle.main.path(forResource: "StarVideo", ofType: "mp4") else { return }
//            //            let path = Bundle.main.path(forResource: "StarVideo", ofType: "mp4")!
//            //
//            //            let player = AVPlayer(url: URL(fileURLWithPath: path))
//            //            self.player = player
//            //
//            //            let playerLayer = AVPlayerLayer(player: player)
//            //            playerLayer.frame = self.view.frame
//            //            playerLayer.videoGravity = .resizeAspectFill
//            //            cell.videoContainerView.layer.addSublayer(playerLayer)
//            //
//            //            playerObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { _ in
//            //
//            //                guard let frameRate = player.currentItem?.currentTime().timescale else {
//            //                    return
//            //                }
//            //
//            //                player.currentItem?.seek(to: CMTimeMakeWithSeconds(0.1, preferredTimescale: frameRate), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero, completionHandler: { _ in
//            //                    player.play()
//            //                })
//            //            }
//            //
//            //            player.allowsExternalPlayback = false
//            //            player.usesExternalPlaybackWhileExternalScreenIsActive = false
//            //
//            //            player.play()
//            //            return cell
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if tableView == self.selectedVideoViewTbl
//        {
//            return 50 //UITableView.automaticDimension
//        }
//        else
//        {
//            return vimoVideoTbl.frame.size.height//650//vimoVideoTbl.frame.height - 20//UIScreen.main.bounds.height
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if tableView == vimoVideoTbl
//        {
//            player?.pause()
//            print("pause video \(indexPath.row)")
//
//        }
//    }
//    func changeSecondTableViewCellColor(index:Int) {
//        for i in 0..<5 {
//            let indexPath = IndexPath(row: i, section: 0)
//            let cell2 = selectedVideoViewTbl.cellForRow(at: indexPath) as? VideoThunbListTblCell
//
//            if i == index {
//                // Change the color of the selected index
//                cell2?.selectedView.backgroundColor = Colors.appThemeButtonColor
//            } else {
//                // Keep the color white for other cells
//                cell2?.selectedView.backgroundColor = Colors.appViewBackgroundColor
//            }
//        }
//
//        //          let indexPath = IndexPath(row: index, section: 0) // Provide the appropriate row index
//        //          let cell2 = selectedVideoViewTbl.cellForRow(at: indexPath) as? VideoThunbListTblCell
//
//    }
//
//
//
//    //        func changeSecondTableViewCellColor() {
//    //                    // Change the color of the second table view cell based on the selected index
//    ////                    for i in 0..<5 {
//    ////                        let indexPath = IndexPath(row: i, section: 0)
//    ////                        let cell2 = tableView2.cellForRow(at: indexPath) as? YourTableViewCell2
//    ////
//    ////                        if i == selectedRowIndex {
//    ////                            // Change the color of the selected index
//    ////                            cell2?.backgroundColor = UIColor.yourSelectedColor
//    ////                        } else {
//    ////                            // Keep the color white for other cells
//    ////                            cell2?.backgroundColor = UIColor.white
//    ////                        }
//    ////                    }
//    //                }
//
//
//    //        if let customCell = cell as? VideoThunbListTblCell {
//    //            //customCell.selectedView.backgroundColor = Colors.appThemeButtonColor
//    //             }
//    //  }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if tableView == vimoVideoTbl
//        {
//            player?.play()
//            print("play video \(indexPath.row)")
//            changeSecondTableViewCellColor(index:indexPath.row)
//        }
//
//
//
//
//
//
//
//
//
//
//        /*
//         cell.alpha = 0
//         UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
//         cell.alpha = 1
//         }
//         */
//
//        //        // Zooming Animation
//        //        cell.transform = CGAffineTransform(scaleX: 0, y: 0)
//        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
//        //            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
//        //        }
//
//        //        // Zooming Animation Left
//        //        cell.transform = CGAffineTransform(scaleX: 0, y: 1)
//        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
//        //            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
//        //        }
//
//        // Zooming Animation Right
//        //        cell.transform = CGAffineTransform(scaleX: 1, y: 0)
//        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
//        //            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
//        //        }
//
//        // Zooming Animation Right
//        //        cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
//        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
//        //            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
//        //        }
//
//        // Zooming Animation Right
//        //        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
//        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
//        //            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
//        //        }
//
//    }
//
//    @IBAction func OnTapBackBtn(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//
//    }
//
//
//
//}
//
//
////class VimoPlayerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
////
////    @IBOutlet weak var vimoVideoTbl: UITableView!
////
////    var vimoVideoID = ["898220213","898877471","898220213"]//,"898877471","254597739","898220213"]
////    var vimoBaseUrl = "https://vimeo.com/"
////    var result = 0
////    var videoURL: URL?
////
////
////    // MARK: - Properties
////    private var playerLayer: AVPlayerLayer!
////    private var playerItem: AVPlayerItem!
////
////    private var player: AVPlayer?
////    private var playerObserver: Any?
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        //        setupVideo()
////        setupEvents()
////
////
////        vimoVideoTbl.register(UINib(nibName: "VimoPlayerCell", bundle: .main), forCellReuseIdentifier: "VimoPlayerCell")
////
////
////    }
////
////    //MARK:- func play vimo video
////
////    func vimoVideoSetUp(stingUrl:String) {
////
////        // MARK: Using Vimo video url
////
////        //        if let url = URL(string: vimoBaseUrl + vimoVideoID[0]) {
////        if let url = URL(string: stingUrl) {
////            HCVimeoVideoExtractor.fetchVideoURLFrom(url: url, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
////
////                if let err = error {
////
////                    print("Error = \(err.localizedDescription)")
////
////                    DispatchQueue.main.async() {
////                        self.videoURL = nil
////
////                        let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
////                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
////                        self.present(alert, animated: true, completion: nil)
////                    }
////                    return
////                }
////
////                guard let vid = video else {
////                    print("Invalid video object")
////                    return
////                }
////
////                print("Title = \(vid.title), url = \(vid.videoURL), thumbnail = \(vid.thumbnailURL)")
////
////
////
////                DispatchQueue.main.async() {
////                    /*
////                     if let url = vid.thumbnailURL[.qualityBase] {
////                     self.vimoImageView.contentMode = .scaleAspectFill
////                     self.vimoImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "Image"))
////                     }
////                     */
////
////                    self.videoURL = vid.videoURL[.quality1080p]
////                    if self.videoURL == nil {
////                        self.showAlert(message: "Invalid Id")
////                        self.dismiss(animated: true)
////                    }else {
////                        self.setupVideo(videoPath: self.videoURL!)
////
////                    }
////                }
////            })
////        }
////    }
////
////
////    // MARK: - Using Vimo Video Id
////
//////    private func setupVideo(videoPath:URL) {
//////
//////        let player = AVPlayer(url: videoPath)
//////        self.player = player
//////
//////        let playerLayer = AVPlayerLayer(player: player)
//////        playerLayer.frame = self.view.frame
//////        playerLayer.videoGravity = .resizeAspectFill
//////        videoContainerView.layer.addSublayer(playerLayer)
//////        player.play()
//////
//////        getVideoTimeObserver = NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
//////
//////        player.allowsExternalPlayback = false
//////        player.usesExternalPlaybackWhileExternalScreenIsActive = false
//////
//////        player.play()
//////    }
////
////
////
////    deinit {
////        guard let observer = playerObserver else { return }
////        NotificationCenter.default.removeObserver(observer)
////    }
////
////    // MARK: - Events
////    private func setupEvents() {
////        NotificationCenter.default.addObserver(self, selector: #selector(enteredBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
////        NotificationCenter.default.addObserver(self, selector: #selector(enteredForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
////    }
////
////
////    @objc private func enteredBackground() {
////        player?.pause()
////    }
////
////    @objc private func enteredForeground() {
////        player?.play()
////    }
////
////
////    @IBAction func btnRefresh(_ sender: UIButton) {
////        vimoVideoTbl.reloadData()
////    }
////
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return 5
////    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "VimoPlayerCell", for: indexPath) as! VimoPlayerCell
////
////
////
////        let player = AVPlayer(url: videoPath)
////        self.player = player
////
////        let playerLayer = AVPlayerLayer(player: player)
////        playerLayer.frame = self.view.frame
//////        playerLayer.videoGravity = .resizeAspectFill
////        cell.videoContainerView.layer.addSublayer(playerLayer)
////        player.play()
////
////        getVideoTimeObserver = NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
////
////        player.allowsExternalPlayback = false
////        player.usesExternalPlaybackWhileExternalScreenIsActive = false
////
////        player.play()
////
////        /*
////        let path = Bundle.main.path(forResource: "StarVideo", ofType: "mp4")!
////
////        let player = AVPlayer(url: URL(fileURLWithPath: path))
////        self.player = player
////
////        let playerLayer = AVPlayerLayer(player: player)
////        playerLayer.frame = self.view.frame
////        playerLayer.videoGravity = .resizeAspectFill
////        cell.videoContainerView.layer.addSublayer(playerLayer)
////
////        playerObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { _ in
////
////            guard let frameRate = player.currentItem?.currentTime().timescale else {
////                return
////            }
////
////            player.currentItem?.seek(to: CMTimeMakeWithSeconds(0.1, preferredTimescale: frameRate), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero, completionHandler: { _ in
////                player.play()
////            })
////        }
////
////        player.allowsExternalPlayback = false
////        player.usesExternalPlaybackWhileExternalScreenIsActive = false
////
////        player.play()
////         */
////        return cell
////    }
////
////
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return vimoVideoTbl.frame.size.height//650//vimoVideoTbl.frame.height - 20//UIScreen.main.bounds.height
////    }
////
////    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
////        player?.pause()
////        print("pause video \(indexPath.row)")
////    }
////    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
////        player?.play()
////        print("play video \(indexPath.row)")
////        /*
////         cell.alpha = 0
////         UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
////         cell.alpha = 1
////         }
////         */
////
////        //        // Zooming Animation
////        //        cell.transform = CGAffineTransform(scaleX: 0, y: 0)
////        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
////        //            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
////        //        }
////
////        //        // Zooming Animation Left
////        //        cell.transform = CGAffineTransform(scaleX: 0, y: 1)
////        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
////        //            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
////        //        }
////
////        // Zooming Animation Right
////        //        cell.transform = CGAffineTransform(scaleX: 1, y: 0)
////        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
////        //            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
////        //        }
////
////        // Zooming Animation Right
////        //        cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
////        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
////        //            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
////        //        }
////
////        // Zooming Animation Right
////        //        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
////        //        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
////        //            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
////        //        }
////
////    }
////
////}

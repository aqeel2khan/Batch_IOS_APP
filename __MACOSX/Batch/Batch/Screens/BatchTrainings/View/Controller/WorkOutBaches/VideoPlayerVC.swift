//
//  VideoPlayerVC.swift
//
//  Created by shashivendra sengar on 20/01/24.
//

import UIKit
import AVFoundation
import AVKit
import SDWebImage
import HCVimeoVideoExtractor

class VideoPlayerVC: UIViewController {
    var tblIconArray = [#imageLiteral(resourceName: "Image"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "Image"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image2")]
    
    @IBOutlet private weak var videoContainerView: UIView!
    @IBOutlet private weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var vimoImageView: UIImageView!
    @IBOutlet private weak var takeFreeChallengeButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var playPauseButton: UIButton!
    
    // MARK: - Properties
    private var playerLayer: AVPlayerLayer!
    private var playerItem: AVPlayerItem!
    
    private var player: AVPlayer?
    private var playerObserver: Any?
    private var getVideoTimeObserver: Any?
    var videoURL: URL?
    
    var timeObserver: Any?
    
//    let videoArr = ["StarVideo","Video2","Video3","Video4","Video5"]
    //    var vimoVideoID = ["898220213","898877471","898220213"]//,"898877471","254597739","898220213"]
    var vimoVideoID = [String]()
    var vimoBaseUrl = "https://vimeo.com/"
    var result = 0
    
    var courseVideoId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.playPauseButton.imageView?.tintColor = UIColor.darkGray // Change UIColor.red to your desired tint color
        // Change the tint color of the progress view
        //progressView.progressTintColor = UIColor.darkGray
        progressView.layer.sublayers?[1].backgroundColor = UIColor.darkGray.cgColor
        // Change the progress color of the progress view
        progressView.progressTintColor = Colors.appViewBackgroundColor

        //self.videoListTblView.isHidden = true
        self.vimoVideoID.removeAll()
        self.vimoVideoID.append(courseVideoId)
        
        
        // MARK: Using normal app video
        
        //        guard let path = Bundle.main.path(forResource: videoArr[result], ofType: "mp4") else { return }
        
        //  setupVideo(videoPath:path)
        setupEvents()
        
       // self.videoListTblView.register(UINib(nibName: "VideoThunbListTblCell", bundle: .main), forCellReuseIdentifier: "VideoThunbListTblCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vimoVideoSetUp(stingUrl:vimoBaseUrl + vimoVideoID[result])
    }
    
    //MARK:- func play vimo video
    
    func vimoVideoSetUp(stingUrl:String) {
        
        // MARK: Using Vimo video url
        
        //        if let url = URL(string: vimoBaseUrl + vimoVideoID[0]) {
        if let url = URL(string: stingUrl) {
            HCVimeoVideoExtractor.fetchVideoURLFrom(url: url, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
                
                if let err = error {
                    
                    print("Error = \(err.localizedDescription)")
                    
                    DispatchQueue.main.async() {
                        self.videoURL = nil
                        
                        let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                
                guard let vid = video else {
                    print("Invalid video object")
                    return
                }
                
                print("Title = \(vid.title), url = \(vid.videoURL), thumbnail = \(vid.thumbnailURL)")
                
                print("\(vid.videoURL)")
                
                
                
                DispatchQueue.main.async() {
                    /*
                     if let url = vid.thumbnailURL[.qualityBase] {
                     self.vimoImageView.contentMode = .scaleAspectFill
                     self.vimoImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "Image"))
                     }
                     */
                    // This is used for creating video thumbnail
                     if let url = vid.thumbnailURL[.qualityBase] {
                     self.vimoImageView.contentMode = .scaleAspectFill
                     self.vimoImageView.sd_setImage(with: url)
                     }
                    
                    self.videoURL = vid.videoURL[.quality1080p]
                    if self.videoURL == nil {
                        self.showAlert(message: "Invalid Id")
                        self.dismiss(animated: true)
                    }else {
                        self.setupVideo(videoPath: self.videoURL!)
                        
                    }
                }
            })
        }
        
    }
    
    deinit {
        guard let observer = playerObserver else { return }
        guard let secondObserver = getVideoTimeObserver else { return }
        NotificationCenter.default.removeObserver(observer)
        NotificationCenter.default.removeObserver(secondObserver)
        
        // Remove the time observer when the view controller is deallocated
              if let observer = timeObserver {
                  player?.removeTimeObserver(observer)
              }
    }
    
    
    @IBAction func onTapPlayPauseVideoBtn(_ sender: UIButton) {
        
        
        
        if player?.rate == 0 {
              // Video is paused, resume playback
              player?.play()
              playPauseButton.setTitle("", for: .normal)
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
          } else {
              // Video is playing, pause playback
              player?.pause()
              playPauseButton.setTitle("", for: .normal)
              playPauseButton.setImage(UIImage(named: "play"), for: .normal)

          }
        
    }
    @IBAction func seekSliderValueChanged(_ sender: UISlider) {
        // Seek to the selected position in the video
        let duration = player?.currentItem?.duration.seconds ?? 0
        let newPosition = Double(sender.value) * duration
        let seekTime = CMTime(seconds: newPosition, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player?.seek(to: seekTime)
    }

    
    
    // MARK: - Events
    private func setupEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(enteredBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enteredForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    // MARK: - Using Vimo Video Id
    
    private func setupVideo(videoPath:URL) {
        
        let player = AVPlayer(url: videoPath)
        self.player = player
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = .resizeAspectFill
        videoContainerView.layer.addSublayer(playerLayer)
        
        // Set up the time observer to update the progress
        let interval = CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [weak self] time in
            guard let duration = self?.player?.currentItem?.duration.seconds else { return }
            let currentTime = time.seconds
            let progress = Float(currentTime / duration)
            self?.progressView.progress = progress
        }
        
        
        player.play()
        
        getVideoTimeObserver = NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        player.allowsExternalPlayback = false
        player.usesExternalPlaybackWhileExternalScreenIsActive = false
        
        player.play()
    }
    
    
    @objc func playerDidFinishPlaying(note: NSNotification){
        
        player?.seek(to: CMTime.zero)
        
        if result != vimoVideoID.count - 1 {
            result = result + 1
            print("Video \(result) Finished" )
            
            vimoVideoSetUp(stingUrl:vimoBaseUrl + vimoVideoID[result])
            
        }else{
            print("end video")
            self.dismiss(animated: true)
            
        }
    }
    
    // MARK: - Normal Video functions
    
    /*
     
     //    private func setupVideo(videoPath:String) {
     
     let player = AVPlayer(url: URL(fileURLWithPath: videoPath))
     self.player = player
     
     let playerLayer = AVPlayerLayer(player: player)
     playerLayer.frame = self.view.frame
     playerLayer.videoGravity = .resizeAspectFill
     videoContainerView.layer.addSublayer(playerLayer)
     playerObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { _ in
     
     guard let frameRate = player.currentItem?.currentTime().timescale else {
     return
     }
     
     player.currentItem?.seek(to: CMTimeMakeWithSeconds(0.1, preferredTimescale: frameRate), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero, completionHandler: { _ in
     player.play()
     })
     }
     
     getVideoTimeObserver = NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
     
     player.allowsExternalPlayback = false
     player.usesExternalPlaybackWhileExternalScreenIsActive = false
     
     player.play()
     }
     
     @objc func playerDidFinishPlaying(note: NSNotification){
     
     player?.seek(to: CMTime.zero)
     
     if result != videoArr.count - 1 {
     result = result + 1
     print("Video \(result) Finished" )
     guard let path1 = Bundle.main.path(forResource: videoArr[result], ofType: "mp4") else { return }
     setupVideo(videoPath:path1)
     }else{
     print("end video")
     self.dismiss(animated: true)
     
     }
     }
     
     */
    
    @objc private func enteredBackground() {
        player?.pause()
    }
    
    @objc private func enteredForeground() {
        player?.play()
    }
    
    
    @IBAction func onTapFinishWorkOutBtn(_ sender: UIButton) {
        
        let vc = BWorkOutCompleteVC.instantiate(fromAppStoryboard: .batchTrainings)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    @IBAction func dismissWorkoutView(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

/*
 
 if let url = self.videoURL {
 let player = AVPlayer(url: url)
 let playerController = AVPlayerViewController()
 playerController.player = player
 
 self.present(playerController, animated: true) {
 player.play()
 }
 }
 else {
 let alert = UIAlertController(title: "Error", message: "Invalid video URL", preferredStyle: .alert)
 alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
 self.present(alert, animated: true, completion: nil)
 }
 */

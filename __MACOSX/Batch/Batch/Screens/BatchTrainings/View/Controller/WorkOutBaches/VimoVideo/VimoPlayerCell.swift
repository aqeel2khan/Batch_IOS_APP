//
//  VimoPlayerCell.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 18/02/24.
//

import UIKit
import AVFoundation

class VimoPlayerCell: UITableViewCell ,ASAutoPlayVideoLayerContainer {
    
    @IBOutlet weak var bottomView: UIStackView!
    @IBOutlet weak var finishWorkOutBtn: BatchButton!
    @IBOutlet weak var startNextWoBtn: UIButton!
    
    
    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet var shotImageView: UIImageView!
    var playerController: ASVideoPlayerController?
    var videoLayer: AVPlayerLayer = AVPlayerLayer()
    var videoURL: String? {
        didSet {
            if let videoURL = videoURL {
                ASVideoPlayerController.sharedVideoPlayer.setupVideoFor(url: videoURL)
            }
            videoLayer.isHidden = videoURL == nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        videoLayer.backgroundColor = UIColor.clear.cgColor
        videoLayer.videoGravity = AVLayerVideoGravity.resize
        videoContainerView.layer.addSublayer(videoLayer)
        selectionStyle = .none
    }
    
    func configureCell(videoUrl: String?) {
        self.videoURL = videoUrl
    }
    
    override func prepareForReuse() {
        //        shotImageView.imageURL = nil
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        let horizontalMargin: CGFloat = 20
        let width: CGFloat = bounds.size.width //- horizontalMargin * 2
        let height: CGFloat = bounds.size.height//(width * 0.9).rounded(.up)
        videoLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    func visibleVideoHeight() -> CGFloat {
        let videoFrameInParentSuperView: CGRect? = self.superview?.superview?.convert(shotImageView.frame, from: shotImageView)
        guard let videoFrame = videoFrameInParentSuperView,
              let superViewFrame = superview?.frame else {
            return 0
        }
        let visibleVideoFrame = videoFrame.intersection(superViewFrame)
        return visibleVideoFrame.size.height
    }
    
    
}

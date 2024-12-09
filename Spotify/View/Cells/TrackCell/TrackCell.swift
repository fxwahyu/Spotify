//
//  TrackCell.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 08/12/24.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(track: Track, withKind: Bool) {
        trackImage.kf.setImage(with: URL(string: track.artworkUrl100 ?? ""))
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
        kindLabel.isHidden = !withKind
        if withKind && track.kind != "" {
            kindLabel.text = "\(track.kind ?? "") •"
        }
    }
    
    func setData(track: TrackModel, withKind: Bool) {
        trackImage.kf.setImage(with: URL(string: track.artworkUrl100 ?? ""))
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
        kindLabel.isHidden = !withKind
        if withKind && track.kind != "" {
            kindLabel.text = "\(track.kind!) •"
        }
    }
    
    @IBAction func optionButton(_ sender: Any) {
        
    }
}

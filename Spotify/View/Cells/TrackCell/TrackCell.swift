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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(track: Track) {
        trackImage.kf.setImage(with: URL(string: track.artworkUrl100 ?? ""))
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
    }
    
    func setData(track: TrackModel) {
        trackImage.kf.setImage(with: URL(string: track.artworkUrl100 ?? ""))
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
    }
    
    @IBAction func optionButton(_ sender: Any) {
        
    }
}

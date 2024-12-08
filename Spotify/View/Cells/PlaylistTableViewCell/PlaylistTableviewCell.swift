//
//  PlaylistTableviewCell.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 08/12/24.
//

import UIKit

class PlaylistTableviewCell: UITableViewCell {

    @IBOutlet weak var thumbnailGridView: UIView!
    @IBOutlet weak var playlistNameLabel: UILabel!
    @IBOutlet weak var playlistSongsCountLabel: UILabel!
    
    var playlist: Playlist?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(playlist: Playlist) {
        self.playlist = playlist
        
        playlistNameLabel.text = playlist.name
        playlistSongsCountLabel.text = "Playlist • \(playlist.tracks?.count ?? 0) songs"
        
        setupThumbnailGridView()
    }
    
    func setupThumbnailGridView() {
        thumbnailGridView.addSubview(ThumbnailGridView(frame: CGRect(x: 0, y: 0, width: thumbnailGridView.frame.size.width, height: thumbnailGridView.frame.size.height), playlist))
    }
    
}

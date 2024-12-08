//
//  PlaylistCollectionviewCell.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 08/12/24.
//

import UIKit

class PlaylistCollectionviewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailGridView: UIView!
    @IBOutlet weak var playlistNameLabel: UILabel!
    @IBOutlet weak var playlistSongsCountLabel: UILabel!
    
    var playlist: Playlist?
    lazy var thumbnailView: ThumbnailGridView = {
        let view = ThumbnailGridView(frame: .zero)
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailGridView.addSubview(thumbnailView)
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        thumbnailView.frame = CGRect(x: 0, y: 0, width: thumbnailGridView.frame.size.width, height: thumbnailGridView.frame.size.width)
    }
    
    func setup(playlist: Playlist) {
        self.playlist = playlist
        thumbnailView.thumbnailData = playlist
        playlistNameLabel.text = playlist.name
        playlistSongsCountLabel.text = "Playlist • \(playlist.tracks!.count) songs"
        layoutSubviews()
    }


}

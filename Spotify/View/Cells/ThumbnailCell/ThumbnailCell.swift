//
//  ThumbnailCell.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 07/12/24.
//

import UIKit
import Kingfisher

class ThumbnailCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setImage(imageUrl: String) {
        thumbnailImage.kf.setImage(with: URL(string: imageUrl))
    }

}

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
    
    func setImage(imageUrl: String) {
        if imageUrl == "" {
            thumbnailImage.image = grayPlaceholderImage(size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        } else {
            thumbnailImage.kf.setImage(with: URL(string: imageUrl))
        }
    }
    
    func grayPlaceholderImage(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            UIColor.gray.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }

}

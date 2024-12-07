//
//  CategoryCell.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 07/12/24.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var viewBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBackgroundGray()
        // Initialization code
    }
    
    func setBackgroundGray() {
        viewBackground.layer.borderWidth = 0.6
        viewBackground.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
    }
}

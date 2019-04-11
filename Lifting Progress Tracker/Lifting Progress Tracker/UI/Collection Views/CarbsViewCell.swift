//
//  CarbsViewCell.swift
//  Startup_App
//
//  Created by Clayton Kingsbury on 7/26/18.
//  Copyright © 2018 Clayton kingsbury. All rights reserved.
//

import UIKit

class DashboardCell: UICollectionViewCell {
    
    @IBOutlet weak var CellLabel: UILabel!
    @IBOutlet weak var DataLabel: UILabel!
    @IBOutlet weak var IconImage: UIImageView!
    
    func displayContent(image: UIImage, data: String, title: String) {
    CellLabel.text = title
    DataLabel.text = data
    IconImage.image = image
}
}

//
//  QuestionCTVCell.swift
//  AppTracNhiem
//
//  Created by V000315 on 18/08/2022.
//

import UIKit

class QuestionCTVCell: UICollectionViewCell {
    var callback : (() -> Void)?
    @IBOutlet weak var btnNumber: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func clickButton(_ sender: Any) {
        callback?()
    }
}

//
//  DeThiTBVCell.swift
//  AppTracNhiem
//
//  Created by V000315 on 16/08/2022.
//

import UIKit

class DeThiTBVCell: UITableViewCell {
    var callback : (() -> Void)?
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbTileExam: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var imageback: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        callback?()
        // Configure the view for the selected state
    }
    
}

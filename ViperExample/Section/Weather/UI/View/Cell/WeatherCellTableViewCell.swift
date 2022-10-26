//
//  WeatherCellTableViewCell.swift
//  ViperExample
//
//  Created by José Antonio Vieyra García on 10/10/22.
//

import UIKit

class WeatherCellTableViewCell: UITableViewCell {

    @IBOutlet weak var timeTemp: UILabel!
    @IBOutlet weak var ts: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

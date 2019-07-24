//
//  ForecastHeaderTableViewCell.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

class ForecastHeaderTableViewCell: UITableViewCell {

    //MARK: - UI Fields
    @IBOutlet private weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.borderColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        layer.borderWidth = 0.5
    }

    //Helper method to set cell.
    func setCell(with date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        if date.isSameDate(Date()) {
            headerLabel.text = "TODAY"
        } else {
            headerLabel.text = formatter.string(from: date).uppercased()
        }
    }
}

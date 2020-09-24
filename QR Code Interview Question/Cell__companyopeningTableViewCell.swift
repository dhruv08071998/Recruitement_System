//
//  Cell__companyopeningTableViewCell.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 30/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit

class Cell__companyopeningTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var txtTestDate: UILabel!
    
    @IBOutlet weak var txtApplydate: UILabel!
    @IBOutlet weak var txtVacancy: UILabel!
    @IBOutlet weak var txtPosition: UILabel!
    
    @IBOutlet weak var txtTechnology: UILabel!
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

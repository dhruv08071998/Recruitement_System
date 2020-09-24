//
//  QuestionTabeViewCellsTableViewCell.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 02/02/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit

class QuestionTabeViewCellsTableViewCell: UITableViewCell {

    @IBOutlet weak var txtOtherDetails: UILabel!
    @IBOutlet weak var txtlevelofdiff: UILabel!
    @IBOutlet weak var txtQuestiontitle: UILabel!
    @IBOutlet weak var txtQuestionNo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

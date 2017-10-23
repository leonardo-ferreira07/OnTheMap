//
//  ListStudentTableViewCell.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 19/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit

class ListStudentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentMediaLink: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - Configure cell

extension ListStudentTableViewCell {
    func confugureCell(with studentLocation: StudentLocation) {
        studentName.text = studentLocation.firstName + " " + studentLocation.lastName
        studentMediaLink.text = studentLocation.mediaURL
    }
}

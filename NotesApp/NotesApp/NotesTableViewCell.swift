//
//  NotesTableViewCell.swift
//  NotesApp
//
//  Created by MacBook on 16.03.2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var labelLessonName: UILabel!
    @IBOutlet weak var labelNote1: UILabel!
    @IBOutlet weak var labelNote2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

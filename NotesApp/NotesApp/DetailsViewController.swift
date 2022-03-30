//
//  DetailsViewController.swift
//  NotesApp
//
//  Created by MacBook on 16.03.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var labelLessonName: UITextField!
    @IBOutlet weak var labelNote1: UITextField!
    @IBOutlet weak var labelNote2: UITextField!
    
    var note:Notes?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let n = note {
            
            labelLessonName.text = n.ders_adi?.capitalized
            labelNote1.text = n.not1
            labelNote2.text = n.not2
        }
    }
    

}

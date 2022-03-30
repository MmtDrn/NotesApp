//
//  AddViewController.swift
//  NotesApp
//
//  Created by MacBook on 16.03.2022.
//

import UIKit
import Alamofire

class AddViewController: UIViewController {
    
    @IBOutlet weak var labelLessonName: UITextField!
    @IBOutlet weak var labelNote1: UITextField!
    @IBOutlet weak var LabelNote2: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        if let name = labelLessonName.text, let note1 = labelNote1.text, let note2 = LabelNote2.text {
            
            if let n1 = Int(note1), let n2 = Int(note2) {
                
                addLesson(lesson_name: name, note1: n1, note2: n2)
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func addLesson(lesson_name:String,note1:Int,note2:Int){
        
        let parameters:Parameters = ["ders_adi":lesson_name,"not1":note1,"not2":note2]
        
        Alamofire.request("http://kasimadalan.pe.hu/notlar/insert_not.php",method: .post,parameters: parameters).responseJSON { response in
            
            if let data = response.data {
                
                do{
                    if let json = try JSONSerialization.jsonObject(with: data,options: []) as? [String:Any] {
                        print(json)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}

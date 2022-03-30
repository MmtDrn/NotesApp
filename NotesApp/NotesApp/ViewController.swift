//
//  ViewController.swift
//  NotesApp
//
//  Created by MacBook on 16.03.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var tableViewNotes: UITableView!
    
    var list = [Notes]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewNotes.dataSource = self
        tableViewNotes.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllNote()
    }
    
    func getAllNote(){
        
        Alamofire.request("http://kasimadalan.pe.hu/notlar/tum_notlar.php",method: .get).responseJSON { response in
            
            if let data = response.data {
                
                do{
                    let answer = try JSONDecoder().decode(NoteList.self, from: data)
                    
                    if let cameList = answer.notlar {
                        self.list = cameList
                    }
                    DispatchQueue.main.async {
                        self.tableViewNotes.reloadData()
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func deleteLesson(lesson_id:Int){
        
        let parameters:Parameters = ["not_id":lesson_id]
        
        Alamofire.request("http://kasimadalan.pe.hu/notlar/delete_not.php",method: .post,parameters: parameters).responseJSON { response in
            
            if let data = response.data {
                
                do{
                    if let json = try JSONSerialization.jsonObject(with: data,options: []) as? [String:Any] {
                        print(json)
                    }
                    DispatchQueue.main.async {
                        self.getAllNote()
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = sender as? Int
        
        if segue.identifier == "toDetails" {
            
            let detailVC = segue.destination as! DetailsViewController
            detailVC.note = list[index!]
        }
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes", for: indexPath) as! NotesTableViewCell
        
        cell.labelLessonName.text = note.ders_adi?.capitalized
        cell.labelNote1.text = note.not1
        cell.labelNote2.text = note.not2
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetails", sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let note = list[indexPath.row]
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [self] contextualAction, view, boolValue in
            
            if let nid = Int(note.not_id!) {
                deleteLesson(lesson_id: nid)
            }
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

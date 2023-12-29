//
//  ProgramViewController.swift
//  as9
//
//  Created by Ruchita Iyer on 11/20/23.
//

import UIKit
import CoreData

class ProgramViewController: UIViewController {
    
    var colleges = [College]()
    var programs = [Program]()

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var collegeidTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveProgram(_ sender: UIButton) {
        guard let idTF = idTextField.text,
              let name = nameTextField.text,
              let collegeIdStr = collegeidTextField.text,
              let collegeId = Int(collegeIdStr),
              let id = Int(idTF), !idTF.isEmpty, !name.isEmpty, !collegeIdStr.isEmpty else {
            displayErrorAlert(message: "Fields cannot be empty.")
            return
        }

        if isUniqueProgramID(id) {
            let fetchRequest: NSFetchRequest<College> = College.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", collegeId)
            do {
                let fetchedColleges = try context.fetch(fetchRequest)
                if let fetchedCollege = fetchedColleges.first {
                    print(fetchedCollege)
                    self.createProgram(id: Int16(id), name: name, college: fetchedCollege)
//                    tableView.reloadData()
                    let successAlert = UIAlertController(title: "Success", message: "Program saved successfully.", preferredStyle: .alert)
                    successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(successAlert, animated: true, completion: nil)
                } else {
                    // Handle case where the specified collegeId does not exist
                    displayErrorAlert(message: "College with ID \(collegeId) not found.")
                    // clearInputFields()
                }
            } catch {
                print("Error: \(error.localizedDescription)")
                // Handle the error
            }
        } else {
            displayErrorAlert(message: "Program ID must be unique.")
        }
    }

        
        private func isUniqueProgramID(_ id: Int) -> Bool {
            let existingIDs = programs.map { $0.id }
            return !existingIDs.contains(Int16(id))
        }
        
        private func displayErrorAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        func getAll(){
            do{
                programs = try context.fetch(Program.fetchRequest())
                DispatchQueue.main.async {
//                    self.tableView.reloadData()
                }
            }
            catch{
            }
            
        }
        
        func createProgram(id: Int16, name: String, college: College){
            let newProgram = Program(context: context)
            newProgram.id = id
            newProgram.name = name
            newProgram.college = college
            do{
                try context.save()
                getAll()
            }
            catch{
                
            }
     
        }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

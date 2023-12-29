//
//  ProgramDetailViewController.swift
//  as9
//
//  Created by Ruchita Iyer on 11/20/23.
//

import UIKit

class ProgramDetailViewController: UIViewController {
    
    var programs: Program?

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collegeIdLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let program = programs, let college = program.college {
            idLabel.text = "Id: \(program.id)"
            nameLabel.text = "Name: \(program.name ?? "")"
            collegeIdLabel.text = "College Id: \(college.name ?? "")"
            
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
    
    @IBAction func updateProgram(_ sender: UIButton) {
    
    let alertController = UIAlertController(title: "Update Details", message: "Enter new name", preferredStyle: .alert)

            alertController.addTextField { textField in
                textField.placeholder = "New Name"
            }

            

            let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
                guard let self = self,
                      let program = self.programs,
                      let nameTextField = alertController.textFields?.first,
                      
                      let newName = nameTextField.text
                       else {
                    return
                }

                program.name = newName
                

                do {
                    try self.context.save()
                    self.nameLabel.text = "Name: \(program.name ?? "")"
                    
                } catch {
                    print("Failed to save changes: \(error.localizedDescription)")
                }
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)

            present(alertController, animated: true, completion: nil)
        }
}


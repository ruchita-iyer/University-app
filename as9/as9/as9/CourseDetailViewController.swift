//
//  CourseDetailViewController.swift
//  as9
//
//  Created by Ruchita Iyer on 11/20/23.
//

import UIKit

class CourseDetailViewController: UIViewController {
    
    var courses:Course?

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collegeidLabel: UILabel!
    @IBOutlet weak var programidLabel: UILabel!
    @IBOutlet weak var categoryidLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let course = courses, let college = course.college, let program = course.program, let category = course.category {
            idLabel.text = "Id: \(course.id)"
            nameLabel.text = "Name: \(course.name ?? "")"
            collegeidLabel.text = "College Id: \(college.id)"
            programidLabel.text = "Program Id: \(program.id)"
            categoryidLabel.text = "Category Id: \(category.id)"
    }
    }
    

    @IBAction func updateCourse(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Update Details", message: "Enter new name and address", preferredStyle: .alert)

                alertController.addTextField { textField in
                    textField.placeholder = "New Name"
                }

                

                let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
                    guard let self = self,
                          let course = self.courses,
                          let nameTextField = alertController.textFields?.first,
                         
                          let newName = nameTextField.text else {
                        return
                    }

                    course.name = newName
                   

                    do {
                        try self.context.save()
                        self.nameLabel.text = "Name: \(course.name ?? "")"
                        
                    } catch {
                        print("Failed to save changes: \(error.localizedDescription)")
                    }
                }

                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                alertController.addAction(saveAction)
                alertController.addAction(cancelAction)

                present(alertController, animated: true, completion: nil)
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

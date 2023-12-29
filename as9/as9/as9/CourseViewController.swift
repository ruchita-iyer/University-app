//
//  CourseViewController.swift
//  as9
//
//  Created by Ruchita Iyer on 11/20/23.
//

import UIKit
import CoreData

class CourseViewController: UIViewController {
    
    var colleges = [College]()
    var programs = [Program]()
    var courses = [Course]()
    var categories = [Category]()

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var collegeidTextField: UITextField!
    @IBOutlet weak var programidTextField: UITextField!
    @IBOutlet weak var categoryidTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveCourse(_ sender: UIButton) {
        guard let idtf = idTextField.text,
              let name = nameTextField.text,
              let programIdStr = programidTextField.text,
              let collegeIdStr = collegeidTextField.text,
              let categoryIdStr = categoryidTextField.text,
              let id = Int(idtf),
              let programId = Int(programIdStr),
              let collegeId = Int(collegeIdStr),
              let categoryId = Int(categoryIdStr), !idtf.isEmpty, !name.isEmpty, !programIdStr.isEmpty, !collegeIdStr.isEmpty, !categoryIdStr.isEmpty  else {
            // Show an error alert for empty input fields
            displayErrorAlert(message: "Fields cannot be empty.")
            return
    }
        if isUniqueCourseID(id) {
            do {
                    // Check if the College, Program, and Category exist
                    let collegeFetchRequest: NSFetchRequest<College> = College.fetchRequest()
                    collegeFetchRequest.predicate = NSPredicate(format: "id == %d", collegeId)
                    let programFetchRequest: NSFetchRequest<Program> = Program.fetchRequest()
                    programFetchRequest.predicate = NSPredicate(format: "id == %d", programId)
                    let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
                    categoryFetchRequest.predicate = NSPredicate(format: "id == %d", categoryId)

                    let colleges = try context.fetch(collegeFetchRequest)
                    let programs = try context.fetch(programFetchRequest)
                    let categories = try context.fetch(categoryFetchRequest)
                
                if let college = colleges.first, let program = programs.first, let category = categories.first {
            
                    self.createCourse(id: Int16(id), name: name, college: college, program: program, category: category)
//                DataModel.shared.courses.append(newCourse)
//                clearInputFields()
//                    tableView.reloadData()
                               let successAlert = UIAlertController(title: "Success", message: "Course saved successfully.", preferredStyle: .alert)
                               successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                               present(successAlert, animated: true, completion: nil)
                           } else {
                               // Handle case where the specified College, Program, or Category does not exist
                               displayErrorAlert(message: "College/Program/Category with ID \(collegeId)/\(programId)/\(categoryId) not found.")
                           }
                       } catch {
                           // Handle any errors during the fetch or save process
                           print("Error: \(error)")
                       }
                   }
    }
    
    private func isUniqueCourseID(_ id: Int) -> Bool {
        let existingIDs = courses.map { $0.id }
        return !existingIDs.contains(Int16(id))
    }
    
    private func displayErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
        
        func getAll(){
            do{
                courses = try context.fetch(Course.fetchRequest())
                DispatchQueue.main.async {
//                    self.tableView.reloadData()
                }
            }
            catch{
            }
            
        }
        
        func createCourse(id: Int16, name: String, college: College, program: Program, category: Category){
            let newCourse = Course(context: context)
            newCourse.id = id
            newCourse.name = name
            newCourse.college = college
            newCourse.program = program
            newCourse.category = category
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

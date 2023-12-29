//
//  CategoryViewController.swift
//  as9
//
//  Created by Ruchita Iyer on 11/20/23.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var categories = [Category]()

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveCategory(_ sender: UIButton) {
        guard let idTF = idTextField.text, let name = nameTextField.text, let id = Int(idTF), !idTF.isEmpty,  !name.isEmpty else {
            // Show an error alert for empty input fields
            displayErrorAlert(message: "Fields cannot be empty.")
            return
        }
        
        
            if isUniqueID(id) {
                self.createCategory(id: Int16(id), name: name)
//                DataModel.shared.categories.append(newCategory)
//                clearInputFields()
//                self.tableView.reloadData()
                let successAlert = UIAlertController(title: "Success", message: "Course Category saved successfully.", preferredStyle: .alert)
                            successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            present(successAlert, animated: true, completion: nil)
            } else {
                // Show an error alert for non-unique ID
                displayErrorAlert(message: "ID must be unique.")
            }
    }
        private func isUniqueID(_ id: Int) -> Bool {
            let existingIDs = categories.map { $0.id }
            return !existingIDs.contains(Int16(id))
        }
        
        private func displayErrorAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    
    
    func getAll(){
        do{
            categories = try context.fetch(Category.fetchRequest())
            DispatchQueue.main.async {
//                self.tableView.reloadData()
            }
        }
        catch{
            
        }
        
    }
    
    func createCategory(id: Int16, name: String){
        let newCategory = Category(context: context)
        newCategory.id = id
        newCategory.name = name
        
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

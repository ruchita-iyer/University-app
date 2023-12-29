//
//  CategoryDetailViewController.swift
//  as9
//
//  Created by Ruchita Iyer on 11/20/23.
//

import UIKit

class CategoryDetailViewController: UIViewController {
    
    var categories: Category?

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let category = categories {
            idLabel.text = "Id: \(category.id)"
            nameLabel.text = "Name: \(category.name ?? "")"
          
            
        }
    }
    
    @IBAction func updateCategory(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Update Details", message: "Enter new name and address", preferredStyle: .alert)

                alertController.addTextField { textField in
                    textField.placeholder = "New Name"
                }

               

                let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
                    guard let self = self,
                          let category = self.categories,
                          let nameTextField = alertController.textFields?.first,
                          
                          let newName = nameTextField.text else {
                        return
                    }

                    category.name = newName
                   

                    do {
                        try self.context.save()
                        self.nameLabel.text = "Name: \(category.name ?? "")"
                       
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

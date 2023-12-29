//
//  CollegeDetailViewController.swift
//  as9
//
//  Created by Ruchita Iyer on 11/19/23.
//

import UIKit

class CollegeDetailViewController: UIViewController {
    
    var colleges: College?

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var imageLabel: UIImageView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let college = colleges {
            idLabel.text = "Id: \(college.id)"
            nameLabel.text = "Name: \(college.name ?? "")"
            addressLabel.text = "Address: \(college.address ?? "")"
            // Display college image if imageData exists
                        if let imageData = college.images, let image = UIImage(data: imageData) {
                            imageLabel.image = image
                        } else {
                            // Show a placeholder image or handle the case when imageData is nil
                            imageLabel.image = UIImage(named: "collegeImage") // Replace "placeholderImage" with your image name
                        }
            
        }
    }
    
    @IBAction func updateCollege(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Update Details", message: "Enter new name and address", preferredStyle: .alert)

                alertController.addTextField { textField in
                    textField.placeholder = "New Name"
                }

                alertController.addTextField { textField in
                    textField.placeholder = "New Address"
                }

                let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
                    guard let self = self,
                          let college = self.colleges,
                          let nameTextField = alertController.textFields?.first,
                          let addressTextField = alertController.textFields?.last,
                          let newName = nameTextField.text,
                          let newAddress = addressTextField.text else {
                        return
                    }

                    college.name = newName
                    college.address = newAddress

                    do {
                        try self.context.save()
                        self.nameLabel.text = "Name: \(college.name ?? "")"
                        self.addressLabel.text = "Address: \(college.address ?? "")"
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

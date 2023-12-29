//
//  CollegeViewController.swift
//  as9
//
//  Created by Ruchita Iyer on 11/18/23.
//

import UIKit
import CoreData

class CollegeViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var colleges = [College]()
    
   
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var chosenImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getAll()
       
    }
    
    @IBAction func chooseImage(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
               imagePicker.delegate = self
               imagePicker.sourceType = .photoLibrary
               present(imagePicker, animated: true, completion: nil)
    }
    
    // Image picker delegate method when an image is picked
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               chosenImage = pickedImage
           }
           picker.dismiss(animated: true, completion: nil)
       }
    
    
    @IBAction func saveCollege(_ sender: UIButton) {
        guard let name = nameTextField.text, let address = addressTextField.text, !name.isEmpty, !address.isEmpty else {
            // Show an error alert for empty input fields
            displayErrorAlert(message: "Fields cannot be empty.")
            return
        }
        
        if let idTF = idTextField.text, let id = Int16(idTF), let image = chosenImage {
                    if isUniqueID(Int(id)) {
                        if let images = image.pngData() {
                            createCollege(id: id, name: name, address: address, images: images)
//                            tableView.reloadData()
                            let successAlert = UIAlertController(title: "Success", message: "College saved successfully.", preferredStyle: .alert)
                            successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            present(successAlert, animated: true, completion: nil)
                            return
                        }
                    } else {
                        // Show an error alert for non-unique ID
                        displayErrorAlert(message: "ID must be unique.")
                    }
                } else {
                    // Show an error alert for missing image or invalid ID format
                    displayErrorAlert(message: "Please select an image and enter a valid ID.")
                }
    }
    
    private func isUniqueID(_ id: Int) -> Bool {
        let existingIDs = colleges.map { $0.id }
        return !existingIDs.contains(Int16(id))
    }
    
    private func displayErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
  func getAll(){
        do{
            colleges = try context.fetch(College.fetchRequest())
            DispatchQueue.main.async {
//                self.tableView.reloadData()
            }
        }
        catch{
            
        }
        
    }
    
    func createCollege(id: Int16, name: String, address: String, images: Data){
        let newCollege = College(context: context)
        newCollege.id = id
        newCollege.name = name
        newCollege.address = address
        newCollege.images = images
        do{
            try context.save()
            getAll()
        }
        catch{
            
        }
        
    }
    
  
}

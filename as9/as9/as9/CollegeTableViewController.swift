//
//  CollegeTableViewController.swift
//  as9
//
//  Created by Ruchita Iyer on 11/18/23.
//

import UIKit
import CoreData

class CollegeTableViewController: UITableViewController {
   
    
    var colleges = [College]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        getAll()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    
    func getAll(){
        do{
            colleges = try context.fetch(College.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{

        }

    }
    
    func deleteCollege(college: College){
        context.delete(college)
        
        do{
            try context.save()
        }
        catch{
            
        }

        
    }
    
   

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return colleges.count
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return colleges.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollegeCell", for: indexPath)
                let college = colleges[indexPath.row]
                cell.textLabel?.numberOfLines = 0 // Allow multiple lines of text
                cell.textLabel?.lineBreakMode = .byWordWrapping // Wrap text to multiple lines
                cell.textLabel?.font = UIFont.systemFont(ofSize: 14) // Adjust the font size as needed
        cell.textLabel?.text = "ID: \(college.id)\nName: \(college.name ?? " ")\nAddress: \(college.address ?? " ")"
                return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        guard let selectedRow = tableView.indexPathForSelectedRow else {
//            return
//        }
//        let college = colleges[selectedRow.row]
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            self.deleteCollege(college: college)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let college = colleges[indexPath.row]
                    
                    // Check if the college has associated programs
                    if let programs = college.program, programs.count > 0 {
                        // Show an error alert as the college has associated programs, preventing deletion
                        let alert = UIAlertController(title: "Unable to Delete",
                                                      message: "Cannot delete college with associated programs. Please delete the programs first.",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        present(alert, animated: true, completion: nil)
                        return
                    }
            
            deleteCollege(college: college)
            colleges.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
      
                  if let collegeDetailViewController = segue.destination as? CollegeDetailViewController,
                     let indexPath = tableView.indexPathForSelectedRow
                    {
                    let selectedCollege = colleges[indexPath.row]
                    collegeDetailViewController.colleges = selectedCollege
                }
    }
    

}

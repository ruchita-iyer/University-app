//
//  CourseTableViewController.swift
//  as9
//
//  Created by Ruchita Iyer on 11/20/23.
//

import UIKit
import CoreData

class CourseTableViewController: UITableViewController {
    
    var courses = [Course]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = self.editButtonItem
        getAll()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getAll(){
        do{
            courses = try context.fetch(Course.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{

        }

    }
    
    func deleteCourse(course: Course){
        context.delete(course)
        
        do{
            try context.save()
        }
        catch{
            
        }

        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath)
        let course = courses[indexPath.row]
        cell.textLabel?.numberOfLines = 0 // Allow multiple lines of text
        cell.textLabel?.lineBreakMode = .byWordWrapping // Wrap text to multiple lines
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
//        cell.textLabel?.text = "ID: \(course.id)\nName: \(course.name)\nProgram name: \(course.program.name)\nCollege name: \(course.college.name)\nCategory name: \(course.category.name)"
        
        if let college = course.college, let program = course.program, let category = course.category {
               // Access the associated College object and fetch its name attribute
            cell.textLabel?.text = "ID: \(course.id)\nName: \(course.name ?? "")\nCollege name: \(college.name ?? "")\nProgram Name: \(program.name ?? " ")\nCategory name: \(category.name ?? " ")"
           } else {
               // Handle the case when the college relationship is not set for the program
            cell.textLabel?.text = "ID: \(course.id)\nName: \(course.name ?? "")\nCollege name: Not Available\nProgram Name: Not Available\nCategory name: Not Available"
           }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let course = courses[indexPath.row]
            deleteCourse(course: course)
            courses.remove(at: indexPath.row)
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
        if let courseDetailViewController = segue.destination as? CourseDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow
          {
          let selectedCourse = courses[indexPath.row]
          courseDetailViewController.courses = selectedCourse
    }
    

}
}

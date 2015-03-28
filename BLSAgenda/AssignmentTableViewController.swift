//
//  AssignmentTableViewController.swift
//  BLSAgenda
//
//  Created by Gene Grinberg on 3/16/15.
//  Copyright (c) 2015 Gene Grinberg. All rights reserved.
//


// accepts array and populates data table accordingly
// on segue passes back updated array of objects to the class view controller
// --> This will enable the class view controller to update the core data as necessary

import UIKit
import CoreData

class AssignmentTableViewController: UITableViewController {

    var assignmentList = [Assignment]()
    var index: Int = 1
    

    
    @IBAction func cancelToAssignmentViewController(segue: UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveAssignmentDetail(segue: UIStoryboardSegue) {
        let assignmentDetailTableController = segue.sourceViewController as AssignmentDetailTableController
        
//        let newAssignment = Assignment()
        let appDelegate = UIApplication.sharedApplication().delegate! as AppDelegate
        let context = appDelegate.managedObjectContext!
        let newAssignment: Assignment = NSEntityDescription.insertNewObjectForEntityForName("Assignment", inManagedObjectContext: context) as Assignment
        newAssignment.name = assignmentDetailTableController.nameTextField.text
        newAssignment.dueDate = assignmentDetailTableController.dateTextField.date
        newAssignment.text = assignmentDetailTableController.noteTextField.text
        
        //add the new assignment to the assignmentList array
        println("new assignment: ")
        println(newAssignment.description)
        assignmentList.append(newAssignment)
        
        //update the tableView
        let indexPath = NSIndexPath(forRow: assignmentList.count-1, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        //hide the detail view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println("title int")
        println(self.title)
        
        println("from assignment's view did load method")
        println("index: ")
        println(index)
        for i in assignmentList {
            println(i.name)
        }
  
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        println("ghetto save test: ")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return assignmentList.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AssignmentCell", forIndexPath: indexPath) as AssignmentCell
        
        let assignments = assignmentList[indexPath.row] as Assignment
        cell.nameLabel.text = assignments.name
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let s = dateFormatter.stringFromDate(assignments.dueDate)
        cell.dueDateLabel.text = s // assignments.dueDate.description
        
        return cell
    }
    
    @IBAction func unwindSegue(sender: AnyObject) {
        if let navController = self.navigationController {
            let root = navController.viewControllers.first as ClassesViewController
            root.allAssignments[index] = assignmentList
            for i in assignmentList {
                println(i.name)
            }
            println("assignment from root:")
            for i in root.allAssignments[index] {
                println(i.name)
            }
            
            println("form the unwind segue method")
            for i in root.allAssignments {
                println("this subject")
                for j in i {
                    println(j.name)
                }
            }
            
//            func saveName(name: String) {
//                let appDelegate =
//                UIApplication.sharedApplication().delegate as AppDelegate
//                
//                let managedContext = appDelegate.managedObjectContext!
//                
//                let entity =  NSEntityDescription.entityForName("Assignment",
//                    inManagedObjectContext:
//                    managedContext)
//                
//                let assignment = NSManagedObject(entity: entity!,
//                    insertIntoManagedObjectContext:managedContext)
//                
//                assignment.setValue(name, forKey: "name")
//
//                
//                var error: NSError?
//                if !managedContext.save(&error) {
//                    println("Could not save \(error), \(error?.userInfo)")
//                }
//                assignmentList.append(assignment)
//            }
//
//            override func viewWillAppear(animated: Bool) {
//                super.viewWillAppear(animated)
//                
//                let appDelegate =
//                UIApplication.sharedApplication().delegate as AppDelegate
//                
//                let managedContext = appDelegate.managedObjectContext!
//                
//                let fetchRequest = NSFetchRequest(entityName:"Assignment")
//                
//                var error: NSError?
//                
//                let fetchedResults =
//                managedContext.executeFetchRequest(fetchRequest,
//                    error: &error) as [NSManagedObject]?
//                
//                if let results = fetchedResults {
//                    assignments = results
//                }
//                else {
//                    println("Could not fetch \(error), \(error!.userInfo)")
//                }
//            }
            
            
            
            navController.popViewControllerAnimated(true)
//            let dst = self.storyboard?.instantiateViewControllerWithIdentifier("ClassesViewController") as ClassesViewController
//            dst.allAssignments[index] = assignmentList
        }
    }
    
//    func ghettoSave(index: Int, mod: Bool) -> Int {
//
//                if index.count > 0 {
//            struct Holder {
//                static var tmpIndex = index[0]
//            }
//            return Holder.tmpIndex
//        } else {
//            return 0
//        }
//
//        struct Holder {
//            var index: Int = 0
//        }
//    }


    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        println("prepare for segue called")
    }
    */

}

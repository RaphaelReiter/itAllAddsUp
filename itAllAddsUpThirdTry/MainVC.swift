//
//  MainVC.swift
//  itAllAddsUpThirdTry
//
//  Created by Raphael Reiter on 22/04/2017.
//  Copyright © 2017 Raphael Reiter. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
@IBOutlet weak var segment: UISegmentedControl!
    
    
    var controller: NSFetchedResultsController<Goal>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //generateTestData()
        attemptFetch()

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell", for: indexPath) as! GoalCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    func configureCell(cell: GoalCell, indexPath: NSIndexPath) {
        
        let goal = controller.object(at: indexPath as IndexPath)
        cell.configureCell(goal: goal)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objs = controller.fetchedObjects, objs.count > 0 {
            let goal = objs[indexPath.row]
            performSegue(withIdentifier: "GoalDetailsVC", sender: goal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoalDetailsVC" {
            if let destination = segue.destination as? GoalDetailsVC {
                if let goal = sender as? Goal {
                    destination.goalToEdit = goal
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let pointsSort = NSSortDescriptor(key: "plusOnes", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        
        if segment.selectedSegmentIndex == 0 {
            
            fetchRequest.sortDescriptors = [dateSort]
            
        } else if segment.selectedSegmentIndex == 1 {
            fetchRequest.sortDescriptors = [pointsSort]
            
        } else if segment.selectedSegmentIndex == 2 {
            fetchRequest.sortDescriptors = [titleSort]
        }
        
        
        
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath:nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    
    @IBAction func segmentChange(_ sender: Any) {
        
        attemptFetch()
        tableView.reloadData()
        
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
            
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
            break
            
        case .update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! GoalCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
                
            }
            break
            
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
        func generateTestData() {
    
            let goal = Goal(context: context)
    
            goal.title = "Daily Meditation"
            goal.plusOnes = 47
            goal.details = "Daily Meditation will help me be more present, and observe myself with more clarity "
    
            ad.saveContext()
        }


}


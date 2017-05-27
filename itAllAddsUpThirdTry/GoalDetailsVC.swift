//
//  GoalDetailsVC.swift
//  PlusOneSecondTry
//
//  Created by Raphael Reiter on 18/04/2017.
//  Copyright © 2017 Raphael Reiter. All rights reserved.
//

import UIKit
import CoreData

//let defaultScore = 0
//var userDefinedScore: Int?
//var currentScore = defaultScore ?? userDefinedScore

class GoalDetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDelegate {

    // IBOutlets:
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var dateOfEntry: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    
    
    // properties
   
    
    var currentScore = 0
    var goalToEdit: Goal? // goalToEdit is now an optional, and it needs to be unwrapped when used.
    var imagePicker: UIImagePickerController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
          
        }

        // now we need to say that if there is a goal to edit ( not equal to nil), then we load the Goal data with the loadGoalData() function.
        

        
        if goalToEdit != nil {
            
            loadGoalData()
        }
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
     
        
        
    }

    // when button is pressed, I need to 
    // 1 : add a point to the pointsLabel
    // 2 : put the current date to the dateLabel
    // 3 : persist the new points and date labels.
    
    
    // keyboard management:
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    //shut down keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    

    // buttons
    
    @IBAction func plusOneBtnPressed(_ sender: UIButton) {

        currentScore += 1
        
        pointsLabel.text = "\(currentScore)"
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = dateFormatter.string(from: date as Date)
        
        dateOfEntry.text = dateString
        
        var goal: Goal!
        
        // SAVE : 
        
        if goalToEdit == nil {
            
            goal = Goal(context: context)
        } else {
            goal = goalToEdit
        }
        
        
        // we saveed, or persisted the TITLE
        
        if let points = pointsLabel.text {
            goal.plusOnes = Int16((points as NSString).intValue)
        }
        
        if let date = dateOfEntry.text {
            goal.lastEntry = date
        }
        
        // we saved, or persisted the DATE
        
        ad.saveContext()
        
        
  }
    
  
    @IBAction func minusOneBtnPressed(_ sender: Any) {
        
        currentScore -= 1
        
        pointsLabel.text = "\(currentScore)"
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = dateFormatter.string(from: date as Date)
        
        dateOfEntry.text = dateString
        
        //SAVE:
        
        var goal: Goal!
        
        if goalToEdit == nil {
            
            goal = Goal(context: context)
        } else {
            goal = goalToEdit
        }
        
        
        if let points = pointsLabel.text {
            goal.plusOnes = Int16((points as NSString).intValue)
        }
        
    
        if let date = dateOfEntry.text {
            goal.lastEntry = date
        }
        
        // we saved, or persisted the DATE
        
        ad.saveContext()
        
       
        
       }
    
    
    @IBAction func savePressed(_ sender: Any) {
        
        var goal: Goal!
        let picture = Image(context: context) // Image = Entity
        
        picture.image = thumbImage.image // image = attribute
        
        
        
        if goalToEdit == nil {
            
            goal = Goal(context: context)
        } else {
            goal = goalToEdit
        }
        
        
        goal.toImage = picture
        
        // this is unwrapping because the original goalToEdit is an optional.

        if let title = titleTF.text {
            goal.title = title
            
        }
        
        // we saveed, or persisted the TITLE
        
        if let points = pointsLabel.text {
            goal.plusOnes = Int16((points as NSString).intValue)
        }
        
        
        // we saveed, or persisted the POINTS
        
        if let details = detailsTextView.text {
            
            goal.details = details
        }
        
      // we saved, or persisted the DETAILS
        
       // NEED TO SAVE DATE SOMEHOW !!
        // NEED TO SAVE THE STRING DATE IN THE LABEL AS A DATE IN THE CONTAINER
        
        if let date = dateOfEntry.text {
            goal.lastEntry = date
        }
        
         // we saved, or persisted the DATE
       
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    func loadGoalData() {
        
        if let goal = goalToEdit {
            titleTF.text = goal.title
            pointsLabel.text = "\(goal.plusOnes)"
            detailsTextView.text = goal.details
            dateOfEntry.text = goal.lastEntry
            thumbImage.image = goal.toImage?.image as? UIImage
            currentScore = Int(goal.plusOnes)
        }
        
    }
    
    
    
    
    @IBAction func deletePressed(_ sender: Any) {
        
        if goalToEdit != nil {
            context.delete(goalToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumbImage.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}

//
//  GoalCell.swift
//  PlusOneSecondTry
//
//  Created by Raphael Reiter on 18/04/2017.
//  Copyright © 2017 Raphael Reiter. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var details: UILabel!
    
    
    func configureCell(goal: Goal) {
        
        title.text = goal.title
        points.text = "\(goal.plusOnes) Points!"
        details.text = goal.details
        thumb.image = goal.toImage?.image as? UIImage
    }
    
}

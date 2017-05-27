//
//  InfoVC.swift
//  itAllAddsUpThirdTry
//
//  Created by Raphael Reiter on 25/04/2017.
//  Copyright © 2017 Raphael Reiter. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {

    
    @IBAction func linkToWebsite(_ sender: Any) {
        
        if let url = NSURL(string: "http://www.mydreamhackers.com"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)

    }

    }
    


}

//
//  HomeViewController.swift
//  mock
//
//  Created by Tianjiao Mo on 1/27/15.
//  Copyright (c) 2015 Tianjiao Mo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, NSFetchedResultsControllerDelegate {
    var managedObjectContext: NSManagedObjectContext?
    var showGameSegueIdentifier = "showGameSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == showGameSegueIdentifier{
        (segue.destinationViewController as GameViewController).managedObjectContext = self.managedObjectContext
        }
    }

}

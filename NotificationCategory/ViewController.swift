//
//  ViewController.swift
//  NotificationCategory
//
//  Created by Patrick DeSantis on 12/10/16.
//  Copyright © 2016 Patrick DeSantis. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reload()
    }
    
    private func reload() {
        // Disable the button until we know if the
        // categories are registered or not
        registerButton.isEnabled = false
        label.text = "Loading..."
        
        UNUserNotificationCenter.current().getNotificationCategories { (categories) in
            DispatchQueue.main.async {
                if categories.isEmpty {
                    self.label.text = "No categories registered"
                } else {
                    self.label.text = "\(categories.count) categories are registered"
                }
                self.registerButton.isEnabled = true
            }
        }
    }

    @IBAction func registerNotifications(_ sender: Any) {
        let action = UNNotificationAction(identifier: "cool-action", title: "💸", options: [])
        let category = UNNotificationCategory(identifier: "cool-category",
                                              actions: [action],
                                              intentIdentifiers: [],
                                              options: [])
        let categories = Set([category])
        UNUserNotificationCenter.current().setNotificationCategories(categories)
        reload()
    }

}


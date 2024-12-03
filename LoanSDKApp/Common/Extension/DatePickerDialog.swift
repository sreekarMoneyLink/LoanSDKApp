//
//  DatePickerDialog.swift
//  PayLink
//
//  Created by sreekar pv on 13/04/20.
//  Copyright © 2020 Santosh Gupta. All rights reserved.
//

import Foundation
import UIKit


open class DatePickerDialog {
    // Function to display date picker
    static func show(on viewController: UIViewController, title: String = "Select Date", datePickerMode: UIDatePicker.Mode = .date, minimumDate: Date? = nil, maximumDate: Date? = nil, completion: @escaping (Date) -> Void) {
        // Create the alert controller
        let alertController = UIAlertController(title: title, message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)                
        // Create and configure the date picker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = datePickerMode
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate
        datePicker.frame = CGRect(x: 0, y: 50, width:
                                    alertController.view.bounds.width, height: 200)
        // Add date picker to the alert
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 10),
            datePicker.widthAnchor.constraint(equalToConstant: alertController.view.bounds.width )        ])
        // Add "Done" button to confirm the date
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            completion(datePicker.date)
        }))
        // Add "Cancel" button
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // Present the alert
        viewController.present(alertController, animated: true, completion: nil)
    }
}

//
//  UIStoryBoardExtension.swift
//  OpenAccount
//
//  Created by Ravindra on 01/10/24.
//

import Foundation
import UIKit

var SELECTED_CARD_NAME: String = ""
extension UIViewController {

    // Generic function to instantiate and push a view controller
    func navigateToViewController(withIdentifier identifier: String, animated: Bool = true) {
        if let VC = self.storyboard?.instantiateViewController(withIdentifier: identifier) as? UIViewController {
            self.navigationController?.pushViewController(VC, animated: animated)
        } else {
            print("ViewController with identifier '\(identifier)' could not be instantiated as .")
        }
    }
    
    func validateNonEmpty(textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            return true
        } else {
            return false
        }
    }
    
 

    func updateKycLevelLabels(kycLevel : Double, level1Label:BCUILabel,level2Label:BCUILabel,level3Label:BCUILabel) {
           
           if(kycLevel == 1) {
               level1Label.backgroundColor = UIColor.darkBlueColor()
               level2Label.backgroundColor = UIColor.white
               level3Label.backgroundColor = UIColor.white
               
               level1Label.textColor = UIColor.white
               level2Label.textColor = UIColor.darkGray
               level3Label.textColor = UIColor.darkGray
           }
           else if(kycLevel > 1.0 && kycLevel < 2) {
               level1Label.backgroundColor = UIColor.darkBlueColor()
               level2Label.backgroundColor = UIColor.currentStepColor()
               level3Label.backgroundColor = UIColor.white
               
               level1Label.textColor = UIColor.white
               level2Label.textColor = UIColor.black
               level3Label.textColor = UIColor.upcomingStepTextColor()
           }
           else if(kycLevel == 2) {
               level1Label.backgroundColor = UIColor.darkBlueColor()
               level2Label.backgroundColor = UIColor.darkBlueColor()
               level3Label.backgroundColor = UIColor.white
               
               level1Label.textColor = UIColor.white
               level2Label.textColor = UIColor.white
               level3Label.textColor = UIColor.upcomingStepTextColor()
           }
           else if(kycLevel > 2.0 && kycLevel < 3.0) {
               level1Label.backgroundColor = UIColor.darkBlueColor()
               level2Label.backgroundColor = UIColor.darkBlueColor()
               level3Label.backgroundColor = UIColor.currentStepColor()
               
               level1Label.textColor = UIColor.white
               level2Label.textColor = UIColor.white
               level3Label.textColor = UIColor.black
           }
           else if(kycLevel == 3) {
               level1Label.backgroundColor = UIColor.darkBlueColor()
               level2Label.backgroundColor = UIColor.darkBlueColor()
               level3Label.backgroundColor = UIColor.darkBlueColor()
               
               level1Label.textColor = UIColor.white
               level2Label.textColor = UIColor.white
               level3Label.textColor = UIColor.white
           }
       }
    
    func formatIndianNumber(_ number: Int) -> String {
        guard number >= 0 && number <= 10_000_000_000 else {
            return "Number out of range"
        }
        
        var numberString = String(number)
        
        // Handle numbers less than 1000
        if number < 1000 {
            return numberString
        }
        
        // Format the last 3 digits
        let lastThreeDigits = String(numberString.suffix(3))
        numberString = String(numberString.dropLast(3))
        
        // Format the remaining digits in groups of 2
        var formattedNumber = lastThreeDigits
        while !numberString.isEmpty {
            let endIndex = numberString.index(numberString.endIndex, offsetBy: -min(2, numberString.count))
            let digits = String(numberString[endIndex...])
            formattedNumber = digits + "," + formattedNumber
            numberString = String(numberString.prefix(upTo: endIndex))
        }
        
        return formattedNumber
    }
    
    func getcurrentStep() -> Int {
         return 1
    }
    
    func formatToNigerianCurrency(_ amount: Double) -> String {
        // Create an instance of NumberFormatter
        let formatter = NumberFormatter()
        // Set the number style to currency
        formatter.numberStyle = .currency
        // Set the currency code to NGN for Nigerian Naira
        formatter.currencyCode = "NGN"
        // Set the currency symbol with a trailing space
        formatter.currencySymbol = "₦ "
        // Set the locale to Nigeria (English)
        formatter.locale = Locale(identifier: "en_NG")
        // Format the amount and return the string
        if let formattedAmount = formatter.string(from: NSNumber(value: amount)) {
            return formattedAmount
        } else {
            return "₦ 0.00"
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy" // Set the desired date format
        return dateFormatter.string(from: date)
    }
    
    func formatToISODate(from dateString: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        
        if let date = isoFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMMM d, yyyy     h:mm a" // Desired output format
            return outputFormatter.string(from: date)
        }
        return nil
    }
    
    
    func getDateRange() -> (String, String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Format for toDate and fromDate
        
        let today = Date()
        let fromDate = Calendar.current.date(byAdding: .day, value: -30, to: today)!
        
        let toDateString = formatter.string(from: today)
        let fromDateString = formatter.string(from: fromDate)
        
        return (toDateString, fromDateString)
    }
    
    
    func convertDateString(_ dateString: String, fromFormat: String = "yyyy-MM-dd") -> String? {
        let dateFormatter = DateFormatter()
        
        // Step 1: Convert the input string to a Date object using the provided format in UTC
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = dateFormatter.date(from: dateString) else {
            print("Invalid date format")
            return nil
        }
        
        // Step 2: Convert the Date object to the desired format in UTC
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: date)
    }
    
    func formatUTCDate(from dateString: String) -> String? {
        // Step 1: Attempt to parse as ISO 8601 date
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: dateString) {
            // Successfully parsed as ISO 8601
            return formatOutput(date: date)
        }

        // Step 2: Attempt to parse as "yyyy-MM-dd"
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        if let date = inputFormatter.date(from: dateString) {
            // Successfully parsed as "yyyy-MM-dd"
            return formatOutput(date: date, defaultTime: true)
        }

        // Return nil if neither format matches
        return nil
    }

    private func formatOutput(date: Date, defaultTime: Bool = false) -> String {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy     h:mm a" // Desired output format
        
        // Set the time zone to UTC
        outputFormatter.timeZone = TimeZone(identifier: "UTC")

        // Set a default time of 11:00 AM if required
        var finalDate = date
        if defaultTime {
            let calendar = Calendar.current
            finalDate = calendar.date(bySettingHour: 11, minute: 0, second: 0, of: date) ?? date
        }

        return outputFormatter.string(from: finalDate)
    }

    
    func dueStatusMessage(for dueDateString: String) -> String {
        // Define the date formats to handle both cases
        let dateFormats = ["yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss"]
        
        // Attempt to parse the due date string with each date format
        var dueDate: Date? = nil
        for format in dateFormats {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            if let parsedDate = dateFormatter.date(from: dueDateString) {
                dueDate = parsedDate
                break
            }
        }
        
        // If the due date is nil, return an error message
        guard let dueDate = dueDate else {
            return "Invalid date format"
        }
        
        // Get the current date in UTC without the time component
        let currentDate = Calendar.current.startOfDay(for: Date().toUTC())
        
        // Calculate the number of days between the current date and the due date
        let daysDifference = Calendar.current.dateComponents([.day], from: currentDate, to: dueDate).day ?? 0
        
        if daysDifference > 0 {
            return "Due in \(daysDifference) days"
        } else if daysDifference < 0 {
            return "Overdue by \(-daysDifference) days"
        } else {
            return "Due today"
        }
    }
    
    func getFormattedDateInUTC() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: Date())
    }
    
    func showCardConfirmationAlert(isBlocking: Bool, onConfirm: ((UIAlertAction) -> Void)? = nil) {
        let action = isBlocking ? "Block" : "Unblock"
        let alert = UIAlertController(
            title: "Confirm \(action) Card",
            message: isBlocking ? "Are you sure you want to block your card? This action will prevent all transactions until you unblock it." : "Are you sure you want to unblock your card? This will allow transactions to resume immediately.",preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: onConfirm)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        // Presenting the alert in your view controller
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let topController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                topController.present(alert, animated: true, completion: nil)
            }
        }

    }
    
    func showCardRemovalConfirmationAlert(isRemoveCard: Bool, onConfirm: ((UIAlertAction) -> Void)? = nil) {
        let action = isRemoveCard ? "Remove" : "Remove"
        let alert = UIAlertController(
            title: "Confirm \(action) Card",
            message: "Are you sure you want to remove your card? This action is permanent and cannot be undone.",preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: onConfirm)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        // Presenting the alert in your view controller
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let topController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                topController.present(alert, animated: true, completion: nil)
            }
        }

    }
    
    func showSuccess(_ message: String) {
       let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
       self.present(alert, animated: true, completion: nil)
   }
    
    func addDoneButtonOnKeyboard(textField:BCUITextField) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = .black
        doneToolbar.isTranslucent = true
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))

        let items: [UIBarButtonItem] = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        textField.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }

}

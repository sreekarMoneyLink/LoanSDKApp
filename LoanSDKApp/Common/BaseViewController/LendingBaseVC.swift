//
//  LendingBaseVC.swift
//  UniversalSDKApp
//
//  Created by Ravindra on 29/11/24.
//

import UIKit

let SCREEN_WIDTH =  UIScreen.main.bounds.size.width
let SCREEN_HEIGHT =  UIScreen.main.bounds.size.height


class LendingBaseVC: KeyboardManagingViewController,AlertDisplayer {
    var dimmingView = UIView()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupStatusBarBackground()
        self.setupActivityIndicator()
        self.setupNavigationBar()
    }
    
    func setupActivityIndicator() {
        dimmingView = UIView(frame: view.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimmingView.tag = 100  // Add a tag so you can remove it later if needed
        dimmingView.isHidden = true
        view.addSubview(dimmingView)
        activityIndicator.center = dimmingView.center
        dimmingView.addSubview(activityIndicator)
    }
    func showLoader(_ show: Bool) {
        if let dimmingView = view.viewWithTag(100) {
            dimmingView.isHidden = !show
            show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
    
    func displayErrorAlert(message:String){
        let title = "Error"
        let action = UIAlertAction(title: "OK", style: .default)
        self.displayAlert(with: title , message: message, actions: [action])
    }

    // Set up the common navigation bar
        func setupNavigationBar(setBgColor:Bool = false) {
            // Set background color
            self.navigationController?.navigationBar.backgroundColor = setBgColor ? UIColor.black : UIColor.navigationBarColor()
            self.navigationController?.navigationBar.tintColor =  setBgColor ? UIColor.black : UIColor.navigationBarColor()
            
            // Create a container view to hold the image and provide extra bottom padding
               let titleContainerView = UIView()
               titleContainerView.translatesAutoresizingMaskIntoConstraints = false
               // Set up the image view with your image
               let titleImageView = UIImageView(image: UIImage(named: "lendingLogo"))
               titleImageView.contentMode = .scaleAspectFit
               titleImageView.translatesAutoresizingMaskIntoConstraints = false
               // Add the image view to the container view
               titleContainerView.addSubview(titleImageView)
               // Set up the constraints for the image view within the container
               NSLayoutConstraint.activate([
                   titleImageView.centerXAnchor.constraint(equalTo: titleContainerView.centerXAnchor),
                   titleImageView.centerYAnchor.constraint(equalTo: titleContainerView.centerYAnchor, constant: 0), // Adjust vertical alignment to simulate padding
                   titleImageView.widthAnchor.constraint(equalToConstant: 130), // Set width of image
                   titleImageView.heightAnchor.constraint(equalToConstant: 70)  // Set height of image
               ])
               // Set the container view as the title view of the navigation item
               self.navigationItem.titleView = titleContainerView
               // Optionally set container constraints
               NSLayoutConstraint.activate([
                   titleContainerView.widthAnchor.constraint(equalToConstant: 100),  // Match image width
                   titleContainerView.heightAnchor.constraint(equalToConstant: 50)   // Add extra height for padding
               ])
               
            if let leftImage = UIImage(named: "back_icon"){
                let resizedImage = resizeImage(image: leftImage, targetSize:CGSize(width: 24, height: 24))
                let rightButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(backButtonTapped))
                rightButton.tintColor = .white
                self.navigationItem.leftBarButtonItem = rightButton
            }
            
            // Create the image
            if let rightImage = UIImage(named: "Home_icon"){
                let resizedImage = resizeImage(image: rightImage, targetSize:CGSize(width: 35, height: 35))
                let rightButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(homeButtonTapped))
                rightButton.tintColor = .white
                self.navigationItem.rightBarButtonItem = rightButton
            }
            
        }

        // Action for the back button
        @objc private func backButtonTapped() {
            self.moveToPreviousScreen()
//            self.navigationController?.popViewController(animated: true)
        }
    
    
    func moveToPreviousScreen() {
        if let viewControllers = navigationController?.viewControllers {
            // Check if there are at least two view controllers in the stack
            if viewControllers.count >= 2 {
                // Get the previous view controller
                let previousViewController = viewControllers[viewControllers.count - 2]
                let currentViewController = viewControllers[viewControllers.count - 1]
                if previousViewController is LendingAppPinVC && currentViewController is LoanRequestSuccessVC {
                    let _ = viewControllers[viewControllers.count - 3]
                    navigationController?.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
                }else {
                    // Otherwise, pop to the previous view controller
                    navigationController?.popViewController(animated: true)
                }
            } else {
                // If there's only one view controller, you can handle it here if needed
                navigationController?.popViewController(animated: true)
            }
        }

    }

        // Action for the home button
        @objc private func homeButtonTapped() {
            // Navigate to the home view controller
            self.navigationController?.popToRootViewController(animated: true)
        }
    
    func setupStatusBarBackground(bgColor:UIColor? = UIColor.navigationBarColor()) {
               // Get the height of the status bar
        // Get the height of the status bar
           var statusBarHeight: CGFloat = 0
           
           if #available(iOS 13.0, *) {
               // For iOS 13 and later, use statusBarManager
               if let windowScene = view.window?.windowScene {
                   statusBarHeight = windowScene.statusBarManager?.statusBarFrame.height ?? 0
               }
           } else {
               // For iOS versions before 13.0
               statusBarHeight = UIApplication.shared.statusBarFrame.height
           }
           
           if statusBarHeight > 0 {
               // Create a view with the same height as the status bar
               let statusBarView = UIView()
               statusBarView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: statusBarHeight)
               statusBarView.backgroundColor = bgColor

               // Add the status bar background view to the main view
               view.addSubview(statusBarView)
           }
              
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Helper method to resize the image
    // Helper method to resize the image

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        // Calculate scale factor to maintain aspect ratio
        let scaleFactor = min(targetSize.width / image.size.width, targetSize.height / image.size.height)
        
        // Calculate new size based on scale factor
        let newSize = CGSize(width: image.size.width * scaleFactor, height: image.size.height * scaleFactor)
        
        // Begin graphics context
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        // Draw the image and retrieve the new resized image
        image.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    
    func isValidMobileNumber(_ number: String) -> Bool {
        let mobileRegex = "^[0-9*]{10}$"
        let mobilePredicate = NSPredicate(format: "SELF MATCHES %@", mobileRegex)
        return mobilePredicate.evaluate(with: number)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func showFailure(_ message: String) {
       let alert = UIAlertController(title: "Failure", message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
       self.present(alert, animated: true, completion: nil)
   }

    func showError(_ message: String) {
       let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
       self.present(alert, animated: true, completion: nil)
   }
    
    func createDoneToolbar() -> UIToolbar {
           let toolbar = UIToolbar()
           toolbar.sizeToFit()

           // Create a flexible space and a "Done" button
           let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))

           toolbar.items = [flexSpace, doneButton]
           return toolbar
       }
       
       @objc func doneButtonTapped() {
           view.endEditing(true)  // Dismiss the keyboard
       }
    
    func removeTrailingZero(from numberString: String) -> String {
        if numberString.hasSuffix(".0") {
            return String(numberString.dropLast(2)) // Remove the ".0"
        }
        return numberString
    }

    
}

import UIKit
import Foundation

public class MyAppSDKManager {
    
    private static var sdkNavigationController: UINavigationController?

    public static func launchLending(from presentingViewController: UIViewController?, isPush: Bool?) {
        // Load the storyboard
        let storyboard = UIStoryboard(name: "Lending", bundle: Bundle(for: FinServiceVC.self))
        
        // Instantiate the FinServiceVC
        guard let finServiceVC = storyboard.instantiateViewController(withIdentifier: "FinServiceVC") as? FinServiceVC else {
            print("Failed to instantiate FinServiceVC from storyboard.")
            return
        }
        // Initialize the navigation controller if it's not already created
        if sdkNavigationController == nil {
            sdkNavigationController = UINavigationController(rootViewController: finServiceVC)
            // Customize the navigation bar
            sdkNavigationController?.navigationBar.backgroundColor = UIColor.navigationBarColor()
            sdkNavigationController?.navigationBar.tintColor = .white
            sdkNavigationController?.navigationItem.title = "Lending"
            // Additional setup for the navigation bar if needed
            finServiceVC.setupNavigationBar()  // Un-comment if required
        }
        // Present the SDK's navigation controller
        sdkNavigationController?.modalPresentationStyle = .fullScreen
        sdkNavigationController?.modalTransitionStyle = .coverVertical
        if(isPush == true){
            presentingViewController?.navigationController?.pushViewController(finServiceVC, animated: true)
        }
        else{
            presentingViewController?.present(sdkNavigationController!, animated: true, completion: nil)
        }
    }
}

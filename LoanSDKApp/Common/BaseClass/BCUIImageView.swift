import UIKit
import Alamofire

@IBDesignable
internal class BCUIImageView: UIImageView {
    
    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    // MARK: - IBInspectable Properties
    
    /// The corner radius of the image view.
    @IBInspectable var corner: CGFloat = 0.0 {
        didSet {
            updateCornerRadius()
        }
    }
    
    /// Whether the view should clip its subviews to its bounds.
    @IBInspectable var clip: Bool = false {
        didSet {
            self.clipsToBounds = clip
        }
    }
    
    /// The border color of the image view.
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    /// The border width of the image view.
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    // MARK: - Helper Methods
    private func updateCornerRadius() {
        self.layer.cornerRadius = corner
    }
    
    // MARK: - Image Downloading
    
    /// Downloads and sets the image from the given URL using Alamofire.
    /// - Parameters:
    ///   - urlString: The string representation of the image URL.
    ///   - placeholder: An optional placeholder image to display while downloading.
    func downloadImage(from urlString: String, placeholder: UIImage? = nil) {
        // Set placeholder image if provided
        if let placeholder = placeholder {
            self.image = placeholder
        } else {
            self.image = nil // Clear image while loading
        }
        
        // Validate and create URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }
        
        // Use Alamofire to download the image
        AF.request(url).responseData { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let data):
                if let downloadedImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = downloadedImage
                    }
                } else {
                    print("Failed to convert downloaded data to UIImage.")
                }
            case .failure(let error):
                print("Failed to download image: \(error.localizedDescription)")
            }
        }
    }
}


//
//  FilmDetailVC.swift
//  ios-interview-test
//

import UIKit

class FilmDetailVC : UIViewController {
    
    // MARK: UI Variables
    
    private let venueButton = UIButton()
    private let imageView: UIImageView = UIImageView()

    // MARK: Variables

    private let film: Film

    // MARK: init Methods

    init? (film: Film) {
        self.film = film
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom Methods
    
    func createUI() {
        
        title = film.name
        self.view.backgroundColor = .white
        
        let displayWidth: CGFloat = view.frame.width
        
        imageView.frame.size = CGSize(width: 200, height: 350)
        imageView.frame.origin = CGPoint(x: displayWidth/2-imageView.frame.size.width/2, y: 50)
        view.addSubview(imageView)
        
        venueButton.frame.size = CGSize(width: imageView.frame.size.width, height: 50)
        venueButton.frame.origin = CGPoint(x: displayWidth/2-venueButton.frame.size.width/2, y: imageView.frame.size.height + venueButton.frame.size.height)
        venueButton.setTitle("Venue", for: .normal)
        venueButton.setTitleColor(.black, for: .normal)
        venueButton.layer.borderColor = UIColor.black.cgColor
        venueButton.layer.borderWidth = 1
        view.addSubview(venueButton)
        
        // Action Method
        venueButton.addAction {
            guard let venuedetailVC = VenueDetailVC.init(film: self.film) else {
                return
            }
            self.navigationController?.pushViewController(venuedetailVC, animated: true)
        }
        
    }
    
    func fetchImage() {
        DispatchQueue.global(qos: .userInitiated).async {
            let imageUrl = self.film.thumbnailUrl
            var imageData: NSData
            do {
                imageData = try NSData(contentsOf: imageUrl)
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.imageView.image = image
                    self.imageView.contentMode = UIViewContentMode.scaleAspectFit
                }
            } catch {
                print("Error downloading image")
            }
        }
    }
    
    // MARK: View Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createUI()
        self.fetchImage()
 
    }
    
}

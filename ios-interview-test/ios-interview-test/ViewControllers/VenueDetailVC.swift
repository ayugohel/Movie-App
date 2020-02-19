//
//  VenueDetailVC.swift
//  ios-interview-test
//

import UIKit

class VenueDetailVC: UIViewController {
    
    // MARK: UI Variables

    private let lblName = UILabel()
    private let lblAddress = UILabel()
    private let imageView: UIImageView = UIImageView()

    // MARK:   Variables

    private let film: Film
    
    init? (film: Film) {
        self.film = film
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Model Declaration
    
    lazy var viewModel: VenueDetailViewModel = {
        return VenueDetailViewModel(uid: film.venueId)
    }()
    
    // MARK: Custom Methods
    
    func createUI() {
        
        title = "Venue Details"
        self.view.backgroundColor = .white
        
        let displayWidth: CGFloat = view.frame.width
        
        imageView.frame.size = CGSize(width: 200, height: 350)
        imageView.frame.origin = CGPoint(x: displayWidth/2-imageView.frame.size.width/2, y: 50)
        view.addSubview(imageView)
        
        lblName.frame.size = CGSize(width: displayWidth, height: 40)
        lblName.numberOfLines = 0
        lblName.lineBreakMode = .byWordWrapping
        lblName.frame.origin = CGPoint(x: 15, y: imageView.frame.origin.y + imageView.frame.height + 20)
        view.addSubview(lblName)

        lblAddress.frame.size = CGSize(width: displayWidth, height: 40)
        lblAddress.numberOfLines = 0
        lblAddress.lineBreakMode = .byWordWrapping
        lblAddress.frame.origin = CGPoint(x: 15 , y: lblName.frame.origin.y + lblName.frame.height + 20)
        view.addSubview(lblAddress)
        
    }
    
    func updateLabelData() {
        self.lblName.text = "Name : " + viewModel.getViewModel().name
        self.lblName.sizeToFit()
        self.lblAddress.text = "Address : " + viewModel.getViewModel().address
        self.lblAddress.sizeToFit()
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
    
    func fetchVenueDetail() {
        
        // Get Data
        viewModel.getDataClouser = { [weak self] () in
            DispatchQueue.main.async {
                self?.updateLabelData()
            }
        }
        
    }

    // MARK: View Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createUI()
        self.fetchImage()
        self.fetchVenueDetail()
        
    }


}

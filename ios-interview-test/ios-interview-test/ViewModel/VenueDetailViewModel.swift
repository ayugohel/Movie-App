//
//  VenueDetailViewModel.swift
//  ios-interview-test
//

import Foundation
import UIKit

class VenueDetailViewModel : NSObject {
    
    // MARK: Variables

    var uID: Int
    private var films: [Film] = []
    var getDataClouser: (()->())?
    
    /**
     init() Method
     */
    init(uid: Int) {
      
        self.uID = uid
        super.init()
        
        initFetchVenueData()

    }
    
    private var ViewModel: Venue? = nil {
        didSet {
            self.getDataClouser?()
        }
    }
    
    /**
     Fetch Data from Json
     */
    func initFetchVenueData() {
        
        Venue.getVenue(uid: uID) { (result) in
            switch result {
            case .success(let venueObject):
                self.ViewModel = venueObject
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    /**
     Get Data from Model
     */
    func getViewModel() -> Venue {
        return ViewModel!
    }
    
}







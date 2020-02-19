//
//  FilmViewModel.swift
//  ios-interview-test
//

import Foundation
import UIKit

class FilmViewModel : NSObject {
    
    // MARK: Variables

    var uID: Int
//    var films: [Film] = []
    var reloadTableViewClosure: (()->())?

    /**
     init() Method
     */
    init(uid: Int) {
        self.uID = uid
        super.init()

        initFetch()
    }

    private var cellViewModels: [Film] = [Film]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    /**
     Get Cell counts
     */
    var numberOfCells: Int {
        return cellViewModels.count
    }

    /**
     Get FilmsData from Json
     */
    func initFetch() {
        
        Film.getFilms(category: uID) { (result) in
            
            switch result {
            case .success(let filmObjects):
                self.cellViewModels = filmObjects
//                self.films = filmObjects
                print(filmObjects)
                
            case .failure(let error):
                print("error: \(error.localizedDescription)")
//                fatalError("error: \(error.localizedDescription)")
            }
        }
    }
    
    /**
     Get Cell Data
     */
    func getCellViewModel( at indexPath: IndexPath ) -> Film {
        return cellViewModels[indexPath.row]
    }
  
}

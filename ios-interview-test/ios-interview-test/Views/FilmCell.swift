//
//  FilmCell.swift
//  ios-interview-test
//

import Foundation
import UIKit

class FilmCell: UITableViewCell {
    
    var film: Film? = nil
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(film: Film) {
        
        self.textLabel?.text = film.name
        let imageUrl = film.thumbnailUrl
        do {
            let imageData:NSData = try NSData(contentsOf: imageUrl)
            let image = UIImage(data: imageData as Data)
            self.imageView?.image = image
            self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        } catch {
            print("Error downloading image")
        }
        
    }
}

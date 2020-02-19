//
//  FilmCategory.swift
//  ios-interview-test
//

import Foundation

struct FilmCategory {
    
    enum Category: String {
        case Action
        case Comedy
        case Drama
        case Other
    }
    
    let uid: Int
    let category: Category
    
    init(uid: Int) {
        self.uid = uid
        switch uid {
        case 1:
            self.category = Category.Action
        case 2:
            self.category = Category.Comedy
        case 3:
            self.category = Category.Drama
        default:
            self.category = Category.Other
        }
    }
    
    static func allCategories() -> [FilmCategory] {
        let action = FilmCategory.init(uid: 1)
        let comedy = FilmCategory.init(uid: 2)
        let drama = FilmCategory.init(uid: 3)
        return [action, comedy, drama]
    }
}

//
//  ios_interview_testTests.swift
//  ios-interview-testTests
//
//

import XCTest
@testable import ios_interview_test

final class ios_interview_testTests: XCTestCase {
    
    private var filmCategory: FilmCategory!
    private var film: Film!
    private var venue: Venue!
    
    override func setUp() {
        super.setUp()
        
        filmCategory = FilmCategory(uid: 1)
        film = Film(uid: 1, name: "Test", shortDesc: "Test", duration: 105, thumbnailUrl: URL.init(string: "https://testUrl.com")!, categoryId: 1, venueId: 1)
        venue = Venue(uid: 1, name: "Test", address: "1234 Test St, San Francisco, 90201")
    }
    
    override func tearDown() {
        super.tearDown()
        filmCategory = nil
        film = nil
        venue = nil
    }
    
    func categoryTest() {
        XCTAssertEqual(film.categoryId, filmCategory.uid)
    }
    
    func venueTest() {
        XCTAssertEqual(film.venueId, venue.uid)
    }
}

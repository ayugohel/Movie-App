//
//  ios_interviewTest.swift
//  ios-interview-testTests
//

import XCTest
@testable import ios_interview_test

class ios_interviewTest: XCTestCase {
    
    private var filmCategory: FilmCategory!
    private var film: Film!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        filmCategory = FilmCategory(uid: 1)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFilmsViewModel() {
        
        let viewModel: FilmViewModel = {
            return FilmViewModel(uid: filmCategory.uid)
        }()
        
        // Given
        var tempfilms = filmStubGenerator().stubFilms()
        tempfilms = tempfilms.filter { $0.categoryId == filmCategory.uid}
        
        let expect = XCTestExpectation(description: "reload closure triggered")
        viewModel.reloadTableViewClosure = { () in
            expect.fulfill()
        }
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 5.0)
        
        // Number of cell view model is equal to the number of count
        XCTAssertEqual( viewModel.numberOfCells, tempfilms.count )
        
    }
    
    func testVenueViewModel() {

        var tempfilms = filmStubGenerator().stubFilms()
        tempfilms = tempfilms.filter { $0.categoryId == filmCategory.uid}
        
        let viewModel: VenueDetailViewModel = {
            return VenueDetailViewModel(uid: tempfilms[0].venueId)
        }()
        
//        // Given
//        var tempVenue = venueStubGenerator().stubVenue()
//        tempVenue = tempVenue.filter({ $0.uid == tempfilms[0].venueId })
        
        viewModel.getDataClouser = { [weak self] () in
            XCTAssertEqual( viewModel.getViewModel().uid, tempfilms[0].venueId )
        }
        
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

class filmStubGenerator {
    func stubFilms() -> [Film] {
        let path = Bundle.main.path(forResource: "movielistjson", ofType: "json")!
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let films = try! decoder.decode([Film].self, from: jsonData)
        return films
    }
}

class venueStubGenerator {
    func stubVenue() -> [Venue] {
        let path = Bundle.main.path(forResource: "venuelistjson", ofType: "json")!
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let venues = try! decoder.decode([Venue].self, from: jsonData)
        return venues
    }
}

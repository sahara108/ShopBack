//
//  MovieDetailModelTest.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/6/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import ShopBack
class NetworkProviderTest: XCTestCase {
    var expectation: XCTestExpectation?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetMovieOverview() {
        let provider = NetworkProvider()
        
        //load movie overview with simple config
        expectation = expectation(description: "load movie overview with simple configure")
        provider.loadMovieOviews(config: RequestConfig()) { (pagination,list, error) in
            XCTAssertNil(error)
            self.expectation?.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            if error != nil {
                XCTFail("Network error")
            }
        }
    }
    
    func testGetMovieDetail() {
        //Oh I don't why with those ids, the server returns me {\n  \"status_code\" : 34,\n  \"status_message\" : \"The resource you requested could not be found.\"\n}. It could be a limitation so I cannot test it
//        let movieIds = ["439468", "440656", "256822", "328749", "169181", "441580", "377596", "18702", "18703", "18704", "24305", "24306", "24307", "16726", "16727", "16729", "18710", "18711", "16731", "16759"]
        let movieIds = ["328111"] //seems that only this id will return value
        let provider = NetworkProvider()
        
        var count = 0
        while count < movieIds.count {
            let id = movieIds[count]
            
            expectation = expectation(description: "download movie detail")
            provider.loadMovieDetail(movieId: id, config: RequestConfig(), completion: { (detail, error) in
                XCTAssertNotNil(detail)
                self.expectation?.fulfill()
            })
            
            waitForExpectations(timeout: 60, handler: { (error) in
                if error != nil {
                    XCTFail("Network error")
                }
            })
            
            count += 1
        }
    }
    
}

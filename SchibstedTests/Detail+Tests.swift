//
//  Detail+Tests.swift
//  SchibstedTests
//
//  Created by Odet Alexandre on 05/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import XCTest
@testable import Schibsted

class Detail_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testWithGoodJSON() {
        if let jsonUrl = Bundle.main.url(forResource: "EventDetail", withExtension: "json") {
            do {
                let data = try Data(contentsOf: jsonUrl)
                let detail = try JSONDecoder().decode(Detail.self, from: data)
                XCTAssertNotNil(detail)
                let event = detail.event
                XCTAssertNotNil(event)
                XCTAssertEqual(event.id, 389093)
                
                XCTAssertNotNil(event.homeTeam)
                XCTAssertEqual(event.homeTeam.id, "1737")
                XCTAssertEqual(event.homeTeam.name, "Leicester City")
                XCTAssert(event.homeTeam.isWinner == false)
                
                XCTAssertNotNil(event.awayTeam)
                XCTAssertEqual(event.awayTeam.id, "1750")
                XCTAssertEqual(event.awayTeam.name, "AFC Bournemouth")
                XCTAssert(event.awayTeam.isWinner == false)
                
                XCTAssertNotNil(event.venue)
                XCTAssertEqual(event.venue?.name, "King Power Stadium")
                XCTAssertEqual(event.venue?.city, "Leicester")
                
                XCTAssertNotNil(event.status)
                XCTAssertEqual(event.status.type, "inProgress")
                
                XCTAssertNotNil(event.result)
                XCTAssertEqual(event.result.runningScore.home, 1)
                XCTAssertEqual(event.result.runningScore.away, 4)
                
                
            } catch {
                XCTFail("Can't parse JSON")
            }
        }
    }
    
    func testWithBadJSON() {
        if let jsonUrl = Bundle.main.url(forResource: "Events", withExtension: "json") {
            do {
                let data = try Data(contentsOf: jsonUrl)
                XCTAssertThrowsError(try JSONDecoder().decode(Detail.self, from: data))
            } catch {
                XCTFail("Can't get data from JSON")
            }
        }
    }
    
    func testWithInexistantJSON() {
        let jsonUrl = Bundle.main.url(forResource: "Dummy", withExtension: "json")
        XCTAssertNil(jsonUrl)
    }
    
}

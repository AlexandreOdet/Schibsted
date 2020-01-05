//
//  RestAPIEvent.swift
//  SchibstedTests
//
//  Created by Odet Alexandre on 05/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import XCTest
@testable import Schibsted

class League_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWithGoodJSON() {
        if let jsonUrl = Bundle.main.url(forResource: "Events", withExtension: "json") {
            do {
                let data = try Data(contentsOf: jsonUrl)
                let leagues = try JSONDecoder().decode([League].self, from: data)
                XCTAssertNotNil(leagues)
                XCTAssertEqual(leagues.count, 2)
                
                let firstLeague = leagues.first
                XCTAssertNotNil(firstLeague)
                XCTAssertEqual(firstLeague?.id, 38)
                XCTAssertEqual(firstLeague?.name, "Eliteserien")
                XCTAssertNotNil(firstLeague?.events)
                XCTAssertEqual(firstLeague?.events.count, 1)
                
                let event = firstLeague?.events.first
                XCTAssertNotNil(event)
                XCTAssertEqual(event?.id, 377462)
                
                XCTAssertNotNil(event?.homeTeam)
                XCTAssertNotNil(event?.homeTeam.id)
                XCTAssertEqual(event?.homeTeam.id, "22984")
                XCTAssertEqual(event?.homeTeam.name, "Stabæk")
                XCTAssert(event?.homeTeam.isWinner == false)

                XCTAssertNotNil(event?.awayTeam)
                XCTAssertNotNil(event?.awayTeam.id)
                XCTAssertEqual(event?.awayTeam.id, "22981")
                XCTAssertEqual(event?.awayTeam.name, "Strømsgodset")
                XCTAssert(event?.awayTeam.isWinner == false)

                XCTAssertNotNil(event?.result)
                XCTAssertEqual(event?.result.runningScore.home, 0)
                XCTAssertEqual(event?.result.runningScore.away, 0)
                
                XCTAssertNotNil(event?.status)
                XCTAssertEqual(event?.status.type, "notStarted")
                
                XCTAssertNil(event?.venue)
                
            } catch {
                XCTFail("Can't parse JSON")
            }
        }
    }
    
    func testWithBadJSON() {
        if let jsonUrl = Bundle.main.url(forResource: "EventDetail", withExtension: "json") {
            do {
                let data = try Data(contentsOf: jsonUrl)
                XCTAssertThrowsError(try JSONDecoder().decode([League].self, from: data))
            } catch {
                XCTFail("Can't get data from JSON")
            }
        }
    }
    
    func testWithInexistantJSON() {
        let jsonUrl = Bundle.main.url(forResource: "Dummy", withExtension: "json")
        XCTAssertNil(jsonUrl)
    }
    
    
    func testWithEmptyArray() {
        if let jsonUrl = Bundle.main.url(forResource: "Events", withExtension: "json") {
            do {
                let data = try Data(contentsOf: jsonUrl)
                var leagues = try JSONDecoder().decode([League].self, from: data)
                XCTAssertNotNil(leagues)
                XCTAssertEqual(leagues.count, 2)
                leagues.removeAll()
                XCTAssertNotNil(leagues)
                XCTAssertEqual(leagues.count, 0)
            } catch {
                XCTFail("Can't parse JSON")
            }
        }
    }
}

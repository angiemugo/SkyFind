//
//  AirportModelTest.swift
//  SkyFindTests
//
//  Created by Angie Mugo on 14/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import XCTest
@testable import SkyFind

class AirportModelTest: XCTestCase {

    var scheduleModel: ScheduleResource!
    override func setUp() {
        guard let path = Bundle.main.path(forResource: "flightSchedule", ofType: "json") else {
            fatalError("MockData not found")
        }
         do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            scheduleModel = try JSONDecoder().decode(ScheduleResource.self, from: data)
        } catch{
            XCTFail("could not load json object: \(error.localizedDescription)")
        }
    }

    func test_decodes_correctly() {
        XCTAssertNotEqual(scheduleModel.schedule.schedule.count, 0)
        XCTAssertEqual(scheduleModel.schedule.schedule[0].flight[0].arrival.aiportCode, "ZRH")
        XCTAssertNotEqual(scheduleModel.schedule.schedule[0].totalJourney.duration, "PT1H10M")
    }
}

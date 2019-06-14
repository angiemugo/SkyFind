//
//  FlightModel.swift
//  SkyFind
//
//  Created by Angie Mugo on 10/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import Foundation

struct ScheduleResource {
    var schedule: Schedules
}

extension ScheduleResource: Decodable {
    enum CodingKeys: String, CodingKey {
        case Schedule = "ScheduleResource"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        schedule = try container.decode(Schedules.self, forKey: .Schedule)
    }

    init(from data: Data) throws {
        self = try JSONDecoder().decode(ScheduleResource.self, from: data)
    }
}

struct Schedules {
    var schedule: [Schedule]
}

extension Schedules: Decodable {
    enum CodingKeys: String, CodingKey {
        case Schedule = "Schedule"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        schedule = try container.decode([Schedule].self, forKey: .Schedule)
    }
}

struct Schedule {
    var totalJourney: TotalJourney
    var flight: Flight
}

extension Schedule: Decodable {
    enum CodingKeys: String, CodingKey {
        case TotalJourney = "TotalJourney"
        case Flight = "Flight"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        totalJourney = try container.decode(TotalJourney.self, forKey: .TotalJourney)
        flight = try container.decode(Flight.self, forKey: .Flight)
    }
}

struct TotalJourney {
    var duration: String
}

extension TotalJourney: Decodable {
    enum CodingKeys: String, CodingKey {
        case Duration = "Duration"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        duration = try container.decode(String.self, forKey: .Duration)
    }
}

struct Flight {
    var arrival: DepartureArrival
    var departure: DepartureArrival
}

extension Flight: Decodable {
    enum CodingKeys: String, CodingKey {
        case Arrival = "Arrival"
        case Departure = "Departure"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        arrival = try container.decode(DepartureArrival.self, forKey: .Arrival)
        departure = try container.decode(DepartureArrival.self, forKey: .Departure)
    }
}

struct DepartureArrival {
    var aiportCode: String
    var scheduledTime: Time
}

extension DepartureArrival: Decodable {
    enum CodingKeys: String, CodingKey {
        case AirportCode = "AirportCode"
        case ScheduledTimeLocal = "ScheduledTimeLocal"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        aiportCode = try container.decode(String.self, forKey: .AirportCode)
        scheduledTime = try container.decode(Time.self, forKey: .ScheduledTimeLocal)
    }
}


struct Time {
    var time: String
}

extension Time: Decodable {
    enum CodingKeys: String, CodingKey {
        case Time = "DateTime"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        time = try container.decode(String.self, forKey: .Time)
    }
}

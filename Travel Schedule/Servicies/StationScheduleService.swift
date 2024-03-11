//
//  StationScheduleService.swift
//  Travel Schedule
//
//  Created by Aleksandr Garipov on 10.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Schedule = Components.Schemas.StationSchedule

protocol StationScheduleServiceProtocol {
    func getScheduleFor(station: String, limit: Int?, date: String?) async throws -> Schedule
}

final class StationScheduleService: StationScheduleServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getScheduleFor(station: String, limit: Int?, date: String?) async throws -> Schedule {
        let response = try await client .getSchedule(query: .init(station: station, date: date))
        return try response.ok.body.json
    }
}

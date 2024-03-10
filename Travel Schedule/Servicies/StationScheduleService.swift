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
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getScheduleFor(station: String, limit: Int?, date: String?) async throws -> Schedule {
        let response = try await client .getSchedule(query: .init(apikey: apikey, station: station, date: date))
        return try response.ok.body.json
    }
}

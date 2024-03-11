//
//  CopyrightService.swift
//  Travel Schedule
//
//  Created by Aleksandr Garipov on 09.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.CopyrightAnswer

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getCopyright() async throws -> Copyright {
        let response = try await client.getCopyright(query: .init())
        return try response.ok.body.json
    }
}

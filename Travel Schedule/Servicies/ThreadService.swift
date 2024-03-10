//
//  ThreadService.swift
//  Travel Schedule
//
//  Created by Aleksandr Garipov on 10.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Thread = Components.Schemas.SingleThread

protocol ThreadServiceProtocol {
    func getThread(threadUID: String) async throws -> Thread
}

final class ThreadService: ThreadServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getThread(threadUID: String) async throws -> Thread {
        let response = try await client .getThread(query: .init(apikey: apikey, uid: threadUID))
        return try response.ok.body.json
    }
}

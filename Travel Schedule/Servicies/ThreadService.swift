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
    
    init(client: Client) {
        self.client = client
    }
    
    func getThread(threadUID: String) async throws -> Thread {
        let response = try await client .getThread(query: .init(uid: threadUID))
        return try response.ok.body.json
    }
}

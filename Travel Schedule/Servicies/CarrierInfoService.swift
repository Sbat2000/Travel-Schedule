//
//  CarrierInfoService.swift
//  Travel Schedule
//
//  Created by Aleksandr Garipov on 10.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Carrier = Components.Schemas.Carriers

protocol CarrierInfoServiceProtocol {
    func getCarrier(code: String) async throws -> Carrier
}

final class CarrierInfoService: CarrierInfoServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    
    func getCarrier(code: String) async throws -> Carrier {
        let response = try await client.getCarrierInfo(query: .init(
            code: code
        ))
        return try response.ok.body.json
    }
}

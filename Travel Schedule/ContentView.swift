//
//  ContentView.swift
//  Travel Schedule
//
//  Created by Aleksandr Garipov on 29.02.2024.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Показать ближайшие станции") {
                stations()
            }
            .padding()
            Button("Показать копирайт") {
                copyright()
            }
        }
        .padding()
    }
    
    //MARK: - Actions
    
    func stations() {
        let client = Client (
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = NearestStationsService(client: client, apikey: Constants.apiKey)
        
        Task {
            do {
                let stations = try await service.getNearestStations(lat: 52.253976, lng: 104.327458, distance: 5)
                print(stations)
            } catch {
                print("Ошибка  \(error)")
            }
        }
    }
    
    func copyright() {
        let client = Client (
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = CopyrightService(client: client, apikey: Constants.apiKey)
        
        Task {
            do {
                let copyright = try await service.getCopyright()
                print(copyright)
            } catch {
                print("Ошибка  \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}

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
            .padding()
            Button("Показать маршрут Иркутск - Москва") {
                getRoutes()
            }
            .padding()
            Button("Показать расписание аэропорта Иркутск") {
                getRoutes()
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
    
    func getRoutes() {
        let client = Client (
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = SearchRouteService(client: client, apikey: Constants.apiKey)
        
        Task {
            do {
                let copyright = try await service.getRoutes(from: Constants.Cities.irktusk, to: Constants.Cities.moscow, limit: 1)
                print(copyright)
            } catch {
                print("Ошибка  \(error)")
            }
        }
    }
    
    func getScheduleFor() {
        let client = Client (
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = StationScheduleService(client: client, apikey: Constants.apiKey)
        
        Task {
            do {
                let schedule = try await service.getScheduleFor(station: Constants.StationCode.airportIrkutst, limit: 5, date: "2024-03-10")
            } catch {
                print("Ошибка  \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}

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
                getScheduleFor()
            }
            .padding()
            Button("Показать нитку Иркутск - Москва") {
                getThread()
            }
            .padding()
            Button("Показать ближайший город") {
                getNearestCity()
            }
            .padding()
            Button("Показать информацию о перевозчике") {
                getCarrierInfo()
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
                let routes = try await service.getRoutes(from: Constants.Cities.irktusk, to: Constants.Cities.moscow, limit: 1)
                print(routes)
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
                let schedule = try await service.getScheduleFor(station: Constants.StationCode.airportIrkutsk, limit: 5, date: "2024-03-10")
                print(schedule)
            } catch {
                print("Ошибка  \(error)")
            }
        }
    }
    
    func getThread() {
        let client = Client (
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = ThreadService(client: client, apikey: Constants.apiKey)
        
        Task {
            do {
                let thread = try await service.getThread(threadUID: Constants.threadUID)
                print(thread)
            } catch {
                print("Ошибка  \(error)")
            }
        }
    }
    
    func getNearestCity() {
        let client = Client (
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = NearestCityService(client: client, apikey: Constants.apiKey)
        
        Task {
            do {
                let city = try await service.getNearestCity(lat: 52, lng: 104, distance: 50)
                print(city)
            } catch {
                print("Ошибка  \(error)")
            }
        }
    }
    
    func getCarrierInfo() {
        let client = Client (
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = CarrierInfoService(client: client, apikey: Constants.apiKey)
        
        Task {
            do {
                let carrier = try await service.getCarrier(code: "156")
                print(carrier)
            } catch {
                print("Ошибка  \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}

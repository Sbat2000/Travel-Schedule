//
//  ContentView.swift
//  Travel Schedule
//
//  Created by Aleksandr Garipov on 29.02.2024.
//

import SwiftUI
import OpenAPIURLSession
import OpenAPIRuntime

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
            .padding()
            Button("Показать все станции. ВНИМАНИЕ! Большой объем данных: 40 мб") {
                getAllStations()
            }
        }
        .padding()
    }
    
    //MARK: - Actions
    
    func stations() {
        let client = Client (
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: Constants.apiKey)]
        )
        
        let service = NearestStationsService(client: client)
        
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
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: Constants.apiKey)]
        )
        let service = CopyrightService(client: client)
        
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
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: Constants.apiKey)]
        )
        let service = SearchRouteService(client: client)
        
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
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: Constants.apiKey)]
        )
        let service = StationScheduleService(client: client)
        
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
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: Constants.apiKey)]
        )
        let service = ThreadService(client: client)
        
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
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: Constants.apiKey)]
        )
        let service = NearestCityService(client: client)
        
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
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: Constants.apiKey)]
        )
        let service = CarrierInfoService(client: client)
        
        Task {
            do {
                let carrier = try await service.getCarrier(code: "156")
                print(carrier)
            } catch {
                print("Ошибка  \(error)")
            }
        }
    }
    
    func getAllStations() {
        let client = Client (
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: Constants.apiKey)]
        )
        let service = AllStationsService(client: client)
        
        Task {
            do {
                let dataRaw = try await service.getAllStations()
                let data = try await Data(collecting: dataRaw, upTo: 50*1024*1024)
                let stations = try JSONDecoder().decode(Components.Schemas.AllStations.self, from: data)
                print(stations.countries?.count)
                //Внимание: распечатка всех станций в консоль подвешает xcode на некоторое время
                //print(stations)
            } catch {
                print("Ошибка  \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}

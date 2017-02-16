//
//  ForecastPresenter.swift
//  ABBTestProject
//
//  Created by Artem Abramov on 15/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import Foundation

protocol ForecastView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setForecasts(_ forecasts: [ForecastViewData])
    func showPlaceholder()
}

struct ForecastViewData {
    let city: String
    let temperature: String
    let condition: String
}

class ForecastSerivce {
    func getForecasts(handler: @escaping ([Forecast]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard  let path = Bundle.main.path(forResource: "forecasts", ofType: "plist"), let forecastsRaw = NSArray(contentsOfFile: path) as? [Dictionary<String, String>] else { return }
            print(forecastsRaw)
            let forecasts = forecastsRaw.map({ item -> Forecast in return Forecast(city: item["city"],
                                                                                   temperature: item["temperature"],
                                                                                   condition: item["condition"])})
            sleep(5)
            DispatchQueue.main.async {
                handler(forecasts)
            }
        }
    }
}

class ForecastPresenter {
    private let service: ForecastSerivce
    weak private var forecastView: ForecastView?
    
    init(service: ForecastSerivce) {
        self.service = service
    }
    
    func attachView(_ view: ForecastView) {
        forecastView = view
    }
    
    func detachView() {
        forecastView = nil
    }
    
    func getForecasts() {
        self.forecastView?.startLoading()
        service.getForecasts { forecasts in
            self.forecastView?.finishLoading()
            guard forecasts.count > 0 else {
                self.forecastView?.showPlaceholder()
                return
            }
            
            let forecastViewData = forecasts.map({ (forecast: Forecast) -> ForecastViewData in
                ForecastViewData(city: forecast.city ?? "Unknown city", temperature: forecast.temperature ?? "Unknown temperature", condition: forecast.condition ?? "Unknown condition")
            })
            self.forecastView?.setForecasts(forecastViewData)
        }
    }
}

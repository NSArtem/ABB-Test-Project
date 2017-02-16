//
//  Mock.swift
//  ABBTestProject
//
//  Created by Artem Abramov on 16/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import Foundation

class ForecastsServiceMock: ForecastSerivce {
    private let forecasts: [Forecast]
    init(forecasts: [Forecast]) {
        self.forecasts = forecasts
    }
    override func getForecasts(handler: @escaping ([Forecast]) -> Void) {
        handler(forecasts)
    }
}

class ForecastMock: NSObject, ForecastView {
    var setForecastsCalled = false
    var setPlaceholderCalled = false
    
    func startLoading() {
        
    }
    func finishLoading() {
        
    }
    func setForecasts(_ forecasts: [ForecastViewData]) {
        setForecastsCalled = true

    }
    func showPlaceholder() {
        setPlaceholderCalled = true
    }
}

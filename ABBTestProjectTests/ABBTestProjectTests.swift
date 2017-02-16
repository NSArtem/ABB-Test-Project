//
//  ABBTestProjectTests.swift
//  ABBTestProjectTests
//
//  Created by Artem Abramov on 15/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import XCTest
@testable import ABBTestProject

class ForecastsTests: XCTestCase {
    
    let emptyForecastsMock = ForecastsServiceMock(forecasts: [Forecast]())
    let testForecastsServiceMock = ForecastsServiceMock(forecasts: [Forecast(city: "Test cti", temperature: "1", condition: "Cloudy")])
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPresenter() {
        //given
        let forecastViewMock = ForecastMock()
        let forecastsUnderTest = ForecastPresenter(service: testForecastsServiceMock)
        forecastsUnderTest.attachView(forecastViewMock)
        
        //when
        forecastsUnderTest.getForecasts()
        
        //verify
        XCTAssertTrue(forecastViewMock.setForecastsCalled)
    }
    
    func testEmptyDataSet() {
        //given
        let forecastViewMock = ForecastMock()
        let forecastsUnderTest = ForecastPresenter(service: emptyForecastsMock)
        forecastsUnderTest.attachView(forecastViewMock)
        
        //when
        forecastsUnderTest.getForecasts()
        
        //verify
        XCTAssertTrue(forecastViewMock.setPlaceholderCalled)
    }
    
}

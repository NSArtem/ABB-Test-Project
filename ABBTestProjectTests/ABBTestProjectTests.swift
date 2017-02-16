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
    var testForecastsLargeDataSet: ForecastsServiceMock?
    let largeDataSetCount = 128
    
    override func setUp() {
        super.setUp()
        let forecasts = [Forecast](repeating: Forecast(city: "Test city", temperature: "1", condition: "Rain"), count: largeDataSetCount)
        testForecastsLargeDataSet = ForecastsServiceMock(forecasts: forecasts)
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
    
    func testLargeDataSet() {
        //given
        let forecastViewMock = ForecastMock()
        let forecastsPresenter = ForecastPresenter(service: testForecastsLargeDataSet!)
        forecastsPresenter.attachView(forecastViewMock)
        
        //when
        forecastsPresenter.getForecasts()
        
        //verify
        XCTAssertEqual(forecastViewMock.forecasts?.count, largeDataSetCount)
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
    
    func testLoading() {
        //given
        let forecastService = ForecastSerivce()
        let expectation = self.expectation(description: "loading forecasts")
        
        //when
        forecastService.getForecasts { forecasts in
            expectation.fulfill()
            XCTAssertEqual(forecasts.count, 6)
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }
    
}

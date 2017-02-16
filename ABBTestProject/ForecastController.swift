//
//  ViewController.swift
//  ABBTestProject
//
//  Created by Artem Abramov on 15/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import UIKit

class ForecastController: UIViewController, ForecastView, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyView: UIView!
    
    private let forecastPresenter = ForecastPresenter(service: ForecastSerivce())
    private var forecasts = [ForecastViewData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 64
        forecastPresenter.attachView(self)
        forecastPresenter.getForecasts()
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        forecastPresenter.getForecasts()
    }

    func startLoading() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        tableView.isHidden = true
        emptyView.isHidden = true
    }
    
    func finishLoading() {
        activityIndicator.stopAnimating()
    }
    
    func setForecasts(_ forecasts: [ForecastViewData]) {
        emptyView.isHidden = true
        tableView.isHidden = false
        self.forecasts = forecasts
        tableView.reloadData()
        self.view.layoutSubviews()
    }
    
    func showPlaceholder() {
        self.forecasts.removeAll(keepingCapacity: true)
        tableView.isHidden = true
        activityIndicator.stopAnimating()
        emptyView.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastCell
        let displayData = forecasts[indexPath.row]
        cell.bindForecastView(displayData)
        return cell
    }

}

class ForecastCell: UITableViewCell {
    @IBOutlet weak var citiLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    
    
    func bindForecastView(_ viewData: ForecastViewData) {
        citiLabel.text = viewData.city
        temperatureLabel.text = viewData.temperature
        conditionsLabel.text = viewData.condition
    }
}


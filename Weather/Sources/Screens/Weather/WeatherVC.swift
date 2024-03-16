//
//  WeatherVC.swift
//  Weather
//
//  Created by Дрозд Денис on 25.02.2024.
//

import UIKit
import CoreLocation

// MARK: - Protocol
protocol WeatherViewProtocol: AnyObject {
    func setWeatherDescriptionView(with model: WeatherDescription)
    func reloadCollectionViewData()
    func reloadTableViewData()
    func reloadViewMain(with: UIImage)
    func sentCitys(with: [String])
}

final class WeatherVC: UIViewController {
    
    var arrayCitys = [String]() {
        willSet(newValue) {
            getNewValue(text: newValue)
        }
    }
    var arrayOneCity = [String]()
    var locationManager: CLLocationManager = CLLocationManager()
    var callCounter = 0
    var textForSearchBar = ""
    
    // MARK: - Views
    
    lazy var viewMain: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 40
        return imageView
    }()
    
    private let viewMainShadowTest: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        imageView.clipsToBounds = false
        imageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 30
        imageView.layer.cornerRadius = 40
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 0.3
        return imageView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .default
        searchBar.tintColor = .black
        searchBar.barTintColor = .black
        searchBar.searchTextField.backgroundColor = .systemGray5
        searchBar.isTranslucent = false
        searchBar.showsCancelButton = false
        searchBar.showsSearchResultsButton = false
        return searchBar
    }()
    
    private let weatherDescriptionView = WeatherDescriptionView()
    
    private let labelWeatherDays: UILabel = {
        let label = UILabel()
        label.text = "Прогноз на 7 дней"
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 26)
        return label
    }()
    
    private let labelNight: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Ночь"
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        return label
    }()
    
    private let labelDay: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "День"
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        return label
    }()
    
    private lazy var tableViewDays: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableCell")
        return tableView
    }()
    
    private lazy var tableViewForSearchBar: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray5
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableCell")
        return tableView
    }()

    // MARK: - Properties
    
    private let presenter: WeatherPresentationProtocol
    
    // MARK: - Init
    
    init(presenter: WeatherPresentationProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self

        addSubviews()
        makeConstraints()
        
        let gest = UITapGestureRecognizer(target: self, action: #selector(updateGest))
        weatherDescriptionView.addGestureRecognizer(gest)
        
        navigationItem.titleView = searchBar
        
        weatherDescriptionView.collectionView.dataSource = self
    }
 
}

// MARK: - Location

extension WeatherVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let parameter = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        if callCounter == 0 {
            callCounter += 1
            presenter.getData(parameter: parameter)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}

// MARK: - Action
private extension WeatherVC {
    
    @objc func updateGest() {
        searchBar.resignFirstResponder()
        tableViewForSearchBar.isHidden = true
        searchBar.text = nil
    }
}

// MARK: - Layout

extension WeatherVC {
    
    private func addSubviews() {
        view.backgroundColor = .white
        view.addSubview(viewMainShadowTest)
        view.addSubview(viewMain)
        viewMain.addSubview(weatherDescriptionView)
        
        view.addSubview(labelWeatherDays)
        view.addSubview(labelNight)
        view.addSubview(labelDay)
        view.addSubview(tableViewDays)
        viewMain.addSubview(tableViewForSearchBar)
    }
    
    private func makeConstraints() {
        viewMain.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview() // leading, trailing
            make.height.equalTo(view.frame.height/2 + 70)
        }
        
        viewMainShadowTest.snp.makeConstraints { make in
            make.top.equalTo(viewMain.snp.top)
            make.height.equalTo(viewMain.snp.height)
            make.horizontalEdges.equalToSuperview()
        }
        
        weatherDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }

        labelWeatherDays.snp.makeConstraints { make in
            make.top.equalTo(viewMain.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(15)
        }

        labelNight.snp.makeConstraints { make in
            make.top.equalTo(viewMain.snp.bottom).offset(40)
            make.trailing.equalToSuperview().offset(-20)
        }

        labelDay.snp.makeConstraints { make in
            make.top.equalTo(viewMain.snp.bottom).offset(40)
            make.trailing.equalTo(labelNight.snp.leading).offset(-25)
        }
        
        tableViewDays.snp.makeConstraints { make in
            make.top.equalTo(labelWeatherDays.snp.bottom).offset(5)
            make.bottom.horizontalEdges.equalToSuperview()
        }
        
        tableViewForSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-9)
            make.leading.equalTo(viewMain.snp.leading).offset(22)
            make.trailing.equalTo(viewMain.snp.trailing).offset(-22)
            make.height.equalTo(85)
            
        }
        
    }
}

// MARK: - WeatherViewProtocol

extension WeatherVC: WeatherViewProtocol {
    
    func setWeatherDescriptionView(with model: WeatherDescription) {
        weatherDescriptionView.configure(with: model)
    }
    
    func reloadCollectionViewData() {
        weatherDescriptionView.collectionView.reloadData()
    }
    
    func reloadTableViewData() {
        tableViewDays.reloadData()
    }
    
    func reloadViewMain(with: UIImage) {
        viewMain.image = with
    }
    
    func sentCitys(with: [String]) {
        arrayCitys = with
    }
}

// MARK: - UISearchBarDelegate

extension WeatherVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            presenter.getDataOneCity(with: searchText)
        }
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textForSearchBar = searchText
        presenter.searchCity(with: searchText)
        arrayOneCity.removeAll()
        guard searchText != "" || searchText != " " else {
            print("Search empty")
            return
        }
        
        if searchText.isEmpty {
            tableViewForSearchBar.isHidden = true
        }
        
        if arrayCitys.isEmpty {
            tableViewForSearchBar.isHidden = true
        }
//        print("arrayCityVC \(arrayCitys)")
        tableViewForSearchBar.reloadData()
    }

    func getNewValue(text: [String]) {
        DispatchQueue.main.async {
            for item in self.arrayCitys {
                let text = self.textForSearchBar.lowercased()
                if item.lowercased().contains(text) {
                    self.tableViewForSearchBar.isHidden = false
                    self.arrayOneCity.append(item)
                }
            }
            self.tableViewForSearchBar.reloadData()
        }
    }
}

// MARK: - Collection DataSource

extension WeatherVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.forecastHourly.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        // swiftlint:enable force_cast 
        cell.delegate = self
        cell.configure(with: presenter.forecastHourly[indexPath.item])
        
        return cell
    }
}

// MARK: - Collection Cell Delegate

extension WeatherVC: CollectionViewCellDelegate {
    
}

// MARK: - TableView Delegate & DS

extension WeatherVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewDays {
            return presenter.forecastDaily.count
        } else {
            return arrayOneCity.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewDays {
            let cell = TableViewCell(style: .default, reuseIdentifier: "TableCell")
            cell.configure(with: presenter.forecastDaily[indexPath.row])
            return cell
        } else {
            let cell = SearchTableViewCell(style: .default, reuseIdentifier: "SearchTableCell")
            cell.regionLabel.text = arrayOneCity[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewDays {
            return 55
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewForSearchBar {
            presenter.getDataOneCity(with: arrayOneCity[indexPath.row])
            tableViewForSearchBar.isHidden = true
            searchBar.resignFirstResponder()
            searchBar.text = nil
        }
    }
}

//
//  MainScreenViewContriller.swift
//  Weather
//
//  Created by Дрозд Денис on 25.02.2024.
//

import UIKit
import CoreLocation

// MARK: - Protocol

protocol MainScreenViewProtocol: AnyObject {
    func setWeatherDescriptionView(with model: WeatherDescription)
    func reloadCollectionViewData()
    func reloadTableViewData()
    func reloadViewMain(with: UIImage)
    func sendListOfFoundCities(with: [String])
    func newError(text: String)
}

final class MainScreenViewContriller: UIViewController {
    
    // MARK: - Private properties
    private var arrayOneCity = [String]()
    private var textForSearchBar = ""
    
    private var listOfFoundCities = [String]() {
        willSet(newValue) {
            getNewValue(text: newValue)
        }
    }
    
    // MARK: - Views
    
    private let weatherDescriptionView = WeatherDescriptionView()
    
    lazy var viewMain: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = view.frame.width * 0.1
        return imageView
    }()
    
    private let viewMainShadowTest: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        imageView.clipsToBounds = false
        imageView.layer.shadowOffset = CGSize(width: .zero, height: EnumInt.five)
        imageView.layer.shadowOpacity = Float(EnumInt.one)
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = EnumInt.thirty
        imageView.layer.cornerRadius = EnumInt.fourty
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 0.3
        return imageView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = EnumString.search.rawValue
        searchBar.searchBarStyle = .default
        searchBar.tintColor = .black
        searchBar.barTintColor = .black
        searchBar.searchTextField.backgroundColor = .systemGray5
        searchBar.isTranslucent = false
        searchBar.showsCancelButton = false
        searchBar.showsSearchResultsButton = false
        return searchBar
    }()

    private let labelWeatherDays: UILabel = {
        let label = UILabel()
        label.text = EnumString.forecast7Deys.rawValue
        label.textColor = .black
        label.font = UIFont(name: EnumString.fontOne.rawValue, size: EnumInt.twentySix)
        return label
    }()
    
    private let labelNight: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = EnumString.night.rawValue
        label.font = UIFont(name: EnumString.fontOne.rawValue, size: EnumInt.eighteen)
        return label
    }()
    
    private let labelDay: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = EnumString.day.rawValue
        label.font = UIFont(name: EnumString.fontOne.rawValue, size: EnumInt.eighteen)
        return label
    }()
    
    private lazy var tableViewDays: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()
    
    private lazy var tableViewForSearchBar: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray5
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Internal Properties
    
    let presenter: WeatherPresentationProtocol
    
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
        addSubviews()
        makeConstraints()
        setupActions()
        setupSettings()
        presenter.getLocate()
    }
    
    // MARK: - Setup actions
    
    private func setupActions() {
        let gest = UITapGestureRecognizer(target: self, action: #selector(updateGest))
        weatherDescriptionView.addGestureRecognizer(gest)
    }
    
    // MARK: - Setup settings
    
    private func setupSettings() {
        navigationItem.titleView = searchBar
        weatherDescriptionView.collectionView.dataSource = self
    }
}

// MARK: - Layout

private extension MainScreenViewContriller {
    
     func addSubviews() {
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
    
     func makeConstraints() {
        viewMain.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(view.frame.height * 0.5 + EnumInt.seventy)
        }
        
        viewMainShadowTest.snp.makeConstraints { make in
            make.top.equalTo(viewMain.snp.top)
            make.height.equalTo(viewMain.snp.height).inset(EnumInt.three)
            make.horizontalEdges.equalToSuperview()
        }
        
        weatherDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }

        labelWeatherDays.snp.makeConstraints { make in
            make.top.equalTo(viewMain.snp.bottom).offset(EnumInt.thirty)
            make.leading.equalToSuperview().offset(EnumInt.fifteen)
        }

        labelNight.snp.makeConstraints { make in
            make.top.equalTo(viewMain.snp.bottom).offset(EnumInt.fourty)
            make.trailing.equalToSuperview().inset(view.frame.width * 0.06)
        }

        labelDay.snp.makeConstraints { make in
            make.top.equalTo(viewMain.snp.bottom).offset(EnumInt.fourty)
            make.trailing.equalToSuperview().inset(view.frame.width * 0.2)
        }
        
        tableViewDays.snp.makeConstraints { make in
            make.top.equalTo(labelWeatherDays.snp.bottom).offset(EnumInt.five)
            make.bottom.horizontalEdges.equalToSuperview()
        }
        
        tableViewForSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-EnumInt.nine)
            make.leading.equalToSuperview().inset(view.frame.width * 0.21)
            make.trailing.equalToSuperview().inset(EnumInt.twentyTwo)
            make.height.equalTo(EnumInt.ninety)
            
        }
    }
    
    // MARK: - Actions
    
    @objc func updateGest() {
        searchBar.resignFirstResponder()
        tableViewForSearchBar.isHidden = true
        searchBar.text = nil
    }
    
    // MARK: - Search logic
    
    func getNewValue(text: [String]) {
        DispatchQueue.main.async {
            for item in self.listOfFoundCities {
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

// MARK: - WeatherViewProtocol

extension MainScreenViewContriller: MainScreenViewProtocol {
    
    func newError(text: String) {
        switch text {
        case "404":
            let alert = UIAlertController(title: "Ошибка подключения к серверу!", message: "Попробуйте позже.", preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        case "ErrorDecode":
            let alert = UIAlertController(title: "Ошибка обработки данных!", message: "Попробуйте позже. Если ошибка повторится, обратитесь в поддержку.", preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        default: break
        }
    }
    
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
    
    func sendListOfFoundCities(with: [String]) {
        listOfFoundCities = with
    }
}

// MARK: - UISearchBarDelegate

extension MainScreenViewContriller: UISearchBarDelegate {
    
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
        
        if listOfFoundCities.isEmpty {
            tableViewForSearchBar.isHidden = true
        }
        tableViewForSearchBar.reloadData()
    }
}

// MARK: - CollectionView DataSource

extension MainScreenViewContriller: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.forecastHourly.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        // swiftlint:enable force_cast
        cell.configure(with: presenter.forecastHourly[indexPath.item])
        return cell
    }
}

// MARK: - TableView Delegate & DataSource

extension MainScreenViewContriller: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewDays {
            return presenter.forecastDaily.count
        } else {
            return arrayOneCity.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewDays {
            let cell = TableViewCell(style: .default, reuseIdentifier: TableViewCell.identifier)
            cell.configure(with: presenter.forecastDaily[indexPath.row])
            return cell
        } else {
            let cell = SearchTableViewCell(style: .default, reuseIdentifier: SearchTableViewCell.identifier)
            cell.regionLabel.text = arrayOneCity[indexPath.row]
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewDays {
            return EnumInt.fifty
        } else {
            return tableView.frame.height / EnumInt.four
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

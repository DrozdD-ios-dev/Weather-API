//
//  FirstScreenViewController.swift
//  Weather
//
//  Created by Дрозд Денис on 22.03.2024.
//

import UIKit

// MARK: - Protocol

protocol FirstScreenViewProtocol: AnyObject {
    
}

final class FirstScreenViewController: UIViewController {
    
    // MARK: - Internal Properties
    
    var presenter: FirstScreenPresenterProtocol
    
    // MARK: - Views
    
    private let mainView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "LightRain")
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let mainIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "iconPng")
        return view
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont(name: EnumString.fontTwo.rawValue, size: EnumInt.fourty)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = view.frame.width * 0.07
        button.addTarget(self, action: #selector(nextScreenTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    init(presenter: FirstScreenPresenterProtocol) {
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
        setupAnimations()
    }
}

// MARK: - Layout

private extension FirstScreenViewController {
    
    func addSubviews() {
        view.addSubview(mainView)
        mainView.addSubview(mainIcon)
        mainView.addSubview(startButton)
    }
    
    func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        mainIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(view.frame.width * 0.4)
        }
        
        startButton.snp.makeConstraints { make in
            make.height.equalTo(EnumInt.sixty)
            make.horizontalEdges.equalToSuperview().inset(EnumInt.fourty)
            make.top.equalTo(mainIcon.snp.bottom).offset(EnumInt.fifty)
        }
    }
    
    func setupAnimations() {
        UIView.animate(withDuration: 1.0) {
            self.mainIcon.center = self.view.center
        }
        
    }
    
    @objc func nextScreenTapped() {
        presenter.pushVC()
    }
}

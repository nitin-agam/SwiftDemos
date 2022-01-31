//
//  APIRequestDemoController.swift
//  SwiftDemos
//
//  Created by Nitin A on 03/05/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

class APIRequestDemoController: UIViewController {

    // MARK: - Variables
    lazy var getRequestButton: UIButton = {
        let button = UIButton()
        button.setTitle("GET Request", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(fetchGetRequest), for: .touchUpInside)
        return button
    }()
    
    lazy var postRequestButton: UIButton = {
        let button = UIButton()
        button.setTitle("POST Request", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(fetchPostRequest), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        
        log.other("\(LogManager.stats()) UI setup done !!")/
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(getRequestButton)
        getRequestButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        getRequestButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        getRequestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getRequestButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        
        
        view.addSubview(postRequestButton)
        postRequestButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        postRequestButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        postRequestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        postRequestButton.topAnchor.constraint(equalTo: getRequestButton.bottomAnchor, constant: 50).isActive = true
    }
    
    @objc private func fetchGetRequest() {
        
        log.method("\(LogManager.stats()) Fetching GET request !!")/

        let urlString = "http://api.plos.org/search?q=title:iOS"
        NetworkManager.shared.sendRequest(urlString: urlString,
                                          method: .GET,
                                          parameters: [:],
                                          isLoader: true)
        { (result, error, errorType, status) in
            
            if error != nil {
                self.showAlert(withMessage: error?.localizedDescription ?? "Something went wrong.")
                return
            }
            
            if let _ = result as? [String: Any] {
                self.showAlert(withMessage: "Response fetched !!")
            }
        }
    }
    
    @objc private func fetchPostRequest() {
        
        log.method("\(LogManager.stats()) POST request called!!")/
        
        // #warning Replace here API url.
        let urlString = "....."
        
        // #warning Send parameters according to your API.
        let parameters: [String: Any] = ["EmailId": "test@gmail.com",
                                         "Password": "12345678"]
        
        NetworkManager.shared.sendRequest(urlString: urlString,
                                          method: .POST,
                                          parameters: parameters,
                                          isLoader: true)
        { (result, error, errorType, status) in
            
            if error != nil {
                self.showAlert(withMessage: error?.localizedDescription ?? "Something went wrong.")
                return
            }
            
            if let _ = result as? [String: Any] {
                self.showAlert(withMessage: "Response fetched !!")
            }
        }
    }
    
    private func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

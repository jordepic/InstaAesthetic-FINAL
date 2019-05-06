//
//  ViewController.swift
//  HackChallenge
//
//  Created by Evan Azari on 4/24/19.
//  Copyright © 2019 Evan Azari. All rights reserved.
//

import UIKit

protocol login: class{
    func setTokens(t: loginInfo)
    func register()
    func login()
}

protocol present: class{
    func presentBreakdownViewController(b: Breakdown)
    func pushLoad(name: String)
}

class ViewController: UIViewController {

    var descriptionLabel: UILabel!
    var promptLabel: UILabel!
    var accountTextField: UITextField!
    var enterButton: UIButton!
    var savedButton: UIButton!
    
    let smallText: CGFloat = 20
    let largeText: CGFloat = 30
    
    var tokens = loginInfo(session_token: "", session_expiration: "", update_token: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if tokens.session_token == "" {
            let loginView = LoginViewController()
            loginView.delegate = self
            present(loginView, animated: true, completion: nil)
        }
        
        title = "InstaAesthetic"
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Enter the name of an Instagram Account \nto receive a comprehensive breakdown \nof its aesthetic."
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .darkGray
        descriptionLabel.font = UIFont(name: "PingFangHK-Light", size: smallText - 5 )
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
        
        promptLabel = UILabel()
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        promptLabel.text = "Account Name:"
        promptLabel.font = UIFont(name: "PingFangHK-Light", size: largeText)
        view.addSubview(promptLabel)
        
        accountTextField = UITextField()
        accountTextField.translatesAutoresizingMaskIntoConstraints = false
        accountTextField.backgroundColor = .white
        accountTextField.autocapitalizationType = .none
        accountTextField.borderStyle = .roundedRect
        accountTextField.textAlignment = .center
        accountTextField.font = UIFont(name: "PingFangHK-Light", size: smallText)
        view.addSubview(accountTextField)
        
        enterButton = UIButton()
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.setTitle(" Enter ", for: .normal)
        enterButton.setTitleColor(.blue, for: .normal)
        enterButton.setTitleColor(.cyan, for: .highlighted)
        enterButton.layer.borderColor = UIColor.darkGray.cgColor
        enterButton.layer.borderWidth = 1
        enterButton.layer.cornerRadius = 5
        enterButton.titleLabel?.font = UIFont(name: "PingFangHK-Light", size: smallText)
        enterButton.addTarget(self, action: #selector(presentBreakdown), for: .touchUpInside)
        view.addSubview(enterButton)
        
        savedButton = UIButton()
        savedButton.translatesAutoresizingMaskIntoConstraints = false
        savedButton.setTitle(" Saved Aesthetics ", for: .normal)
        savedButton.setTitleColor(.blue, for: .normal)
        savedButton.setTitleColor(.cyan, for: .highlighted)
        savedButton.layer.borderColor = UIColor.darkGray.cgColor
        savedButton.layer.borderWidth = 1
        savedButton.layer.cornerRadius = 5
        savedButton.titleLabel?.font = UIFont(name: "PingFangHK-Light", size: 13)
        savedButton.addTarget(self, action: #selector(pushSaved), for: .touchUpInside)
        view.addSubview(savedButton)
        
        setUpConstraints()
    }
    
    func setUpConstraints(){
        
        //descriptionLabel
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100)
            ])
        
        //promptLabel
        NSLayoutConstraint.activate([
            promptLabel.bottomAnchor.constraint(equalTo: accountTextField.topAnchor, constant: -15),
            promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        //accountTextField
        NSLayoutConstraint.activate([
            accountTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            accountTextField.heightAnchor.constraint(equalToConstant: smallText + 8),
            accountTextField.widthAnchor.constraint(equalToConstant: 300)
            ])
        
        //enterButton
        NSLayoutConstraint.activate([
            enterButton.topAnchor.constraint(equalTo: accountTextField.bottomAnchor, constant: 15),
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        //savedButton
        NSLayoutConstraint.activate([
            savedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            savedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    @objc func presentBreakdown(){
        pushLoad(name: accountTextField.text ?? "")
    }

    @objc func pushSaved(){
        let savedViewController = SavedViewController(tokens: tokens)
        savedViewController.delegate = self
        navigationController?.pushViewController(savedViewController, animated: true)
    }


}

extension ViewController: login{
    func register() {
        var rView = RegisterViewController()
        rView.delegate = self
        present(rView, animated: true, completion: nil)
    }
    
    func login(){
        var lView = LoginViewController()
        lView.delegate = self
        present(lView, animated: true, completion: nil)
    }
    
    func setTokens(t: loginInfo) {
        tokens = t
    }
}

extension ViewController: present{
    func presentBreakdownViewController(b: Breakdown) {
        var breakdownViewController = BreakdownViewController(breakdown: b, tokens: tokens)
        present(breakdownViewController, animated: true, completion: nil)
    }
    
    func pushLoad(name: String){
        var loading = LoadingViewController(account: name)
        loading.presentBreakdownViewControllerDelegate = self
        present(loading, animated: true, completion: nil)
        loading.networkRequest()
    }
    
}

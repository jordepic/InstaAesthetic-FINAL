//
//  LoginViewController.swift
//  HackChallenge
//
//  Created by Evan Azari on 5/4/19.
//  Copyright © 2019 Evan Azari. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

    var loginLabel: UILabel!
    var toLabel: UILabel!
    var instaLabel: UILabel!
    
    var usernameLabel: UILabel!
    var username: UITextField!
    
    var passwordLabel: UILabel!
    var password: UITextField!
    
    var loginButton: UIButton!
    
    var registerLabel: UILabel!
    var registerButton: UIButton!
    
    var tokens = loginInfo(session_token: "", session_expiration: "", update_token: "")
    
    var delegate: login!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        loginLabel = UILabel()
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = "Log In"
        loginLabel.font = UIFont(name: "PingFangHK-Light", size: 40)
        view.addSubview(loginLabel)
        
        toLabel = UILabel()
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        toLabel.text = "to"
        toLabel.font = UIFont(name: "PingFangHK-Light", size: 20)
        view.addSubview(toLabel)
        
        instaLabel = UILabel()
        instaLabel.translatesAutoresizingMaskIntoConstraints = false
        instaLabel.font = UIFont(name: "Noteworthy-Light", size: 40)
        instaLabel.text = "InstaAesthetic"
        view.addSubview(instaLabel)
        
        usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "Email:"
        usernameLabel.font = UIFont(name: "PingFangHK-Light", size: 15)
        view.addSubview(usernameLabel)
        
        username = UITextField()
        username.translatesAutoresizingMaskIntoConstraints = false
        username.borderStyle = .roundedRect
        username.autocapitalizationType = .none
        username.font = UIFont(name: "PingFangHK-Light", size: UIFont.systemFontSize)
        view.addSubview(username)
        
        passwordLabel = UILabel()
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "Password:"
        passwordLabel.font = UIFont(name: "PingFangHK-Light", size: 15)
        view.addSubview(passwordLabel)
        
        password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.autocapitalizationType = .none
        password.font = UIFont(name: "PingFangHK-Light", size: UIFont.systemFontSize)
        password.isSecureTextEntry = true
        password.borderStyle = .roundedRect
        view.addSubview(password)
        
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle(" Login ", for: .normal)
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.setTitleColor(.cyan, for: .highlighted)
        loginButton.layer.borderColor = UIColor.darkGray.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginButton.titleLabel!.font = UIFont(name: "PingFangHK-Light", size: 20)
        view.addSubview(loginButton)
        
        registerButton = UIButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle(" Register ", for: .normal)
        registerButton.setTitleColor(.blue, for: .normal)
        registerButton.setTitleColor(.cyan, for: .highlighted)
        registerButton.layer.borderColor = UIColor.darkGray.cgColor
        registerButton.layer.borderWidth = 1
        registerButton.layer.cornerRadius = 5
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        registerButton.titleLabel!.font = UIFont(name: "PingFangHK-Light", size: 20)
        view.addSubview(registerButton)
        
        registerLabel = UILabel()
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        registerLabel.text = "Don't have an account?"
        registerLabel.font = UIFont(name: "PingFangHK-Light", size: 15)
        registerLabel.textColor = .darkGray
        view.addSubview(registerLabel)
        
        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120)
            ])
        
        NSLayoutConstraint.activate([
            toLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 0)
            ])
        
        NSLayoutConstraint.activate([
            instaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instaLabel.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 0)
            ])
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: instaLabel.bottomAnchor, constant: 100),
            usernameLabel.trailingAnchor.constraint(equalTo: username.leadingAnchor, constant: -20)
            ])
        
        NSLayoutConstraint.activate([
            username.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor),
            username.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            username.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 30),
            passwordLabel.trailingAnchor.constraint(equalTo: password.leadingAnchor, constant: -20)
            ])
        
        NSLayoutConstraint.activate([
            password.centerYAnchor.constraint(equalTo: passwordLabel.centerYAnchor),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            password.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 70)
            ])
        
        NSLayoutConstraint.activate([
            registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 100)
            ])
        
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 10)
            ])
    }

    @objc func login(){
        if let email = username.text?.lowercased() {
            if let pass = password.text {
                
                if email == "" || pass == "" {
                    var a = UIAlertController(title: "Invalid Entry Data", message: "Please make sure your email and password are correct", preferredStyle: .alert)
                    a.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(a, animated: true)
                    return
                }
                
                NetworkManager.login(email: email, password: pass, completion: {(login) in
                    
                    if(login.session_token == "invalid"){
                        var a = UIAlertController(title: "Invalid Entry Data", message: "Please make sure your email and password are correct", preferredStyle: .alert)
                        a.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        self.present(a, animated: true)
                    }
                    if(login.session_token == "failure"){
                        var a = UIAlertController(title: "Failure", message: "We could not log you in at this time.", preferredStyle: .alert)
                        a.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        self.present(a, animated: true)
                    }
                    else{
                        self.delegate.setTokens(t: login)
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    @objc func register(){
        dismiss(animated: true, completion: nil)
        delegate.register()
    }
}

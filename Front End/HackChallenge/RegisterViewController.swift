//
//  RegisterViewController.swift
//  HackChallenge
//
//  Created by Evan Azari on 5/4/19.
//  Copyright © 2019 Evan Azari. All rights reserved.
//


import UIKit

class RegisterViewController: UIViewController {
    
    var registerLabel: UILabel!
    var toLabel: UILabel!
    var instaLabel: UILabel!
    
    var usernameLabel: UILabel!
    var username: UITextField!
    
    var passwordLabel: UILabel!
    var password: UITextField!
    
    var retypeLabel: UILabel!
    var retype: UITextField!
    
    var registerButton: UIButton!
    
    var loginLabel: UILabel!
    var loginButton: UIButton!
    
    var tokens = loginInfo(session_token: "", session_expiration: "", update_token: "")
    
    var delegate: login!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        registerLabel = UILabel()
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        registerLabel.text = "Register"
        registerLabel.font = UIFont(name: "PingFangHK-Light", size: 40)
        view.addSubview(registerLabel)
        
        toLabel = UILabel()
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        toLabel.text = "an account with"
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

        retypeLabel = UILabel()
        retypeLabel.translatesAutoresizingMaskIntoConstraints = false
        retypeLabel.text = "Retype Password:"
        retypeLabel.font = UIFont(name: "PingFangHK-Light", size: 15)
        view.addSubview(retypeLabel)
        
        retype = UITextField()
        retype.translatesAutoresizingMaskIntoConstraints = false
        retype.autocapitalizationType = .none
        retype.font = UIFont(name: "PingFangHK-Light", size: UIFont.systemFontSize)
        retype.isSecureTextEntry = true
        retype.borderStyle = .roundedRect
        view.addSubview(retype)
        
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
        
        loginLabel = UILabel()
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = "Already have an account?"
        loginLabel.font = UIFont(name: "PingFangHK-Light", size: 15)
        loginLabel.textColor = .darkGray
        view.addSubview(loginLabel)
        
        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120)
            ])
        
        NSLayoutConstraint.activate([
            toLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toLabel.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: -5)
            ])
        
        NSLayoutConstraint.activate([
            instaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instaLabel.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 0)
            ])
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: instaLabel.bottomAnchor, constant: 100),
            usernameLabel.trailingAnchor.constraint(equalTo: username.leadingAnchor, constant: -15)
            ])
        
        NSLayoutConstraint.activate([
            username.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor),
            username.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            username.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 30),
            passwordLabel.trailingAnchor.constraint(equalTo: password.leadingAnchor, constant: -15)
            ])
        
        NSLayoutConstraint.activate([
            password.centerYAnchor.constraint(equalTo: passwordLabel.centerYAnchor),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            password.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            retypeLabel.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 30),
            retypeLabel.trailingAnchor.constraint(equalTo: retype.leadingAnchor, constant: -15)
            ])
        
        NSLayoutConstraint.activate([
            retype.centerYAnchor.constraint(equalTo: retypeLabel.centerYAnchor),
            retype.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            retype.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: retype.bottomAnchor, constant: 50)
            ])
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 50)
            ])
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 10)
            ])
    }
    
    @objc func login(){
        dismiss(animated: true, completion: nil)
        delegate.login()
    }
    
    @objc func register(){
        if password.text ?? "" != retype.text ?? " " {
            var a = UIAlertController(title: "Invalid Password Combination", message: "Please make sure your passwords are the same", preferredStyle: .alert)
            a.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(a, animated: true)
            password.text = ""
            retype.text = ""
        }
        
        if let email = username.text?.lowercased() {
            if let pass = password.text {
                
                if email == "" || pass == "" {
                    var a = UIAlertController(title: "Invalid Entry Data", message: "Please make sure your email and password are correct", preferredStyle: .alert)
                    a.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(a, animated: true)
                    return
                }
                
                NetworkManager.register(email: email, password: pass, completion: {(login) in
                    
                    if(login.session_token == "failure"){
                        var a = UIAlertController(title: "Failure", message: "Please make sure your email and password are correct", preferredStyle: .alert)
                        a.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        self.present(a, animated: true)
                    }
                    else if (login.session_token == "exists"){
                        var a = UIAlertController(title: "Error", message: "Account already registered.", preferredStyle: .alert)
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
    
}


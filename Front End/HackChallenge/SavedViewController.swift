//
//  SavedViewController.swift
//  HackChallenge
//
//  Created by Evan Azari on 4/24/19.
//  Copyright © 2019 Evan Azari. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController {

    var table: UITableView!
    var reuse: String = "whaaaa"
    var user: User
    var tokens: loginInfo
    var delegate: present!
    
    init(tokens: loginInfo){
        table = UITableView()
        user = User(success: false, data: UserData(id: 0, email: "", accounts: []))
        self.tokens = tokens
        
        super.init(nibName: nil, bundle: nil)
        
        getInfo()
    }
    
    func getInfo(){
        NetworkManager.getUser(user: tokens, completion: {(u) in
            self.user = u
            self.table.reloadData()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Saved Aesthetics"
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SavedTableViewCell.self, forCellReuseIdentifier: reuse)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.addSubview(table)
        
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
}

extension SavedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of accounts: \(user.data.accounts.count)")
        return user.data.accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuse, for: indexPath) as! SavedTableViewCell
        print(user.data.accounts[indexPath.row].name)
        cell.configure(account: user.data.accounts[indexPath.row].name)
        return cell
    }
}

extension SavedViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.pushLoad(name: user.data.accounts[indexPath.row].name)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            NetworkManager.deleteAccount(account: user.data.accounts[indexPath.row].name, user: tokens, completion: {() in
                self.getInfo()
            })
        }
    }
}

//
//  LoadingViewController.swift
//  HackChallenge
//
//  Created by Evan Azari on 5/5/19.
//  Copyright © 2019 Evan Azari. All rights reserved.
//

import UIKit

protocol failedLoad: class{
    func fail()
}

class LoadingViewController: UIViewController {

    var loadingLabel: UILabel!
    var account: String
    
    var presentBreakdownViewControllerDelegate: present!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        loadingLabel = UILabel()
        loadingLabel.text = "Loading"
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingLabel)
        
        NSLayoutConstraint.activate([
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    init(account: String){
        self.account = account
        
        super.init(nibName: nil, bundle: nil)
    }
    
    func networkRequest(){
        var network = NetworkManager()
        network.loadingDelegate = self
        network.getColors(account: account, completion: { [weak self](b) in
            self!.dismiss(animated: false, completion: nil)
            self!.presentBreakdownViewControllerDelegate.presentBreakdownViewController(b: b)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoadingViewController: failedLoad{
    func fail(){
        var a = UIAlertController(title: "Could not retrieve account", message: "Please make sure the account name is correct", preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (blah) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(a, animated: true)
    }
}

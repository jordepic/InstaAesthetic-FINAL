//
//  BreakdownViewController.swift
//  HackChallenge
//
//  Created by Evan Azari on 4/24/19.
//  Copyright © 2019 Evan Azari. All rights reserved.
//

import UIKit

class BreakdownViewController: UIViewController {

    let account: String
    let smallText: CGFloat = 18
    let largeText: CGFloat = 25
    let padding: CGFloat = 12
    
    let collectionBackground: CGFloat = 0.9

    let primaryReuse = "primary"
    let secondaryReuse = "secondary"

    var accountLabel: UILabel!
    
    var primaryLabel: UILabel!
    var primaryCollection: UICollectionView!
    
    var secondaryLabel: UILabel!
    var secondaryCollection: UICollectionView!

    var exitButton: UIButton!
    var saveButton: UIButton!
    
    var titleLabel: UILabel!

    var primaryColors: [color?]
    var secondaryColors: [color?]

    //let rating: Int

    var breakdown: Breakdown
    var tokens: loginInfo
   // var delegate

    init(breakdown: Breakdown, tokens: loginInfo){
        self.breakdown = breakdown
        self.account = breakdown.account
        self.tokens = tokens

        //rating = breakdown.rating
        primaryColors = breakdown.primaryColors
        secondaryColors = breakdown.secondaryColors
        
        print(primaryColors.count)
        print(secondaryColors.count)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)

        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Aesthetic Breakdown"
        titleLabel.font = UIFont(name: "PingFangHK-Light", size: 35)
        view.addSubview(titleLabel)
        
        accountLabel = UILabel()
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        accountLabel.text = "@\(account.lowercased())"
        accountLabel.font = UIFont(name: "PingFangHK-Ultralight", size: largeText)
        view.addSubview(accountLabel)

        primaryLabel = UILabel()
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        primaryLabel.text = "Primary Colors:"
        primaryLabel.font = UIFont(name: "PingFangHK-Light", size: smallText)
        view.addSubview(primaryLabel)

        let playout = UICollectionViewFlowLayout()
        playout.scrollDirection = .horizontal
        playout.minimumLineSpacing = padding
        playout.minimumInteritemSpacing = padding

        primaryCollection = UICollectionView(frame: .zero, collectionViewLayout: playout)
        primaryCollection.translatesAutoresizingMaskIntoConstraints = false
        primaryCollection.backgroundColor = UIColor(white: collectionBackground, alpha: 1)
        primaryCollection.layer.borderWidth = 1
        primaryCollection.layer.borderColor = UIColor.black.cgColor
        primaryCollection.dataSource = self
        primaryCollection.delegate = self
        primaryCollection.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: primaryReuse)
        view.addSubview(primaryCollection)

        secondaryLabel = UILabel()
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.text = "Secondary Colors:"
        secondaryLabel.font = UIFont(name: "PingFangHK-Light", size: smallText)
        view.addSubview(secondaryLabel)

        let slayout = UICollectionViewFlowLayout()
        slayout.scrollDirection = .horizontal
        slayout.minimumLineSpacing = padding
        slayout.minimumInteritemSpacing = padding
        
        secondaryCollection = UICollectionView(frame: .zero, collectionViewLayout: slayout)
        secondaryCollection.translatesAutoresizingMaskIntoConstraints = false
        secondaryCollection.backgroundColor = UIColor(white: collectionBackground, alpha: 1)
        secondaryCollection.layer.borderColor = UIColor.black.cgColor
        secondaryCollection.layer.borderWidth = 1
        secondaryCollection.dataSource = self
        secondaryCollection.delegate = self
        secondaryCollection.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: secondaryReuse)
        view.addSubview(secondaryCollection)

        exitButton = UIButton()
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.setTitle(" Exit ", for: .normal)
        exitButton.setTitleColor(.blue, for: .normal)
        exitButton.setTitleColor(.cyan, for: .highlighted)
        exitButton.layer.borderColor = UIColor.black.cgColor
        exitButton.layer.borderWidth = 1
        exitButton.layer.cornerRadius = 5
        exitButton.titleLabel?.font = UIFont(name: "PingFangHK-Light", size: 20)
        exitButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
        view.addSubview(exitButton)

        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle(" Save & Exit ", for: .normal)
        saveButton.setTitleColor(.blue, for: .normal)
        saveButton.setTitleColor(.cyan, for: .highlighted)
        saveButton.layer.borderColor = UIColor.black.cgColor
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 5
        saveButton.titleLabel?.font = UIFont(name: "PingFangHK-Light", size: 20)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        view.addSubview(saveButton)

        setUpConstraints()
    }

    func setUpConstraints(){
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        //accountLabel
        NSLayoutConstraint.activate([
            accountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            accountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
            ])

        //primaryLabel
        NSLayoutConstraint.activate([
            primaryLabel.topAnchor.constraint(equalTo: accountLabel.bottomAnchor, constant: 40),
            primaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
            ])

        //primaryCollection
        NSLayoutConstraint.activate([
            primaryCollection.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: 5),
            primaryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            primaryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            primaryCollection.heightAnchor.constraint(equalToConstant: 100)
            ])

        //secondaryLabel
        NSLayoutConstraint.activate([
            secondaryLabel.topAnchor.constraint(equalTo: primaryCollection.bottomAnchor, constant: 45),
            secondaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
            ])

        //secondaryCollection
        NSLayoutConstraint.activate([
            secondaryCollection.topAnchor.constraint(equalTo: secondaryLabel.bottomAnchor, constant: 5),
            secondaryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondaryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondaryCollection.heightAnchor.constraint(equalToConstant: 100)
            ])


        //exitButton
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
            ])

        //saveButton
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: exitButton.topAnchor),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
            ])
    }

    @objc func save(){
        NetworkManager.addAccount(account: account, user: tokens)
        exit()
    }

    @objc func exit(){
        dismiss(animated: true, completion: nil)
    }

}

extension BreakdownViewController: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.primaryCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: primaryReuse, for: indexPath) as! ColorCollectionViewCell
            if let RBG = primaryColors[indexPath.item]?.rgb {
                cell.configure(for: RBG, isNil: false)
            }
            else{
                cell.configure(for: [collectionBackground, collectionBackground, collectionBackground], isNil: true)
            }
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondaryReuse, for: indexPath) as! ColorCollectionViewCell
            if let RBG = secondaryColors[indexPath.item]?.rgb {
                cell.configure(for: RBG, isNil: false)
            }
            else{
                cell.configure(for: [collectionBackground*255, collectionBackground*255, collectionBackground*255], isNil: true)
            }
            return cell
        }
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.primaryCollection {
            return primaryColors.count
        }
        else{
            return secondaryColors.count
        }
    }
}

extension BreakdownViewController: UICollectionViewDelegate {

}

extension BreakdownViewController: UICollectionViewDelegateFlowLayout{

    //sets size of item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let length = (primaryCollection.frame.height - 2*padding)
        return CGSize(width: length, height: length)
    }
}

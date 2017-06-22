//
//  FirstViewController.swift
//  Domino Tracker
//
//  Created by Andres Prato on 5/10/17.
//  Copyright © 2017 Andres Prato. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var window: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var addRoundButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var rounds = [(String,Int)]()
    var count = 0
    var sumUs = 0
    var sumThem = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpWindow()
        
        let openCVWrapper = OpenCVWrapper()
        openCVWrapper.isThisWorking()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This function sets up de window programmatically
    func setUpWindow() {
        
        addRoundButton.setTitle("Add Round", for: .normal)
        addRoundButton.addTarget(self, action: #selector(FirstViewController.showTeamSelectionPopUp), for: .touchUpInside)
        
        clearButton.addTarget(self, action: #selector(FirstViewController.clear), for: .touchUpInside)
        
        cameraButton.widthAnchor.constraint(equalTo: window.widthAnchor, multiplier: 1/2).isActive = true
        addRoundButton.widthAnchor.constraint(equalTo: window.widthAnchor, multiplier: 1/2).isActive = true
        cameraButton.addTarget(self, action: #selector(FirstViewController.accessCamera), for: .touchUpInside)
        
        window.addSubview(us)
        us.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 15).isActive = true
        us.centerXAnchor.constraint(equalTo: window.leftAnchor, constant: (window.frame.width * 1/4)).isActive = true
        
        window.addSubview(them)
        them.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 15).isActive = true
        them.centerXAnchor.constraint(equalTo: window.leftAnchor, constant: (window.frame.width * 3/4)).isActive = true
        
        window.addSubview(scoreus)
        scoreus.bottomAnchor.constraint(equalTo: addRoundButton.topAnchor, constant: -10).isActive = true
        scoreus.centerXAnchor.constraint(equalTo: window.leftAnchor, constant: (window.frame.width * 1/4)).isActive = true
        
        window.addSubview(scorethem)
        scorethem.bottomAnchor.constraint(equalTo: cameraButton.topAnchor, constant: -10).isActive = true
        scorethem.centerXAnchor.constraint(equalTo: window.leftAnchor, constant: (window.frame.width * 3/4)).isActive = true
        
        window.addSubview(line1)
        line1.bottomAnchor.constraint(equalTo: scoreus.topAnchor, constant: -5).isActive = true
        line1.centerXAnchor.constraint(equalTo: window.leftAnchor, constant: (window.frame.width * 1/4)).isActive = true
        
        window.addSubview(line2)
        line2.bottomAnchor.constraint(equalTo: scoreus.topAnchor, constant: -5).isActive = true
        line2.centerXAnchor.constraint(equalTo: window.leftAnchor, constant: (window.frame.width * 3/4)).isActive = true
        
        scoreBoard.delegate = self
        scoreBoard.dataSource = self
        
        window.addSubview(scoreBoard)
        scoreBoard.topAnchor.constraint(equalTo: us.bottomAnchor, constant: 10).isActive = true
        scoreBoard.widthAnchor.constraint(equalTo: window.widthAnchor, multiplier: 1).isActive = true
        scoreBoard.bottomAnchor.constraint(equalTo: line1.topAnchor, constant: -10).isActive = true

    }
    
    func showTeamSelectionPopUp(){
        // create the alert
        let alert = UIAlertController(title: "Add Round", message: "Select a team to add the point", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: us.text, style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in self.showAddValueOfRound(team: "US")}))
        alert.addAction(UIAlertAction(title: them.text, style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in self.showAddValueOfRound(team: "THEM")}))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAddValueOfRound(team: String){
        let alert = UIAlertController(title: "Put the number of points to add", message: "Adding to \(team)", preferredStyle: UIAlertControllerStyle.alert)
        
        let addValueAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if (alert.textFields?[0]) != nil {
                // store your data
                let textField = alert.textFields!.first
                self.rounds.append((team, Int((textField?.text)!)!))
                if (team == "US"){
                    self.sumUs += Int((textField?.text)!)!
                } else {
                    self.sumThem += Int((textField?.text)!)!
                }
                self.scoreBoard.reloadData()
            } else {
                let newAlert = UIAlertController(title: "Error!", message: "Put a score to add", preferredStyle: UIAlertControllerStyle.alert)
                newAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.showAddValueOfRound(team: team)
                // user did not fill field
            }
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Value"
            textField.keyboardType = .decimalPad
        }
        alert.addAction(addValueAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    let us: UILabel = {
        let lb = UILabel()
        lb.text = "US"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let them: UILabel = {
        let lb = UILabel()
        lb.text = "THEM"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let scoreus: UILabel = {
        let lb = UILabel()
        lb.text = "0"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let scorethem: UILabel = {
        let lb = UILabel()
        lb.text = "0"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let line1: UILabel = {
        let lb = UILabel()
        lb.backgroundColor = UIColor.black
        lb.addConstraint(NSLayoutConstraint(item: lb, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 2))
        lb.addConstraint(NSLayoutConstraint(item: lb, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45))
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let line2: UILabel = {
        let lb = UILabel()
        lb.backgroundColor = UIColor.black
        lb.addConstraint(NSLayoutConstraint(item: lb, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 2))
        lb.addConstraint(NSLayoutConstraint(item: lb, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45))
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let scoreBoard: UITableView = {
        let tb = UITableView()
        tb.register(ScoreCell.self, forCellReuseIdentifier: "cell")
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()

    let valueTextField: UITextField = {
        let lb = UITextField()
        lb.placeholder = "Valor"
        lb.keyboardType = .decimalPad
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.rounds.count < 10) {
            return 10
        } else {
            return self.rounds.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ScoreCell
        cell.setUpCell()
        cell.selectionStyle = .none
        if (self.rounds.count > 0 && self.rounds.count > indexPath.row){
            if (self.rounds[indexPath.row].0 == "us"){
                cell.score1.text = String(self.rounds[indexPath.row].1)
                cell.score2.text = "0"
                scoreus.text = String(self.sumUs)
            } else if (self.rounds[indexPath.row].0 == "them"){
                cell.score2.text = String(self.rounds[indexPath.row].1)
                cell.score1.text = "0"
                scorethem.text = String(self.sumThem)
            }
        }
        
        if (indexPath.row % 2 == 0){
            cell.backgroundColor = #colorLiteral(red: 0.03790412098, green: 0.4371998906, blue: 0.9773460031, alpha: 1)
        } else{
            cell.backgroundColor = #colorLiteral(red: 0.09078612179, green: 0.581982553, blue: 0.967805922, alpha: 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return scoreBoard.frame.height/10
    }
    
    func accessCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func clear(){
//        self.sumThem = 0
//        self.sumUs = 0
//        self.rounds.removeAll()
//        self.scoreBoard.reloadData()
        
        print("TEST")
    }
}





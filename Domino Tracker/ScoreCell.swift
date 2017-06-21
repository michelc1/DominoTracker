//
//  ScoreCell.swift
//  Domino Tracker
//
//  Created by Andres Prato on 5/14/17.
//  Copyright © 2017 Andres Prato. All rights reserved.
//

import UIKit

class ScoreCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setUpCell(){
            
        addSubview(score1)
        score1.centerXAnchor.constraint(equalTo: self.leftAnchor, constant: (self.frame.width * 1/4)).isActive = true
        score1.centerYAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 1/2).isActive = true
            
        addSubview(score2)
        score2.centerXAnchor.constraint(equalTo: self.leftAnchor, constant: (self.frame.width * 3/4)).isActive = true
        score2.centerYAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 1/2).isActive = true
            
        addSubview(erase)
        erase.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        erase.centerYAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 1/2).isActive = true
        
        erase.addTarget(self, action: #selector(ScoreCell.handleErase), for: .touchUpInside)
    }
    
    func handleErase(){
        print("ERASE")
    }
    
    
    let score1: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let score2: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let erase: UIButton = {
        let lb = UIButton(type: UIButtonType.system)
        //lb.setTitle("Erase", for: .normal)
        //lb.setTitleColor(.black, for: .normal)
        lb.tintColor = UIColor.white
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
}

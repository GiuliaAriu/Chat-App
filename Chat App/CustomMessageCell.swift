//
//  CustomMessageCell.swift
//  Chat App
//
//  Created by Giulia Ariu on 02/01/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {
    
    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code goes here
    }
    
}

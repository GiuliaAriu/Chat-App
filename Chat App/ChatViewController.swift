//
//  ChatViewController.swift
//  Chat App
//
//  Created by Giulia Ariu on 02/01/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    //Empty message array
    var messageArray : [Message] = [Message]()
    
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTextfield.delegate = self
        
        messageTableView.separatorStyle = .none
        
        messageTableView.allowsSelection = false
        
        let tableViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        
        messageTableView.addGestureRecognizer(tableViewTapGesture)
        
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        configureTableView()
        
        retrieveMessages()
        
        scrollToBottom()
    }
    
    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    //This method gets triggered when the tableview looks to find something to display in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named: "egg")
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email //as String!
        {
            cell.avatarImageView.backgroundColor = UIColor.flatLime()
            cell.messageBackground.backgroundColor = UIColor.flatMint()
            cell.messageBody.textColor = .black
        }
        else
        {
            cell.avatarImageView.backgroundColor = UIColor.flatRed()
            cell.messageBackground.backgroundColor = UIColor.flatMagentaColorDark()
            cell.messageBody.textColor = .white
        }
        
        return cell
    }
    
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    
    
    
    func configureTableView() {
        messageTableView.rowHeight = UITableView.automaticDimension
        
        messageTableView.estimatedRowHeight = 120.0
    }
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.2){
            self.heightConstraint.constant = 358
            
            //If a constraint has changed, redraw
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.2){
            self.heightConstraint.constant = 50
            
            self.view.layoutIfNeeded()
        }
    }
    
    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Receive from Firebase
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = Database.database().reference().child("Messages")
        
        let messagesDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": messageTextfield.text]
        
        //Creates custom random key for the messages
        messagesDB.childByAutoId().setValue(messagesDictionary) {
            (error, reference) in
            
            if error != nil
            {
                print(error!)
            } else
            {
                print("Message saved")
                
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
                
                self.scrollToBottom()
                
            }
        }
        
        
    }
    
    
    func retrieveMessages() {
        
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded, with: { ( snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary <String, String>
            
            let text = snapshotValue["MessageBody"]!
            
            let sender = snapshotValue["Sender"]!
            
            let message = Message()
            
            message.messageBody = text
            message.sender = sender
            
            self.messageArray.append(message)
            
            self.configureTableView()
            self.messageTableView.reloadData()
            
        })
    
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messageArray.count - 1, section: 0)
            self.messageTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //signOut requires to be handled with a try and do catch
        do
        {
            try Auth.auth().signOut()
            
            //This method pop the current View Controller to show the last one on the stack
            navigationController?.popViewController(animated: true)
        }
        catch
        {
            print("There was a problem while logging out.")
        }
        
    }
    


}


//
//  ViewController.swift
//  MultipeerConnectivityExample
//
//  Created by Vinit Ingale on 06/07/18.
//  Copyright © 2018 Vinit Ingale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var connectionsLabel: UILabel!
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var dataDisplayLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    
    let communicationService = CommunicationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        communicationService.delegate = self
        setUpInitialData()
    }
    
    private func setUpInitialData() {
        connectionsLabel.text = "Connected devices:"
        dataDisplayLabel.text = ""
    }

    @IBAction func sendButtonClicked(_ sender: UIButton) {
        if let text = dataTextField.text, text.count > 0 {
            communicationService.send(message: text)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dataTextField.resignFirstResponder()
    }
}

extension ViewController : CommunicationManagerDelegate {
    
    func connectedDevicesChanged(connectedDevices: [String]) {
        DispatchQueue.main.async {
            self.connectionsLabel.text = "Connected devices: \(connectedDevices)"
        }
    }
    
    func receivedTextData(message: String) {
        DispatchQueue.main.async {
            self.dataDisplayLabel.text = message
        }
    }
    
}

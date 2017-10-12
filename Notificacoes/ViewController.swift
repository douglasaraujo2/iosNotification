//
//  ViewController.swift
//  Notificacoes
//
//  Created by Usuário Convidado on 11/10/17.
//  Copyright © 2017 Douglas Araujo. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    //MARK: - IBOutlets -
    @IBOutlet weak var tfMessage: UITextField!
    @IBOutlet weak var dpFireDate: UIDatePicker!
    @IBOutlet weak var lbMessage: UILabel!
    
    //MARK: - Super Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onReceive(notification:)), name: NSNotification.Name(rawValue:"Received"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dpFireDate.minimumDate = Date()
        
    }
    //MARK: - IBActions -
    @IBAction func fireNotification(_ sender: UIButton) {
        
        let content = UNMutableNotificationContent()
        
            content.title = "Lembrete"
            content.subtitle = "Vim lembrar-lhe de:"
            content.body = tfMessage.text!
            //content.sound = UNNotificationSound(named: "arquivo-de-sim.caf")
            content.categoryIdentifier = "Lembrete"
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dpFireDate.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "Lembrete", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
    }
    func onReceive(notification: Notification){
        if let message = notification.object as? String {
            lbMessage.text = message
        }
    }


}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

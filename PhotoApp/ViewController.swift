//
//  ViewController.swift
//  PhotoApp
//
//  Created by 小室　亮太 on 2022/10/29.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        Auth.auth().signInAnonymously{(authResult,error) in
            let user = authResult?.user
            print(user)
            let inputVC = self.storyboard?.instantiateViewController(identifier: "inputViewController") as! InputViewController
            self.navigationController?.pushViewController(inputVC, animated: true)
        }
    }
    
}


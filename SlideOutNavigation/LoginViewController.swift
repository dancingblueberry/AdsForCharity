//
//  LoginViewController.swift
//  AdsForCharity
//


import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logIn(sender: AnyObject) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        let ref = Firebase(url: FIRE_BASE_URL)
        ref.authUser(username, password: password,
            withCompletionBlock: { error, authData in
                if error != nil {
                    // There was an error logging in to this account
                    println("Couldn't log in")
                } else {
                    // We are now logged in
                    println("Successfully logged in with uid: \(authData.uid)")
                }
        })
        println("Uid: " + ref.authData.uid)
    }
    
    @IBAction func signUp(sender: AnyObject) {
        let username = usernameTextField.text
        let password = passwordTextField.text

        let ref = Firebase(url: FIRE_BASE_URL + "/users")
        ref.createUser(username, password: password,
            withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the account
                    println("Couldn't create account")
                } else {
                    let uid = result["uid"] as? String
                    
                    let initUser = [
                        "funds": 0,
                        "views": 0
                    ]
                    ref.childByAppendingPath(String(uid!)).setValue(initUser)
                    println("Successfully created user account with uid: \(uid)")
                }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

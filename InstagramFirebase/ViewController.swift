//
//  ViewController.swift
//  InstagramFirebase
//
//  Created by HaroldDavidson on 2/1/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//








// ****** STOPPED ON VIDEO 4 AT 2:03















import UIKit
import Firebase

class ViewController: UIViewController {

    // profile image button at top
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    // four elements in StackView
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03) // white: 0 means totally black. the 0.03 is the percentage of black.
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        // this is a listener that checks each time the text field changes. This one is used for form validation to set the sign up button color
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03) // white: 0 means totally black. the 0.03 is the percentage of black.
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        // this is a listener that checks each time the text field changes. This one is used for form validation to set the sign up button color
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03) // white: 0 means totally black. the 0.03 is the percentage of black.
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        // this is a listener that checks each time the text field changes. This one is used for form validation to set the sign up button color
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        
        // commenting out because using more sophisticated method for setting background color
        // button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244, alpha: 1)
        
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleSignUp() {
        
        guard let email = emailTextField.text, email.count > 0 else { return }
        guard let username = usernameTextField.text, username.count > 0 else { return }
        guard let password = passwordTextField.text, password.count > 0 else { return }
        
//        Auth.auth().createUser(withEmail: email, password: password, completion: {authResult, error in
//            if let err = error {
//                print("failed to create user. Error: \(err)")
//                return
//            }
//
//            print(authResult)
//
////            guard let uid = user?.uid else { return }
////            let values = [user?.uid: 1]
////            Database.database().reference().child("users").setValue(value: Any?, withCompletionBlock: ())
//        })
        
        Auth.auth().createUser(withEmail: email, password: password) { (user: Firebase.User?, error: Error?) in
            if let err = error {
                print("failed to create user. Error: \(err)")
                    return
            }
            print(user ?? "")
        }
    }
    
    // this is for setting the background color of the button if all of the text fields are filled out.
    @objc func handleTextInputChange() {
        let isFormValid = emailTextField.text?.count ?? 0 > 0 && usernameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237, alpha: 1)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add profile pic button
        view.addSubview(plusPhotoButton)
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        // adding StackView
        setupInputFields()
    }
    
    // creating StackView
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
        
        // more manual way of adding constraints - leaving here for reference
//        NSLayoutConstraint.activate([
//                    stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20),
//                    stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
//                    stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
//                    stackView.heightAnchor.constraint(equalToConstant: 200)
//                ])
    }
}

// extension for simplifying the adding of constraints
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

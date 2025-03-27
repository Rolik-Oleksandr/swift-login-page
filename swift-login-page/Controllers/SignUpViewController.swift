import UIKit

class SignUpViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    private let registerLabel: UILabel = {
        let registerLabel = UILabel()
        registerLabel.text = "Registration"
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        return registerLabel
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.placeholder = "First Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let firstNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required Field"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Second Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let secondNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required Field"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneNumberTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Phone Number"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let phoneNumberValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required Field"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required Field"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required Field"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.setTitle("Back", for: .normal)
        button.isEnabled = true
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func signUpButtonTapped() {
        let albumsViewController = AlbumsViewController()
        albumsViewController.loadViewIfNeeded()
        albumsViewController.modalPresentationStyle = .fullScreen
        present(albumsViewController, animated: true)
    }
    
    @objc private func backButtonTapped() {
        let authViewController = AuthViewController()
        authViewController.loadViewIfNeeded()
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated: true)
    }
    
    private var elementsStackView = UIStackView()
    private var buttonsStackView = UIStackView()
    private let datePicker = UIDatePicker()
    
    let nameValidType: String.ValidTypes = .name
    let phoneNumberValidType: String.ValidTypes = .phoneNumber
    let emailValidType: String.ValidTypes = .email
    let passwordValidType: String.ValidTypes = .password
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstrains()
        setupDelegate()
        setupDatePicker()
        registerKeyboardNotifications()
        }
    
    private func setupViews() {
        title = "SignUp"
        
        elementsStackView = UIStackView(arrangedSubViews: [registerLabel,
                                                           firstNameTextField,
                                                           firstNameValidLabel,
                                                           secondNameTextField,
                                                           secondNameValidLabel,
                                                           datePicker,
                                                           phoneNumberTextField,
                                                           phoneNumberValidLabel,
                                                           emailTextField,
                                                           emailValidLabel,
                                                           passwordTextField,
                                                           passwordValidLabel],
                                        axis: .vertical,
                                        spacing: 10,
                                        distibution: .fillProportionally)
        
        buttonsStackView = UIStackView(arrangedSubViews: [signUpButton, backButton],
                                       axis: .horizontal,
                                       spacing: 5,
                                       distibution: .fillEqually)
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(elementsStackView)
        backgroundView.addSubview(registerLabel)
        backgroundView.addSubview(buttonsStackView)
    }
    
    private func setupDelegate() {
        firstNameTextField.delegate = self
        secondNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.borderColor = nil
        datePicker.layer.borderWidth = 1
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 6
        datePicker.tintColor = .black
    }
    
    private func setTextField(textField: UITextField, label: UILabel,
                              validType: String.ValidTypes,
                              validMessage: String, wrongMessage: String,
                              string: String, range: NSRange) {
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validtype: validType) {
            label.text = validMessage
            label.textColor = .green
        } else {
            label.text = wrongMessage
            label.textColor = .red
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case firstNameTextField: setTextField(textField: firstNameTextField, label: firstNameValidLabel,
                                              validType: nameValidType, validMessage: "Name is Valid",
                                              wrongMessage: "Name is not Valid", string: string, range: range)
        case secondNameTextField: setTextField(textField: secondNameTextField, label: secondNameValidLabel,
                                              validType: nameValidType, validMessage: "Name is Valid",
                                              wrongMessage: "Name is not Valid", string: string, range: range)
        case phoneNumberTextField: setTextField(textField: phoneNumberTextField, label: phoneNumberValidLabel,
                                                validType: phoneNumberValidType, validMessage: "Phone is Valid",
                                              wrongMessage: "Phone is not Valid", string: string, range: range)
        case emailTextField: setTextField(textField: emailTextField, label: emailValidLabel,
                                          validType: emailValidType, validMessage: "Email is Valid",
                                              wrongMessage: "Email is not Valid", string: string, range: range)
        case passwordTextField: setTextField(textField: passwordTextField, label: passwordValidLabel,
                                             validType: passwordValidType, validMessage: "Password is Valid",
                                              wrongMessage: "Password is not Valid", string: string, range: range)
        default:
            break
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

extension SignUpViewController {
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name:UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:Notification) {
            guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
                return
            }

            if notification.name == UIResponder.keyboardWillShowNotification ||  notification.name == UIResponder.keyboardWillChangeFrameNotification {
                self.view.frame.origin.y = -keyboardReact.height / 3
            } else {
                self.view.frame.origin.y = 0
            }

        }
}

extension SignUpViewController {
    private func setConstrains() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            registerLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            registerLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 70)
        ])
        
        NSLayoutConstraint.activate([
            elementsStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            elementsStackView.topAnchor.constraint(equalTo: registerLabel.topAnchor, constant: 50),
            elementsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            elementsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -40),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 60),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}

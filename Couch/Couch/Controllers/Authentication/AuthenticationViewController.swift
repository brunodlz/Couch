import UIKit
import SafariServices

protocol AuthenticationDelegate: class {
    func validateWithSuccess()
}

class AuthenticationViewController: UIViewController {
    
    private let loginView = AuthenticationView()
    private weak var delegate: AuthenticationDelegate?
    private weak var provider: DataProvider!
    
    private let viewModel = AuthenticationViewModel()
    
    init(provider: DataProvider, delegate: AuthenticationDelegate) {
        self.provider = provider
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = loginView
        self.view.backgroundColor = ColorPalette.black
        
        self.navigationController?.topView(hidden: true)

        loginView.pinTextField.delegate = self
        loginView.connectButton.addTarget(self,
                                          action: #selector(connect),
                                          for: .touchUpInside)
        
        loginView.getPinButton.addTarget(self,
                                         action: #selector(openGetPin),
                                         for: .touchUpInside)
    }
    
    func connect() {
        self.didRequest()
        if let code = loginView.pinTextField.text {
            provider.token(With: code, callback: { (result) in
                guard case .success(let data) = result else {
                    print("---> an error occurred, try again :(")
                    return
                }
                guard self.viewModel.validateToken(with: data) else {
                    self.alert()
                    return
                }
                self.didUpdate()
                self.delegate?.validateWithSuccess()
            })
        }
    }
    
    private func alert() {
        let alertController = UIAlertController(title: "Error", message: "Incorrect information\ntry again :)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension AuthenticationViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.clearToNavigationController()
    }
    
}

extension AuthenticationViewController: SFSafariViewControllerDelegate {
    
    func openGetPin() {
        let url = URL(string: OAuth.authorization)!
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        self.present(safariViewController, animated: true, completion: nil)
    }
    
}

extension AuthenticationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let text = textField.text else { return true }
        guard !text.isEmpty else { return true }
        
        self.connect()
        
        return true
    }
    
}

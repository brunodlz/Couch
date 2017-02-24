import UIKit

class ProfileViewController: UIViewController {
    
    let viewModel = ProfileViewModel()
    let container = ProfileView()
    
    weak var provider: DataProvider!
    
    init(provider: DataProvider) {
        self.provider = provider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getProfile(provider) { (result) in
            if let profile = result {
                self.container.setup(profile)
            }
        }
    }
    
    override func loadView() {
        self.view = container
        self.view.backgroundColor = ColorPalette.black
    }
    
}

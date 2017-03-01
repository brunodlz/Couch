import UIKit

protocol ShowTableViewControllerDelegate: class {
    func presentProfile()
    func showTableViewController(_ controller: ShowTableViewController, didSelect show: Show)
}

class ShowTableViewController: UITableViewController {
    
    let viewModel = ShowViewModel()
    let profileModel = ProfileViewModel()
    
    weak var provider: DataProvider!
    fileprivate weak var delegate: ShowTableViewControllerDelegate?
    
    private struct Constants {
        static let cellIdentifier = "cell"
        static let headerIdentifier = "seg"
    }
    
    var shows = [Show]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(provider: DataProvider, delegate: ShowTableViewControllerDelegate) {
        self.provider = provider
        self.delegate = delegate
        
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = ColorPalette.black
        tableView.register(SegmentCell.self, forCellReuseIdentifier: Constants.headerIdentifier)
        tableView.register(ShowCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView()
        
        self.didRequest()
        profileModel.getProfile(provider) { (profile) in
            if profile != nil {
                self.currentWatching()
            }
        }
    }
    
    private func currentWatching() {
        viewModel.watching(provider) { (result) in
            self.didUpdate()
            self.shows.removeAll()
            self.shows = result
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! ShowCell
        cell.setup(show: shows[indexPath.item])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.showTableViewController(self, didSelect: shows[indexPath.item])
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let segment = tableView.dequeueReusableCell(withIdentifier: Constants.headerIdentifier) as! SegmentCell
        segment.backgroundColor = ColorPalette.black
        return segment
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension ShowTableViewController {
    
    fileprivate func configureView() {
        let image = UIImageView(image: .couch())
        image.tintImageColor(color: .white)
        self.navigationItem.titleView = image
        
        let profileButton = UIBarButtonItem(image: .user(),
                                            style: .plain,
                                            target: self,
                                            action: #selector(profilePressed(_:)))
        self.navigationItem.rightBarButtonItem = profileButton
    }
    
    @objc private func profilePressed(_ sender: Any?) {
        delegate?.presentProfile()
    }
    
}

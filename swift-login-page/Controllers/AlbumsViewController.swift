import UIKit

class AlbumsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchController = UISearchController (searchResultsController: nil)
    
    var albums = [Album]()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setupDelegate()
        setNavigationBar()
        setupSearchController()
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchBar.delegate = self
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Albums"
        
        navigationItem.searchController = searchController
        
        let userInfoButton = createCustomButton(selector: #selector(userInfoButtonTapped))
        userInfoButton.target = self
        navigationItem.rightBarButtonItem = userInfoButton
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    @objc private func userInfoButtonTapped() {
        let userInfoViewController = UserInfoViewController()
        userInfoViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    private func fetchAlbums(albumName: String) {
        
        let urlString = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attriute=albumTerm"
        
        NetworkDataFetch.shared.fetchAlbum(urlString: urlString) { [weak self] albumModel, error in
            
            if error == nil {
                
                guard let albumModel = albumModel else { return }
                self?.albums = albumModel.results
                print(self?.albums)
                self?.tableView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
}
//MARK: - Extension
extension AlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumsTableViewCell
        let album = albums[indexPath.row]
        cell.configureAlbumCell(album: album)
        
        return cell
    }
}
//MARK: - Extension

extension AlbumsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

extension AlbumsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.fetchAlbums(albumName: searchText)
            })
        }
    }
}


extension AlbumsViewController {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}


import UIKit

struct Movie {
    var poster: UIImage
    var title: String
}

struct Cells {
    static let movieCell = "MovieCell"
}

class ResultsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

protocol mainViewControllerDelegate: AnyObject {
    func addNewMovie(title: String, poster: UIImageView)
}

class MainViewController: UIViewController, mainViewControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        if !searchText.isEmpty {
            let filteredMovies = favoriteMovies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            favoriteMovies = filteredMovies
        } else {
            favoriteMovies = fetchData()
        }
        
        tableView.reloadData()
    }
    
    func addNewMovie(title: String, poster: UIImageView) {
        let newMovie = Movie(poster: poster.image ?? UIImage() , title: title)
        favoriteMovies.append(newMovie)
        tableView.reloadData()
    }
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private var favoriteMovies: [Movie] = []
    private let searchController = UISearchController(searchResultsController: ResultsVC())
    
    private let addItemButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Movie Poster", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.hidesBarsOnSwipe = false //ნავბარი მაინც ისქროლება, ვერ ვასწორებ :/
        definesPresentationContext = true
        
        favoriteMovies = fetchData()
        configureTableView()
        configureAddItemButton()
    }
    
    //MARK: - Actions
    @objc private func addButtonPressed() {
        let otherViewController = AddNewItemToListViewController()
        otherViewController.delegate = self
        navigationController?.pushViewController(otherViewController, animated: true)
    }
    
    // MARK: - Methods
    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(MovieCell.self, forCellReuseIdentifier: Cells.movieCell)
        tableView.pin(to: view)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureAddItemButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        let navigationItem = UINavigationItem(title: "Favourite Movies")
        navigationItem.rightBarButtonItem = addButton
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 48))
        navBar.setItems([navigationItem], animated: false)
        
        self.tableView.tableHeaderView = navBar
    }
    
    func didSaveNewItem(_ movie: Movie) {
        favoriteMovies.append(movie)
        tableView.reloadData()
    }
}

// MARK: - TableVIew DataSource & Delegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movieCell) as! MovieCell
        let movie = favoriteMovies[indexPath.row]
        cell.set(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMovie = favoriteMovies[indexPath.row]
        let itemsDetailsVC = ItemDetailsViewController()
        itemsDetailsVC.selectedMovie = selectedMovie
        
        navigationController?.pushViewController(itemsDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favoriteMovies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - Constraint extension & fetchData
extension UIView {
    
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints                               = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive             = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive     = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive   = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive       = true
    }
}

extension MainViewController {
    
    func fetchData() -> [Movie] {
        let movie1 = Movie(poster: Posters.babylon, title: "Babylon")
        let movie2 = Movie(poster: Posters.cinemaParadiso, title: "Cinema Paradiso")
        let movie3 = Movie(poster: Posters.eyesWideShut, title: "Eyes Wide Shut")
        let movie4 = Movie(poster: Posters.magnolia, title: "Magnolia")
        let movie5 = Movie(poster: Posters.noCountryForOldMen, title: "No Country For Old Men")
        let movie6 = Movie(poster: Posters.onceUponaTime, title: "Once Upon a Time in America")
        let movie7 = Movie(poster: Posters.theGirl, title: "The girl with the dragon tattoo")
        let movie8 = Movie(poster: Posters.whale, title: "The whale")
        let movie9 = Movie(poster: Posters.zodiac, title: "Zodiac")
        let movie10 = Movie(poster: Posters.blood, title: "There will be blood")
        
        return [movie1, movie2, movie3, movie4, movie5, movie6, movie7, movie8, movie9, movie10]
    }
}


import UIKit

struct Movie {
    var poster: UIImage
    var title: String
}

struct Cells {
    static let movieCell = "MovieCell"
}

class MainViewController: UIViewController {

    // MARK: - Properties
    
    let tableView = UITableView()
    var favoriteMovies: [Movie] = []
    
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
        favoriteMovies = fetchData()
        configureTableView()
        configureAddItemButton()
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
    
    @objc private func addButtonPressed() {
        let otherViewController = AddNewItemToListViewController()
        let navigationController = UINavigationController(rootViewController: AddNewItemToListViewController())
        self.present(navigationController, animated: true, completion: nil)
    }
}

    // MARK: - TableVIew DataSource & Delegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movieCell) as! MovieCell
        let movie = favoriteMovies[indexPath.row]
        cell.set(movie: movie)
        
        return cell
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


import UIKit

class ItemDetailsViewController: UIViewController {
    
    //MARK: - Properties
    
    var selectedMovie: Movie?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private let masterStackView: UIStackView = {
        
        let masterStackView = UIStackView()
        masterStackView.axis = .vertical
        masterStackView.translatesAutoresizingMaskIntoConstraints = false
        masterStackView.spacing = 12
        
        return masterStackView
    }()
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackground()
        setUpSubviews()
        setUpConstraints()
        configureViews()
    }
    
    //MARK: - Configure
    func configureViews() {
        guard let movie = selectedMovie else { return }
        imageView.image = movie.poster
        titleLabel.text = movie.title
    }
    
    //MARK: - Private Methods
    
    private func setUpBackground() {
        view.backgroundColor = .white
    }
    
    private func setUpSubviews() {
        view.addSubview(masterStackView)
        masterStackView.addArrangedSubview(imageView)
        masterStackView.addArrangedSubview(titleLabel)
        
    }
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            masterStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            masterStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            masterStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            masterStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            imageView.topAnchor.constraint(equalTo: masterStackView.topAnchor, constant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 500),
        ])
    }
}



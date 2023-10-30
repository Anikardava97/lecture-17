
import UIKit

class MovieCell: UITableViewCell {
    
    // MARK: - Properties
    var moviePosterImageView = UIImageView()
    var movieTitleLabel = UILabel()
    
    // MARK: - ViewLifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(moviePosterImageView)
        addSubview(movieTitleLabel)
        
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func set(movie: Movie) {
        moviePosterImageView.image = movie.poster
        movieTitleLabel.text = movie.title
    }
    
    func configureImageView() {
        moviePosterImageView.layer.cornerRadius = 8
        moviePosterImageView.clipsToBounds = true
    }
    
    func configureTitleLabel() {
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints() {
        moviePosterImageView.translatesAutoresizingMaskIntoConstraints                                                     = false
        moviePosterImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                     = true
        moviePosterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive                       = true
        moviePosterImageView.heightAnchor.constraint(equalToConstant: 80).isActive                                         = true
        moviePosterImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setTitleConstraints() {
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints                                                      = false
        movieTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                      = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: moviePosterImageView.trailingAnchor, constant: 20).isActive  = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive                                          = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive                     = true
    }
}

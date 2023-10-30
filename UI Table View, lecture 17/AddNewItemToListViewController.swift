
import UIKit

class AddNewItemToListViewController: UIViewController {
    
    //MARK: - Properties
    private let masterStackView: UIStackView = {
        
        let masterStackView = UIStackView()
        masterStackView.axis = .vertical
        masterStackView.translatesAutoresizingMaskIntoConstraints = false
        masterStackView.spacing = 32
        
        return masterStackView
    }()
    
    
    private let movieTitleTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Movie Title"
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.textColor = .black
        textField.textAlignment = .center
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 8
        
        return textField
    }()
    
    private let addPosterButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("+ Add Photo", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemGray4
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let saveButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackground()
        setUpSubviews()
        setUpConstraints()
        
    }
    
    //MARK: - Actions
    @objc func didTapButton() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    //MARK: - Private Methods
    
    private func setUpBackground() {
        view.backgroundColor = .white
    }
    
    private func setUpSubviews() {
        view.addSubview(masterStackView)
        masterStackView.addArrangedSubview(movieTitleTextField)
        masterStackView.addArrangedSubview(addPosterButton)
        masterStackView.addArrangedSubview(imageView)
        masterStackView.addArrangedSubview(saveButton)
        
        
        addPosterButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        masterStackView.addArrangedSubview(imageView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            masterStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            masterStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            masterStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            masterStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            
            movieTitleTextField.topAnchor.constraint(equalTo: masterStackView.topAnchor, constant: 100),
            movieTitleTextField.heightAnchor.constraint(equalToConstant: 40),
            addPosterButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

extension AddNewItemToListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

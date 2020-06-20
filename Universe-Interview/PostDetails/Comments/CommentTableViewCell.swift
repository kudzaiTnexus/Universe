//
//  CommentTableViewCell.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
        // MARK: - View components
    
    private let avatar: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        imageView.layer.borderWidth = 2.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.orange.cgColor
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "avatar")
        
        return imageView
    }()
    
    
    private var authorNameLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    private let authorEmailLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let commentBodyLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 16
        
        return stackView
    }()
    
    private let mainVerticalStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        
        return stackView
    }()

        // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

    // MARK: - Setup view

extension CommentTableViewCell {
    func setupView() {

        self.verticalStackView.addArrangedSubview(authorNameLabel)
        self.verticalStackView.addArrangedSubview(authorEmailLabel)
        
        self.mainVerticalStackView.addArrangedSubview(verticalStackView)
        self.mainVerticalStackView.addArrangedSubview(commentBodyLabel)
        
        self.horizontalStackView.addArrangedSubview(avatar)
        self.horizontalStackView.addArrangedSubview(mainVerticalStackView)
        
        self.addSubview(horizontalStackView)
 
        self.setupConstraints()
        
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
    }
    
    func setupConstraints() {
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        
    }
    
    func configureView(with comment: Comment) {
        self.authorNameLabel.text = comment.name.capitalized
        self.authorEmailLabel.text = comment.email
        self.commentBodyLabel.text = comment.body
    }
    
}

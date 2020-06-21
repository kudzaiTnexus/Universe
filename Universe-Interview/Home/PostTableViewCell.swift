//
//  HomeTableViewCell.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
        // MARK: - View components
    
    private var postNumberLabel: UILabel = {
        
        let label = UILabel().universeLabel(with: CGFloat(16),
                                            color: .white,
                                            fontWeight: .semibold)
        
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 1.0
        label.backgroundColor = UIColor.orange
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        
        let label = UILabel().universeLabel(with: CGFloat(16),
                                            color: .black,
                                            fontWeight: .semibold)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        
        let label = UILabel().universeLabel(with: CGFloat(12),
                                            color: .gray,
                                            fontWeight: .regular)
        
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

extension PostTableViewCell {
    func setupView() {

        self.verticalStackView.addArrangedSubview(titleLabel)
        self.verticalStackView.addArrangedSubview(bodyLabel)
        
        
        self.horizontalStackView.addArrangedSubview(postNumberLabel)
        self.horizontalStackView.addArrangedSubview(verticalStackView)
        
        self.addSubview(horizontalStackView)
 
        self.setupConstraints()
    }
    
    func setupConstraints() {
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        
    }
    
    func configureView(with post: Post ,index: IndexPath, color: UIColor) {
        self.titleLabel.text = post.title.capitalized
        self.bodyLabel.text = post.body
        self.postNumberLabel.text = String(index.row+1)
        self.postNumberLabel.backgroundColor = color
    }
    
}

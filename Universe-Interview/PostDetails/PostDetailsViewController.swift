//
//  PostDetailsViewController.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

class PostDetailsViewController: UIViewController {
    
    private var post: Post!
    private var commentsTableViewController: CommentsTableViewController!
        
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
        label.backgroundColor = UIColor.purple.withAlphaComponent(0.6)
        
         label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        
        let label = UILabel().universeLabel(with: CGFloat(16),
                                            color: .black,
                                            fontWeight: .semibold)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        
        let label = UILabel().universeLabel(with: CGFloat(16),
                                            color: .darkGray,
                                            fontWeight: .ultraLight)
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let showMoreButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.layer.cornerRadius = 8
        button.tintColor = .white
        button.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        button.setTitle(NSLocalizedString("showmore.title", comment: ""), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOpacity = 0.5
        button.addTarget(self, action: #selector(onShowMoreButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private let commentsView: UIView = {
        let commentsView = UIView(frame: .zero)
        
        commentsView.translatesAutoresizingMaskIntoConstraints = false
        return commentsView
    }()
    
    private let mainVerticalStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 16
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
     // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("comments.title", comment: "")
        self.commentsTableViewController = CommentsTableViewController(with: String(post.id))
        
        self.setupView()
    }
    
    @objc func onShowMoreButtonTap(sender: UIButton) {
        let viewController = UserPostsTableViewController(with: post.userID)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}


extension PostDetailsViewController {

    func setupView() {
        
        view.backgroundColor = UIColor.white
        
        mainVerticalStackView.addArrangedSubview(titleLabel)
        mainVerticalStackView.addArrangedSubview(bodyLabel)

        mainVerticalStackView.setCustomSpacing(12, after: bodyLabel)
        mainVerticalStackView.addArrangedSubview(showMoreButton)
        
        horizontalStackView.addArrangedSubview(postNumberLabel)
        horizontalStackView.addArrangedSubview(mainVerticalStackView)
        
        view.addSubview(horizontalStackView)
        view.addSubview(commentsView)
        self.commentsView.addSubview(self.commentsTableViewController.view)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 16).isActive = true
        
        commentsView.translatesAutoresizingMaskIntoConstraints = false
        commentsView.topAnchor.constraint(equalTo: self.horizontalStackView.layoutMarginsGuide.bottomAnchor, constant: 16).isActive = true
        commentsView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor).isActive = true
        commentsView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor).isActive = true
        commentsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.commentsTableViewController.tableView.layoutPinToSuperviewEdges()

    }
    
    func configureViewWith(post: Post, and index: Int) {
        self.postNumberLabel.text = String(index+1)
        self.titleLabel.text = post.title.capitalized
        self.bodyLabel.text = post.body
        self.post = post
    }

}

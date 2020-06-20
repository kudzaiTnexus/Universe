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
    
    private var commentsTableViewController = CommentsTableViewController()
        // MARK: - View components
    
    private var postNumberLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 1.0
        label.backgroundColor = UIColor.orange
        
         label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .ultraLight)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
    
    private let commentsView: UIView = {
        let commentsView = UIView(frame: .zero)
        
        commentsView.translatesAutoresizingMaskIntoConstraints = false
        return commentsView
    }()
    
    private let dividerLine: UIView = {
        let view = UIView(frame: .zero)
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.backgroundColor = UIColor.orange
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        button.setTitle("Show More", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(onShowMoreButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private let moreButtonHorizontalStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.distribution = .fill
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    func setupView() {
        
        mainVerticalStackView.addArrangedSubview(titleLabel)
        mainVerticalStackView.addArrangedSubview(bodyLabel)
        mainVerticalStackView.addArrangedSubview(dividerLine)
        
        self.moreButtonHorizontalStackView.addArrangedSubview(UIView(frame: .zero))
        self.moreButtonHorizontalStackView.addArrangedSubview(showMoreButton)
        self.mainVerticalStackView.addArrangedSubview(moreButtonHorizontalStackView)
        
        horizontalStackView.addArrangedSubview(postNumberLabel)
        horizontalStackView.addArrangedSubview(mainVerticalStackView)
        
        view.addSubview(horizontalStackView)
        view.addSubview(commentsView)
        self.setupConstraints()
        
        view.backgroundColor = UIColor.white
        
        self.commentsTableViewController.tableView.showsVerticalScrollIndicator = false
        self.commentsTableViewController.view.translatesAutoresizingMaskIntoConstraints = false

        setupCommentsView()
    }
    
    func configureViewWith(post: Post, and index: Int) {
        self.postNumberLabel.text = String(index)
        self.titleLabel.text = post.title.capitalized
        self.bodyLabel.text = post.body
        self.post = post
        self.commentsTableViewController.post = post
    }
    
    func setupConstraints() {
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 16).isActive = true
        
        commentsView.translatesAutoresizingMaskIntoConstraints = false
        commentsView.topAnchor.constraint(equalTo: self.horizontalStackView.layoutMarginsGuide.bottomAnchor, constant: 16).isActive = true
        commentsView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor).isActive = true
        commentsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        commentsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

    }
    
    func setupCommentsView() {
       
        self.commentsView.addSubview(self.commentsTableViewController.view)
        self.commentsTableViewController.tableView.layoutPinToSuperviewEdges()
    }
    
    
    @objc func onShowMoreButtonTap(sender: UIButton) {
        let viewController = AuthorPostsTableViewController()
        viewController.post = post
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}




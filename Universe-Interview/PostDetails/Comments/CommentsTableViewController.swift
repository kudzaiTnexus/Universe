//
//  CommentsTableViewController.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

class CommentsTableViewController: UniverseBaseTableViewController {
    
    private var postId: String!
    
    private let viewModel = CommentsViewModel()
    
    private var comments: [Comment] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - View Life cycle
    
    init(with postId: String) {
        super.init(nibName: nil, bundle: nil)
        self.postId = postId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerTableViewCells() {
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "\(CommentTableViewCell.self)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchComments()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorStyle = .none
        self.registerTableViewCells()
        
        self.errorViewController.delegate = self
        
        self.fetchComments()
    }
    
    // MARK: - Service Call
    
    func fetchComments() {
        self.showActivityIndicator()
        
        self.viewModel.fetchComments(for: postId) { result in
            switch result {
                
            case .success(let comments):
                self.comments = comments
                self.hideActivityIndicator()
            case .failure(let error):
                self.showErrorView(with: error.message)
                self.hideActivityIndicator()
            }
            
        }
    }
    
    // MARK: - Error Handling
    
    override func onRetryTap() {
        self.hideErrorView()
        self.fetchComments()
    }
    
    // MARK: - Table view data source and delegate calls
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let dividerView = UIView(frame: .zero)
        dividerView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        return dividerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let commentCell = tableView.dequeueReusableCell(withIdentifier: "\(CommentTableViewCell.self)", for: indexPath) as! CommentTableViewCell
        commentCell.configureView(with: comments[indexPath.row])
        return commentCell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        UIView.animate(withDuration: 0.8, delay: 0.05 * Double(indexPath.row), animations: {
            cell.alpha = 1
        })
    }
}


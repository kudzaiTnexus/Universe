//
//  CommentsTableViewController.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

class CommentsTableViewController: UniverseBaseTableViewController {

    var post: Post!
    
    private let viewModel = CommentsViewModel()
    private lazy var errorViewController = ErrorViewController()
    
    private var comments: [Comment] = [] {
        didSet {
            tableView.reloadData()
        }
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
        
        navigationItem.hidesBackButton = true
        
        self.tableView.separatorStyle = .none
        self.title = "Posts"
        self.registerTableViewCells()
        
        self.errorViewController.delegate = self
        
        self.fetchComments()
    }
    
    func fetchComments() {
        self.showActivityIndicator()
        
        self.viewModel.fetchComments(for: String(post.id)) { result in
            switch result {
                 
            case .success(let comments):
                self.comments = comments
                self.hideActivityIndicator()
            case .failure( _):
                self.hideActivityIndicator()
                self.showErrorView()
                self.hideActivityIndicator()
            }

        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let commentCell = tableView.dequeueReusableCell(withIdentifier: "\(CommentTableViewCell.self)", for: indexPath) as! CommentTableViewCell
        commentCell.configureView(with: comments[indexPath.row])
        return commentCell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailsViewContoller = PostDetailsViewController()
//        detailsViewContoller.configureViewWith(post: posts[indexPath.row], and: indexPath.row)
//        self.navigationController?.pushViewController(detailsViewContoller, animated: true)
//    }

}

extension CommentsTableViewController: RetryDelegate {
    
    func onRetryTap() {
        self.hideErrorView()
        self.fetchComments()
    }
    
    func showErrorView() {
        self.addChild(errorViewController)
        self.errorViewController.view.frame = view.bounds
        self.view.addSubview(errorViewController.view)
        self.view.bringSubviewToFront(errorViewController.view)
        self.errorViewController.didMove(toParent: self)
    }
    
    func hideErrorView() {
        self.errorViewController.willMove(toParent: nil)
        self.errorViewController.view.removeFromSuperview()
        self.errorViewController.removeFromParent()
    }
}

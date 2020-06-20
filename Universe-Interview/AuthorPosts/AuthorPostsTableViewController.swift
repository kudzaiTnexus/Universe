//
//  AuthorPostsTableViewController.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

class AuthorPostsTableViewController: UniverseBaseTableViewController {

    private let viewModel = PostsViewModel()
    var post: Post!
    private lazy var errorViewController = ErrorViewController()
    
    private var posts: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    func registerTableViewCells() {
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "\(PostTableViewCell.self)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchPostsData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        self.tableView.separatorStyle = .none
        self.title = "Posts"
        self.registerTableViewCells()
        
        self.errorViewController.delegate = self
    }
    
    func fetchPostsData() {
        self.showActivityIndicator()
        
        self.viewModel.fetchAuthorPosts(by: post.userID) { result in
            switch result {
                 
            case .success(let posts):
                self.posts = posts
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
        return posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: "\(PostTableViewCell.self)", for: indexPath) as! PostTableViewCell
        postCell.configureView(with: posts[indexPath.row], and: indexPath)
        return postCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewContoller = PostDetailsViewController()
        detailsViewContoller.configureViewWith(post: posts[indexPath.row], and: indexPath.row)
        self.navigationController?.pushViewController(detailsViewContoller, animated: true)
    }

}

extension AuthorPostsTableViewController: RetryDelegate {
    
    func onRetryTap() {
        self.hideErrorView()
        self.fetchPostsData()
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

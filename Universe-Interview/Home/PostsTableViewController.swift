//
//  HomeTableViewController.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

class PostsTableViewController: UniverseBaseTableViewController {

    private let viewModel = PostsViewModel()

    private var posts: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - View Life cycle
    
    func registerTableViewCells() {
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "\(PostTableViewCell.self)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchPostsData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        self.title = NSLocalizedString("all.posts.title", comment: "")
        self.registerTableViewCells()
        
        self.errorViewController.delegate = self
    }
    
    // MARK: - Service Call
    
    func fetchPostsData() {
        self.showActivityIndicator()
        
        self.viewModel.fetchPosts { result in
            switch result {
                 
            case .success(let posts):
                self.posts = posts
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
        self.fetchPostsData()
    }
    
    // MARK: - Table view data source and delegate calls
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: "\(PostTableViewCell.self)", for: indexPath) as! PostTableViewCell
        postCell.configureView(with: posts[indexPath.row], index: indexPath, color: UIColor.orange)
        return postCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewContoller = PostDetailsViewController()
        detailsViewContoller.configureViewWith(post: posts[indexPath.row], and: indexPath.row)
        self.navigationController?.pushViewController(detailsViewContoller, animated: true)
    }

}



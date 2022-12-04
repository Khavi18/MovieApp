//
//  MovieTableViewController.swift
//  MovieApp
//
//  Created by khavishini suresh on 30/11/2022.
//

import UIKit
import Alamofire

class MovieTableViewController: UITableViewController {
    
    var movies = Movies()
    
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        pullToRefresh()
        getMovies(page: page)
    }
    
    //Refresh
    func pullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        print("Refreshing Data")
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    //Load movies
    func getMovies(page: Int) {
        
        APIService.sharedInstance.fetchMovieList(pages: page) { [weak self] movieList in
            
            self?.movies.results.append(contentsOf: movieList.results)
            self?.movies.totalPages = movieList.totalPages
            self?.tableView.reloadData()
            
        }
        
        print("PAGE: \(self.page)")
        
        if self.page < movies.totalPages {
            self.page += 1
        } else {
            self.page = movies.totalPages
        }
        
        
    }
    
    //Load more movies
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
            
        if maxOffset - offset <= 50.0 {
            getMovies(page: page)
        }
    }
    
    
    //TableView Setup
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.results.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }

        let movie = movies.results[indexPath.row]
        
        
        cell.titleLabel?.text = movie.title
        cell.voteAverageLabel?.text = "\(movie.voteAverage)"

        if let posterURL = movie.poster {
            let imgUrl = "https://image.tmdb.org/t/p/w500" + posterURL
            let url = URL(string: imgUrl)
            cell.posterImage.kf.setImage(with: url)
        } else {
            cell.posterImage.image = UIImage(named: "NoPoster")
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is MovieDetailViewController {
            let vc = segue.destination as? MovieDetailViewController
            let indexRow = self.tableView.indexPathForSelectedRow
            vc?.movieID = movies.results[indexRow!.row].id
        }
    }
    

}

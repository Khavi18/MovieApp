//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by khavishini suresh on 30/11/2022.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieDetail = MovieDetail()
    var movieID = 0

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APIService.sharedInstance.fetchingAPIData(movieID: movieID) { movieDetail in
            print(self.movieID)
            self.getMovieDetail(movieDetail: movieDetail)
        }
        
        
    }
    
    func getMovieDetail(movieDetail: MovieDetail) {
        titleLabel.text = "\(movieDetail.title)"
        overviewLabel.text = "\(movieDetail.overview ?? "No Overview Available")"
        runtimeLabel.text = "Runtime: \(movieDetail.runtime ?? 0) mins"
        voteAverageLabel.text = "Vote Average: \(movieDetail.voteAverage)"
        voteCountLabel.text = "Vote Count: \(movieDetail.voteCount)"
        popularityLabel.text = "Popularity: \(movieDetail.popularity)"
        
        if let posterURL = movieDetail.backdrop {
            let imgUrl = "https://image.tmdb.org/t/p/w500" + posterURL
            backgroundImageView.downloaded(from: imgUrl)
        } else {
            backgroundImageView.image = UIImage(named: "noImage")
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


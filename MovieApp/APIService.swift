//
//  APIService.swift
//  MovieApp
//
//  Created by khavishini suresh on 30/11/2022.
//

import Foundation
import Alamofire

class APIService {

    static let sharedInstance = APIService()
    
    func fetchMovieList(pages: Int, handler: @escaping (_ movie: Movies)->(Void)) {
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=89a571acaf96541bdee2b19060fc9980&language=en-US&page=\(pages)"
        
        AF.request(url, method: .get,parameters: nil, encoding: URLEncoding.default)
            .response { response in
                
                switch response.result {
                case .success(let data):
                    do {
                        let movies = try JSONDecoder().decode(Movies.self, from: data!)
                        handler(movies)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")

                }
        }
    }
    
    func fetchingAPIData(movieID: Int, handler: @escaping (_ movieDetail: MovieDetail)->(Void)) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=89a571acaf96541bdee2b19060fc9980"
        
        AF.request(url,method: .get,parameters: nil, encoding: URLEncoding.default)
            .response { response in
                
                switch response.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(MovieDetail.self, from: data!)
                        handler(jsonData)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")

                }
        }
    }
}

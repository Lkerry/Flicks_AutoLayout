//
//  DetailsViewController.swift
//  Flix_Part1
//
//  Created by Kerry LEVEILLE on 9/25/18.
//  Copyright © 2018 Kerry LEVEILLE. All rights reserved.
//

import UIKit

enum MovieKeys {
    static let movieID = "id"
    static let title = "title"
    
}

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var trailerButton: UIBarButtonItem!
    
    var movie: [String: Any]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let movie = movie{
            titleLabel.text = movie[MovieKeys.title] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie ["overview"] as? String
            let backdropPathString = movie["backdrop_path"] as! String
            let posterPathString = movie["poster_path"] as! String
            let posterBaseUrl = "https://image.tmdb.org/t/p/w500"
            let backdropURL = URL(string: posterBaseUrl + backdropPathString)!
            backDropImageView.af_setImage(withURL: backdropURL)
            let posterPathURL = URL(string: posterBaseUrl + posterPathString)!
            posterImageView.af_setImage(withURL: posterPathURL)
            navigationItem.title = movie[MovieKeys.title] as? String
        }

    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TrailerViewController
        if let movie = movie {
            let movieId = String(describing: movie[MovieKeys.movieID]!)
            vc.movieId = movieId
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
}

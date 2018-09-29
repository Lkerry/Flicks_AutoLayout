//
//  TrailerViewController.swift
//  Flix_Part1
//
//  Created by Kerry LEVEILLE on 9/29/18.
//  Copyright © 2018 Kerry LEVEILLE. All rights reserved.
//

import UIKit

class TrailerViewController: UIViewController {

    //var movieID:Int = 0
    
    var movieId: String?
    var trailerKeys: [String] = []
    
    //@IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        /*let baseURLString = "https://api.themoviedb.org/3/movie/"
         let postURL = (String(movieID) + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")
         let videoURL = URL(string: baseURLString + postURL)!
         webView.loadRequest(URLRequest(url: videoURL))*/
        
        
        trailer()
        
    }
    
    func trailer() {
        
        // Do any additional setup after loading the view.
        if let movieId = movieId {
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=5f89533e24a2ff0828389c5e1cb6f8e8&language=en-US")!
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    let errorAlertController = UIAlertController(title: "Cannot Get Trailer", message: "The Internet connections appears to be offline.", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Retry", style: .cancel)
                    errorAlertController.addAction(cancelAction)
                    self.present(errorAlertController, animated: true)
                    print(error.localizedDescription)
                } else if let data = data {
                    // Get the trailers
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let videoResults = dataDictionary["results"]! as! [[String: Any]]
                    for video in videoResults {
                        let type = String(describing: video["type"]!)
                        if type == "Trailer" {
                            self.trailerKeys.append(String(describing: video["key"]!))
                        }
                    }
                    // Play the trailer
                    if (self.trailerKeys.count > 0) {
                        let key = self.trailerKeys[0]
                        let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(key)")!
                        let request = URLRequest(url: youtubeURL)
                        self.webView.loadRequest(request)
                    }
                }
            }
            task.resume()
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

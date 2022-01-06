//
//  ViewController.swift
//  Studio Ghibli Final App
//
//  Created by administrator on 06/01/2022.
//

import UIKit

// add collection view delegate + when selected segue to details page with all info
class MainViewController: UIViewController {
    
    
    @IBOutlet weak var moviesCollecetionView: UICollectionView!
    
    var movies = Movies()
    let tag = "Main: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesCollecetionView.delegate = self
        moviesCollecetionView.dataSource = self
        //fetch data
        APIModel.getData(with: "https://ghibliapi.herokuapp.com/films", completionHandler: {
            data, response, error in
            print(self.tag + "api initialized")
            print(data ?? "no data")
            guard let myData = data else { return }
            do {
                let decoder = JSONDecoder()
                let jsonResult = try decoder.decode([Movie].self, from: myData)
                self.movies = jsonResult
                DispatchQueue.main.async {
                    self.moviesCollecetionView.reloadData()
                }
                
            }
            catch {
                print(error.localizedDescription)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieSegue"{
            print("prepare to go to Details")
            let detailsVC = segue.destination as! DetailsViewController
            if sender is IndexPath {
                let indexPath  = sender as! NSIndexPath
                let movie = movies[indexPath.item]
                print(movie)
                detailsVC.movie = movie
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "movieSegue", sender: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollecetionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        cell.setupCell(movie: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.45, height: self.view.frame.height * 0.35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}

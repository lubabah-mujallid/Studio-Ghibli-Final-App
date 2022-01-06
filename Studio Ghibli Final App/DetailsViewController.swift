//
//  DetailsViewController.swift
//  Studio Ghibli Final App
//
//  Created by administrator on 06/01/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableViewPeople: UITableView!
    @IBOutlet weak var imageViewMovie: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieDescription: UILabel!
    var movie: Movie?
    var people = People()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("details view controller")
        updateUI()
        tableViewPeople.delegate = self
        tableViewPeople.dataSource = self
        
    }
    
    func updateUI() {
        print(movie)
        if let movie = movie {
            print("okk")
            print(movie)
            imageViewMovie.downloaded(from: movie.image)
            labelMovieTitle.text = movie.title
            labelMovieDescription.text = movie.welcomeDescription
            for person in movie.people {
                APIModel.getData(with: person, completionHandler: {
                    data, response, error in
                    print("api initialized")
                    print(data ?? "no data")
                    guard let myData = data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let jsonResult = try decoder.decode(Person.self, from: myData)
                        self.people.append(jsonResult)
                        DispatchQueue.main.async {
                            self.tableViewPeople.reloadData()
                        }
                    }
                    catch {
                        print("error")
                        print(error.localizedDescription)
                    }
                })
            }
        }
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "personSegue"{
            print("prepare to go to Person")
            let PersonVC = segue.destination as! PersonViewController 
            if sender is IndexPath {
                let indexPath  = sender as! NSIndexPath
                let person = people[indexPath.item]
                print(person)
                PersonVC.person = person
            }
        }
    }
    
}


extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(people.count)
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell") as! UITableViewCell
        cell.textLabel?.text = people[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "personSegue", sender: indexPath)
    }
}





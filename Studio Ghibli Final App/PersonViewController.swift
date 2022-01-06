//
//  PersonViewController.swift
//  Studio Ghibli Final App
//
//  Created by administrator on 06/01/2022.
//

import UIKit

class PersonViewController: UIViewController {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var labelGender: UILabel!
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI() {
        if let person = person {
            labelName.text = person.name
            labelAge.text = person.age
            labelGender.text = person.gender?.rawValue
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

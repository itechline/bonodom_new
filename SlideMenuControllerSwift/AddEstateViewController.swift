//
//  AddEstateViewController.swift
//  Bonodom
//
//  Created by Attila Dan on 13/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit

class AddEstateViewController: UIViewController {

    @IBOutlet weak var KiemelImage: UIImageView!
    @IBOutlet weak var KiemelLabel: UILabel!
    @IBOutlet weak var AddDescription: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func KiemelSelector(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            KiemelImage.image = UIImage(named: "main_house")
            KiemelLabel.hidden = true
        case 1:
            KiemelImage.image = UIImage(named: "bonodom_logo")
            KiemelLabel.hidden = true
        case 2:
            KiemelImage.image = UIImage(named: "main_house")
            KiemelLabel.hidden = true
        case 3:
            KiemelImage.hidden = true
            KiemelLabel.hidden = false
        default: KiemelLabel.text = "Kérjük válasszon egy lehetőséget"
        }
    }

}

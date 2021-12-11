//
//  ZTMoviePlayerViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 01/12/21.
//

import UIKit

class ZTMoviePlayerViewController: UIViewController {

    var movieModel:Movies? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func initialLoad(){
        if let modelVal = self.movieModel{
//            if let url = URL.init(string: modelVal.teaserUrl ?? "") {
//                    let item = VersaPlayerItem(url: url)
//                    playerView.set(item: item)
//            }
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

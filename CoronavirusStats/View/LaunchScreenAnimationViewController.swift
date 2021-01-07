//
//  LauncScreenAnimationViewController.swift
//  CoronavirusStats

import UIKit
import SwiftyGif

class LauncScreenAnimationViewController: UIViewController, SwiftyGifDelegate{
    
    @IBOutlet weak var launchImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchImageView.delegate = self
        do {
            let gif = try UIImage(gifName: "staySafe.gif")
            self.launchImageView.setGifImage(gif, loopCount: 1)
        } catch {
            print("Error while setting launch screen animation")
            print(error)
        }
    }
    
    
    func gifDidStop(sender: UIImageView) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainView")
        self.view.window?.rootViewController = vc
    }
    
}

//
//  CafeViewController.swift
//  CafeHunter
//
//  Created by Kiattisak Anoochitarom on 10/1/2557 BE.
//  Copyright (c) 2557 Razeware. All rights reserved.
//

import UIKit

@objc protocol CafeViewControllerDelegate {
  optional func cafeViewControllerDidFinish(controller: CafeViewController)
}

class CafeViewController: UIViewController {
  weak var delegate: CafeViewControllerDelegate?
  
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var streetLabel: UILabel!
  @IBOutlet var cityLabel: UILabel!
  @IBOutlet var zipLabel: UILabel!
  
  var cafe: Cafe? {
    didSet {
      self.setupWithCafe()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupWithCafe()
  }
  
  private func setupWithCafe() {
    if !self.isViewLoaded() {
      return
    }
    
    if let cafe = self.cafe {
      self.title = cafe.name
      
      self.nameLabel.text = cafe.name
      self.streetLabel.text = cafe.street
      self.cityLabel.text = cafe.city
      self.zipLabel.text = cafe.zip
      
      let request = NSURLRequest(URL: cafe.pictureURL)
      NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
        let image = UIImage(data: data)
        self.imageView.image = image
      })
    }
  }
  
  @IBAction private func back(sender: AnyObject) {
    self.delegate?.cafeViewControllerDidFinish?(self)
  }
}

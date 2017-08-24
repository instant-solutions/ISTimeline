//
//  ViewController.swift
//  ISTimelineDemo
//
//  Created by Max Holzleitner on 13.07.16.
//  Copyright © 2016 instant:solutions. All rights reserved.
//

import UIKit
import ISTimeline

class ViewController: UIViewController {

    @IBOutlet weak var timeline: ISTimeline!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let black = UIColor.black
        let green = UIColor.init(red: 76/255, green: 175/255, blue: 80/255, alpha: 1)
        
        let touchAction = { (point:ISPoint) in
            print("point \(point.title)")
        }
        
        let myPoints = [
            ISPoint(title: "06:46 AM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam.", pointColor: black, lineColor: black, touchUpInside: touchAction, fill: false),
            ISPoint(title: "07:00 AM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr.", pointColor: black, lineColor: black, touchUpInside: touchAction, fill: false),
            ISPoint(title: "07:30 AM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam.", pointColor: black, lineColor: black, touchUpInside: touchAction, fill: false),
            ISPoint(title: "08:00 AM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt.", pointColor: green, lineColor: green, touchUpInside: touchAction, fill: true),
            ISPoint(title: "11:30 AM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam.", touchUpInside: touchAction),
            ISPoint(title: "02:30 PM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam.", touchUpInside: touchAction),
            ISPoint(title: "05:00 PM", description: "Lorem ipsum dolor sit amet.", touchUpInside: touchAction),
            ISPoint(title: "08:15 PM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam.", touchUpInside: touchAction),
            ISPoint(title: "11:45 PM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam.", touchUpInside: touchAction)
        ]
        
        timeline.contentInset = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0)
        timeline.points = myPoints
    }
}

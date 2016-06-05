//
//  ISPoint.swift
//  ISTimeline
//
//  Created by Max Holzleitner on 13.05.16.
//  Copyright © 2016 instant:solutions. All rights reserved.
//

class ISPoint {
    
    var title:String
    var description:String?
    var pointColor:UIColor
    var lineColor:UIColor
    var touchUpInside:Optional<(point:ISPoint) -> Void>
    var fill:Bool
    
    init(title:String, description:String, pointColor:UIColor, lineColor:UIColor, touchUpInside:Optional<(point:ISPoint) -> Void>, fill:Bool) {
        self.title = title
        self.description = description
        self.pointColor = pointColor
        self.lineColor = lineColor
        self.touchUpInside = touchUpInside
        self.fill = fill
    }
    
    convenience init(title:String, description:String, touchUpInside:Optional<(point:ISPoint) -> Void>) {
        let defaultColor = UIColor.init(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
        self.init(title: title, description: description, pointColor: defaultColor, lineColor: defaultColor, touchUpInside: touchUpInside, fill: false)
    }
    
    convenience init(title:String, touchUpInside:Optional<(point:ISPoint) -> Void>) {
        self.init(title: title, description: "", touchUpInside: touchUpInside)
    }
    
    convenience init(title:String) {
        self.init(title: title, touchUpInside: nil)
    }
}

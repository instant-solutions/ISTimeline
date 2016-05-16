//
//  ISPoint.swift
//  ISTimeline
//
//  Created by Max Holzleitner on 13.05.16.
//  Copyright © 2016 instant:solutions. All rights reserved.
//

class ISPoint {
    
    var title:String = ""
    var description:String?
    var touchUpInside:Optional<(point:ISPoint) -> Void>
    
    init(title:String, description:String?, touchUpInside:Optional<(point:ISPoint) -> Void>) {
        self.title = title
        self.description = description
        self.touchUpInside = touchUpInside
    }
}

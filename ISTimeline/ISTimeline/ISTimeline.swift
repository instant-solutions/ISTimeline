//
//  ISTimeline.swift
//  ISTimeline
//
//  Created by Max Holzleitner on 07.05.16.
//  Copyright © 2016 instant:solutions. All rights reserved.
//

import UIKit

class ISTimeline: UIView {

    let diameter:CGFloat = 10.0
    let lineWidth:CGFloat = 2.0
    let lineColor = UIColor.whiteColor()
    let points = ["start", "point", "end"]
    
    override func drawRect(rect: CGRect) {
        let ctx: CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSaveGState(ctx)
        
        let arr = buildPointArray()
        
        for i in 0 ..< arr.count {
            if (i < arr.count - 1) {
                var start = arr[i]
                start.x = diameter / 2
                start.y += diameter
                
                var end = arr[i + 1]
                end.x = start.x
                
                drawLine(start, end: end, color: lineColor)
            }
            drawPoint(arr[i], color: UIColor.clearColor())
        }
        
        CGContextClosePath(ctx)
        CGContextRestoreGState(ctx)
    }
    
    private func buildPointArray() -> [CGPoint] {
        var arr = [CGPoint]()
        for i in 0 ..< points.count {
            var offset:CGFloat
            switch i {
            case 0:
                offset = 0.0
            case points.count - 1:
                offset = diameter
            default:
                offset = diameter / 2.0
            }
            
            let segment:CGFloat = self.bounds.height / CGFloat(points.count - 1)
            let y:CGFloat = segment * CGFloat(i) - offset
            let p = CGPointMake(0, y)
            arr.append(p)
        }
        return arr
    }
    
    private func drawLine(start:CGPoint, end:CGPoint, color:UIColor) {
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addLineToPoint(end)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = color.CGColor
        shapeLayer.lineWidth = lineWidth
        
        self.layer.addSublayer(shapeLayer)
    }
    
    private func drawPoint(point:CGPoint, color:UIColor) {
        let path = UIBezierPath(ovalInRect: CGRect(x: point.x, y: point.y, width: diameter, height: diameter))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = UIColor.whiteColor().CGColor
        shapeLayer.fillColor = color.CGColor
        shapeLayer.lineWidth = lineWidth
        
        self.layer.addSublayer(shapeLayer)
    }
}

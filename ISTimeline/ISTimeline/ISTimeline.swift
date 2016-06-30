//
//  ISTimeline.swift
//  ISTimeline
//
//  Created by Max Holzleitner on 07.05.16.
//  Copyright © 2016 instant:solutions. All rights reserved.
//

import UIKit

public class ISTimeline: UIScrollView {
    
    private static let gap:CGFloat = 15.0
    
    public var pointDiameter:CGFloat = 6.0 {
        didSet {
            if (pointDiameter < 0.0) {
                pointDiameter = 0.0
            } else if (pointDiameter > 100.0) {
                pointDiameter = 100.0
            }
        }
    }
    
    public var lineWidth:CGFloat = 2.0 {
        didSet {
            if (lineWidth < 0.0) {
                lineWidth = 0.0
            } else if(lineWidth > 20.0) {
                lineWidth = 20.0
            }
        }
    }
    
    public var bubbleRadius:CGFloat = 2.0 {
        didSet {
            if (bubbleRadius < 0.0) {
                bubbleRadius = 0.0
            } else if (bubbleRadius > 6.0) {
                bubbleRadius = 6.0
            }
        }
    }
    
    public var bubbleColor:UIColor = .init(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
    public var titleColor:UIColor = .whiteColor()
    public var descriptionColor:UIColor = .grayColor()
    
    public var points:[ISPoint] = [] {
        didSet {
            self.layer.sublayers?.forEach({ (let layer:CALayer) in
                if layer.isKindOfClass(CAShapeLayer) {
                    layer.removeFromSuperlayer()
                }
            })
            self.subviews.forEach { (let view:UIView) in
                view.removeFromSuperview()
            }
            
            self.contentSize = CGSizeZero
            
            sections.removeAll()
            buildSections()
            
            layer.setNeedsDisplay()
            layer.displayIfNeeded()
        }
    }
    
    public var bubbleArrows:Bool = true
    
    private var sections:[(point:CGPoint, bubbleRect:CGRect, descriptionRect:CGRect?, titleLabel:UILabel, descriptionLabel:UILabel?, pointColor:CGColor, lineColor:CGColor, fill:Bool)] = []
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        self.clipsToBounds = true
    }
    
    override public func drawRect(rect: CGRect) {
        let ctx:CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSaveGState(ctx)
        
        for i in 0 ..< sections.count {
            if (i < sections.count - 1) {
                var start = sections[i].point
                start.x += pointDiameter / 2
                start.y += pointDiameter
                
                var end = sections[i + 1].point
                end.x = start.x
                
                drawLine(start, end: end, color: sections[i].lineColor)
            }
            drawPoint(sections[i].point, color: sections[i].pointColor, fill: sections[i].fill)
            drawBubble(sections[i].bubbleRect, backgroundColor: bubbleColor, textColor:titleColor, titleLabel: sections[i].titleLabel)
            
            let descriptionLabel = sections[i].descriptionLabel
            if (descriptionLabel != nil) {
                drawDescription(sections[i].descriptionRect!, textColor: descriptionColor, descriptionLabel: sections[i].descriptionLabel!)
            }
        }
        
        CGContextRestoreGState(ctx)
    }
    
    private func buildSections() {
        var y:CGFloat = self.bounds.origin.y + self.contentInset.top
        for i in 0 ..< points.count {
            let titleLabel = buildTitleLabel(i)
            let descriptionLabel = buildDescriptionLabel(i)
            
            let titleHeight = titleLabel.intrinsicContentSize().height
            var height:CGFloat = titleHeight
            if descriptionLabel != nil {
                height += descriptionLabel!.intrinsicContentSize().height
            }
            
            let point = CGPointMake(self.bounds.origin.x + self.contentInset.left + lineWidth / 2, y + (titleHeight + ISTimeline.gap) / 2)
            
            let maxTitleWidth = calcWidth()
            var titleWidth = titleLabel.intrinsicContentSize().width + 20
            if (titleWidth > maxTitleWidth) {
                titleWidth = maxTitleWidth
            }
            let offset:CGFloat = bubbleArrows ? 13 : 5
            let bubbleRect = CGRectMake(
                point.x + pointDiameter + lineWidth / 2 + offset,
                y + pointDiameter / 2,
                titleWidth,
                titleHeight + ISTimeline.gap)
            
            var descriptionRect:CGRect?
            if descriptionLabel != nil {
                descriptionRect = CGRectMake(
                    bubbleRect.origin.x,
                    bubbleRect.origin.y + bubbleRect.height + 3,
                    calcWidth(),
                    descriptionLabel!.intrinsicContentSize().height)
            }
            
            sections.append((point, bubbleRect, descriptionRect, titleLabel, descriptionLabel, points[i].pointColor.CGColor, points[i].lineColor.CGColor, points[i].fill))
            
            y += height
            y += ISTimeline.gap * 2.2 // section gap
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        y += pointDiameter / 2
        self.contentSize = CGSizeMake(self.bounds.width - (self.contentInset.left + self.contentInset.right), y)
    }
    
    private func buildTitleLabel(index:Int) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = points[index].title
        titleLabel.font = UIFont.boldSystemFontOfSize(12.0)
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.preferredMaxLayoutWidth = calcWidth()
        return titleLabel
    }
    
    private func buildDescriptionLabel(index:Int) -> UILabel? {
        let text = points[index].description
        if (text != nil) {
            let descriptionLabel = UILabel()
            descriptionLabel.text = text
            descriptionLabel.font = UIFont.systemFontOfSize(10.0)
            descriptionLabel.lineBreakMode = .ByWordWrapping
            descriptionLabel.numberOfLines = 0
            descriptionLabel.preferredMaxLayoutWidth = calcWidth()
            return descriptionLabel
        }
        return nil
    }
    
    private func calcWidth() -> CGFloat {
        return self.bounds.width - (self.contentInset.left + self.contentInset.right) - pointDiameter - lineWidth - ISTimeline.gap * 1.5
    }
    
    private func drawLine(start:CGPoint, end:CGPoint, color:CGColor) {
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addLineToPoint(end)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = lineWidth
        
        self.layer.addSublayer(shapeLayer)
    }
    
    private func drawPoint(point:CGPoint, color:CGColor, fill:Bool) {
        let path = UIBezierPath(ovalInRect: CGRect(x: point.x, y: point.y, width: pointDiameter, height: pointDiameter))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = color
        shapeLayer.fillColor = fill ? color : UIColor.clearColor().CGColor
        shapeLayer.lineWidth = lineWidth
        
        self.layer.addSublayer(shapeLayer)
    }
    
    private func drawBubble(rect:CGRect, backgroundColor:UIColor, textColor:UIColor, titleLabel:UILabel) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: bubbleRadius)
        
        if bubbleArrows {
            let startPoint = CGPointMake(rect.origin.x, rect.origin.y + rect.height / 2 - 8)
            path.moveToPoint(startPoint)
            path.addLineToPoint(startPoint)
            path.addLineToPoint(CGPointMake(rect.origin.x - 8, rect.origin.y + rect.height / 2))
            path.addLineToPoint(CGPointMake(rect.origin.x, rect.origin.y + rect.height / 2 + 8))
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.fillColor = backgroundColor.CGColor
        
        self.layer.addSublayer(shapeLayer)
        
        let titleRect = CGRectMake(rect.origin.x + 10, rect.origin.y, rect.size.width - 15, rect.size.height - 1)
        titleLabel.textColor = textColor
        titleLabel.frame = titleRect
        self.addSubview(titleLabel)
    }
    
    private func drawDescription(rect:CGRect, textColor:UIColor, descriptionLabel:UILabel) {
        descriptionLabel.textColor = textColor
        descriptionLabel.frame = CGRectMake(rect.origin.x + 7, rect.origin.y, rect.width - 10, rect.height)
        self.addSubview(descriptionLabel)
    }
    
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = touches.first!.locationInView(self)
        for (index, section) in sections.enumerate() {
            if (section.bubbleRect.contains(point)) {
                points[index].touchUpInside?(point: points[index])
                break
            }
        }
    }
}

//
//  Glisten.swift
//  Glisten
//
//  Copyright (c) 2016 Comyar Zaheri. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


// MARK:- Imports

import UIKit


// MARK:- GlistenView

class GlistenView: UIView {
  
  var color: UIColor = UIColor.whiteColor()
  var lineWidth: CGFloat = 1.5
  var cornerRadius: CGFloat = 0.0
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    if cornerRadius > 0 {
      let context = UIGraphicsGetCurrentContext()
      let outer = UIBezierPath(roundedRect: rect, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
      CGContextAddPath(context, outer.CGPath)
      CGContextSetLineWidth(context, lineWidth)
      CGContextReplacePathWithStrokedPath(context)
      CGContextClip(context)
      let space = CGColorSpaceCreateDeviceRGB()
      let gradient = CGGradientCreateWithColors(space, [color.CGColor, color.colorWithAlphaComponent(0.0).CGColor], nil)
      let start = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect))
      let end = CGPointMake(CGRectGetMidX(rect), cornerRadius)
      CGContextDrawLinearGradient(context, gradient, start, end, .DrawsAfterEndLocation)
    } else {
      let context = UIGraphicsGetCurrentContext()
      color.setStroke()
      CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect))
      CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect))
      CGContextStrokePath(context)
    }
  }
}

/**
 Extension of UIView that allows for the additon of 'glisten'
 */
public extension UIView {
  
  /**
   Applies the default glisten to this view.
   */
  public func glisten() {
    glisten(cornerRadius: 0.0, lineWidth: 1.5, color: UIColor.whiteColor())
  }
  
  /**
   Applies a glisten with the given glisten to this view.
   - parameter cornerRadious: The corner radius of this view.
   - parameter lineWidth: The width of the line.
   - parameter color: The color of the line.
   */
  public func glisten(cornerRadius cornerRadius: CGFloat, lineWidth: CGFloat, color: UIColor) {
    let glisten = GlistenView(frame: frame)
    glisten.cornerRadius = cornerRadius
    glisten.color = color
    glisten.backgroundColor = UIColor.clearColor()
    glisten.userInteractionEnabled = false
    addSubview(glisten)
  }
}



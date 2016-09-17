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
  
  var color: UIColor = UIColor.white
  var lineWidth: CGFloat = 1.5
  var cornerRadius: CGFloat = 0.0
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    if cornerRadius > 0 {
      let context = UIGraphicsGetCurrentContext()
      let outer = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
      context?.addPath(outer.cgPath)
      context?.setLineWidth(lineWidth)
      context?.replacePathWithStrokedPath()
      context?.clip()
      let space = CGColorSpaceCreateDeviceRGB()
      let gradient = CGGradient(colorsSpace: space, colors: [color.cgColor, color.withAlphaComponent(0.0).cgColor] as CFArray, locations: nil)
      let start = CGPoint(x: rect.midX, y: rect.minY)
      let end = CGPoint(x: rect.midX, y: 1.25 * cornerRadius)
      context?.drawLinearGradient(gradient!, start: start, end: end, options: .drawsAfterEndLocation)
    } else {
      let context = UIGraphicsGetCurrentContext()
      color.setStroke()
      context?.move(to: CGPoint(x: rect.minX, y: rect.minY))
      context?.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
      context?.strokePath()
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
    glisten(cornerRadius: 0.0, lineWidth: 1.5, color: UIColor.white)
  }
  
  /**
   Applies a glisten with the given glisten to this view.
   - parameter cornerRadious: The corner radius of this view.
   - parameter lineWidth: The width of the line.
   - parameter color: The color of the line.
   */
  public func glisten(cornerRadius: CGFloat, lineWidth: CGFloat, color: UIColor) {
    let glisten = GlistenView(frame: frame)
    glisten.cornerRadius = cornerRadius
    glisten.color = color
    glisten.backgroundColor = UIColor.clear
    glisten.isUserInteractionEnabled = false
    addSubview(glisten)
  }
}



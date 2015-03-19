//
//  ProceduralLayer.swift
//  ProceduralKit
//
//  Created by Rachel Brindle on 3/17/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import QuartzCore

public class ProceduralLayer: CALayer {
    public func setColorsFromPerlinNoise(r: (x: CGFloat, y: CGFloat) -> (CGFloat),
                                         g: (x: CGFloat, y: CGFloat) -> (CGFloat),
                                         b: (x: CGFloat, y: CGFloat) -> (CGFloat)) {
        red = r
        green = g
        blue = b
        self.bounds = CGRectMake(0, 0, 1, 1)
        self.setNeedsDisplay()
    }

    public var red : (x: CGFloat, y: CGFloat) -> (CGFloat) = {(_, _) in 0}
    public var green : (x: CGFloat, y: CGFloat) -> (CGFloat) = {(_, _) in 0}
    public var blue : (x: CGFloat, y: CGFloat) -> (CGFloat) = {(_, _) in 0}

    public var maxWidth: CGFloat = 100
    public var maxHeight: CGFloat = 100

    override public func drawInContext(ctx: CGContext!) {
        super.drawInContext(ctx)
        let height = bounds.height
        let width = bounds.width

        let heightStep = height / maxWidth
        let widthStep = width / maxHeight

        let halfHeightStep = heightStep / 2
        let halfWidthStep = widthStep / 2

        for heightIndex in 0..<Int(maxHeight) {
            let h = CGFloat(heightIndex) * heightStep
            for widthIndex in 0..<Int(maxWidth) {
                let w = CGFloat(widthIndex) * widthStep
                let frame = CGRectMake(w, h, widthStep, heightStep)

                let x = w + halfWidthStep
                let y = h + halfHeightStep

                let r = red(x: x, y: y)
                let g = green(x: x, y: y)
                let b = blue(x: x, y: y)
                CGContextSetFillColorWithColor(ctx, CGColorCreateGenericRGB(r, g, b, 1.0))
                CGContextFillRect(ctx, frame)
            }
        }
    }
}

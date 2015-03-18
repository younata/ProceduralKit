//
//  ProceduralLayer.swift
//  ProceduralKit
//
//  Created by Rachel Brindle on 3/17/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import QuartzCore

public class ProceduralLayer: CALayer {
    public func setColorsFromPerlinNoise(r: PerlinNoise, g: PerlinNoise, b: PerlinNoise) {
        red.noise = {(x, y) in r.at(x * r.maxWidth, y * r.maxHeight) }
        green.noise = {(x, y) in g.at(x * g.maxWidth, y * g.maxHeight) }
        blue.noise = {(x, y) in b.at(x * b.maxWidth, y * b.maxHeight) }
        self.bounds = CGRectMake(0, 0, 1, 1)
        maxWidth = min(r.maxWidth, g.maxWidth, b.maxWidth)
        maxHeight = min(r.maxHeight, g.maxHeight, b.maxHeight)
        self.setNeedsDisplay()
    }

    public let red : FractalBrownianMotion = FractalBrownianMotion()
    public let green : FractalBrownianMotion = FractalBrownianMotion()
    public let blue : FractalBrownianMotion = FractalBrownianMotion()

    private var maxWidth: CGFloat = 1
    private var maxHeight: CGFloat = 1

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

                let r = red.at(x, y)
                let g = green.at(x, y)
                let b = blue.at(x, y)
                CGContextSetFillColorWithColor(ctx, CGColorCreateGenericRGB(r, g, b, 1.0))
                CGContextFillRect(ctx, frame)
            }
        }
    }
}

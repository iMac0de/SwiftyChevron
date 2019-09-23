//
//  Chevron.swift
//  SwiftyChevron
//
//  Created by Jérémy Peltier on 12/09/2019.
//  Copyright © 2019 Jérémy Peltier. All rights reserved.
//

import UIKit

@IBDesignable
public class Chevron: UIView {

    public enum Position: NSInteger {
        case up = 1
        case flat = 0
        case down = -1
    }

    private var leftSide: UIView!
    private var rightSide: UIView!
    private var currentPosition: Position!

    @IBInspectable public var width: CGFloat = 4.67 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable public var angle: CGFloat = 42.5714286 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable public var color: UIColor = .lightGray {
        didSet {
            if leftSide != nil {
                leftSide.backgroundColor = color
            }
            if rightSide != nil {
                rightSide.backgroundColor = color
            }
        }
    }


    @IBInspectable public var animationDuration: Double = 0.3

    public var position: Position = .up

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        sharedInit()
        layoutIfNeeded()
    }

    private func sharedInit() {
        isUserInteractionEnabled = false
    }

    public override func layoutIfNeeded() {
        super.layoutIfNeeded()

        if leftSide == nil {
            leftSide = UIView(frame: .zero)
            leftSide.backgroundColor = color
            addSubview(leftSide)
        }

        if rightSide == nil {
            rightSide = UIView(frame: .zero)
            rightSide.backgroundColor = color
            addSubview(rightSide)
        }

        let divided = bounds.divided(atDistance: bounds.size.width * 0.5, from: CGRectEdge.minXEdge)
        var leftSideFrame = divided.slice
        var rightSideFrame = divided.remainder
        leftSideFrame.size.height = self.width
        rightSideFrame.size.height = self.width

        let angle = bounds.size.height / bounds.size.width * self.angle
        let deltaX = leftSideFrame.size.width * (1 - cos(angle * CGFloat.pi / 180.0)) / 2.0

        leftSideFrame.offsetBy(dx: self.width / 2 + deltaX - 0.75, dy: 0.0)
        rightSideFrame.offsetBy(dx: (-1 * (self.width / 2)) - deltaX + 0.75, dy: 0.0)

        leftSide.bounds = leftSideFrame
        rightSide.bounds = rightSideFrame

        leftSide.center = CGPoint(x: leftSideFrame.midX + 2, y: bounds.midY)
        rightSide.center = CGPoint(x: rightSideFrame.midX - 2, y: bounds.midY)

        leftSide.layer.cornerRadius = self.width / 2
        rightSide.layer.cornerRadius = self.width / 2

        if position != .flat {
            setPosition(position, animated: false)
        }
    }

    public func setPosition(_ position: Position, animated: Bool) {
        if position == currentPosition {
            return
        }

        currentPosition = position

        let angle = bounds.size.height / bounds.size.width * self.angle

        var animation: (() -> Void) = {
            self.leftSide.transform = CGAffineTransform(rotationAngle: -CGFloat(position.rawValue) * angle * CGFloat.pi / 180.0)
            self.rightSide.transform = CGAffineTransform(rotationAngle: CGFloat(position.rawValue) * angle * CGFloat.pi / 180.0)
        }

        if !animated {
            UIView.performWithoutAnimation {
                animation()
            }
        } else {
            UIView.animate(withDuration: animationDuration) {
                animation()
            }
        }
    }

    public override func prepareForInterfaceBuilder() {
        sharedInit()
    }

}

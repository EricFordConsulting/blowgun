//
//  GameScene.swift
//  Blowgun
//
//  Created by Eric Ford on 11/22/15.
//  Copyright (c) 2015 Eric Ford Consulting. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView)
    {
        let backdrop = SKSpriteNode(imageNamed:"backdrop")
        backdrop.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        backdrop.xScale = 0.25
        backdrop.yScale = 0.25
        addChild(backdrop)

        let midground = SKSpriteNode(imageNamed:"midground")
        midground.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        midground.xScale = 0.25
        midground.yScale = 0.25
        addChild(midground)

        let protag = SKSpriteNode(imageNamed:"protag_standing")
        protag.position = CGPoint(x: 150, y: 270)
        protag.xScale = 0.25
        protag.yScale = 0.25
        addChild(protag)
        
        let blueBalloon = SKSpriteNode(imageNamed:"blueBalloon")
        blueBalloon.position = CGPoint(x: 800, y: 400)
        blueBalloon.xScale = 0.25
        blueBalloon.yScale = 0.25
        addChild(blueBalloon)
        
        let redBalloon = SKSpriteNode(imageNamed:"redBalloon")
        redBalloon.position = CGPoint(x: 600, y: 500)
        redBalloon.xScale = 0.25
        redBalloon.yScale = 0.25
        addChild(redBalloon)
        
        let yellowBalloon = SKSpriteNode(imageNamed:"yellowBalloon")
        yellowBalloon.position = CGPoint(x: 400, y: 300)
        yellowBalloon.xScale = 0.25
        yellowBalloon.yScale = 0.25
        addChild(yellowBalloon)
        
        let foreground = SKSpriteNode(imageNamed:"foreground")
        foreground.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        foreground.xScale = 0.25
        foreground.yScale = 0.25
        addChild(foreground)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

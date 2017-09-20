//
//  GameScene.swift
//  Blowgun
//
//  Created by Eric Ford on 11/22/15.
//  Copyright (c) 2015 Eric Ford Consulting. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let backdrop = SKSpriteNode(imageNamed:"backdrop")
    let midground = SKSpriteNode(imageNamed:"midground")
    let protag = SKSpriteNode(imageNamed:"protag_standing")
    let blueBalloon = SKSpriteNode(imageNamed:"blueBalloon")
    let redBalloon = SKSpriteNode(imageNamed:"redBalloon")
    let yellowBalloon = SKSpriteNode(imageNamed:"yellowBalloon")
    let projectileSprite = SKSpriteNode(imageNamed:"projectile1")
    let foreground = SKSpriteNode(imageNamed:"foreground")

    override func didMove(to view: SKView)
    {
        backdrop.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        backdrop.xScale = 0.25
        backdrop.yScale = 0.25
        addChild(backdrop)

        midground.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        midground.xScale = 0.25
        midground.yScale = 0.25
        addChild(midground)

        protag.position = CGPoint(x: 150, y: 270)
        protag.xScale = 0.25
        protag.yScale = 0.25
        addChild(protag)
        
        blueBalloon.position = CGPoint(x: 800, y: 400)
        blueBalloon.xScale = 0.25
        blueBalloon.yScale = 0.25
        addChild(blueBalloon)
        
        redBalloon.position = CGPoint(x: 600, y: 500)
        redBalloon.xScale = 0.25
        redBalloon.yScale = 0.25
        addChild(redBalloon)
        
        yellowBalloon.position = CGPoint(x: 400, y: 300)
        yellowBalloon.xScale = 0.25
        yellowBalloon.yScale = 0.25
        addChild(yellowBalloon)
        
        projectileSprite.position = CGPoint(x: 200, y: 300)
        projectileSprite.xScale = 0.25
        projectileSprite.yScale = 0.25
        projectileSprite.isHidden = true
        addChild(projectileSprite)
        
        foreground.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        foreground.xScale = 0.25
        foreground.yScale = 0.25
        addChild(foreground)
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        if appDelegate.firing
        {
            protag.texture = SKTexture(imageNamed: "protag_firing")
            projectileSprite.isHidden =  false
            //START ANIMATION WHERE ACCELEROMETER SETS ANGLE, appDelegate.projectileForce sets distance (or speed)
        }
        else
        {
            protag.texture = SKTexture(imageNamed: "protag_standing")
        }
    }
}

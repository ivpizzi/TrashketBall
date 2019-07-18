//
//  GameScene.swift
//  Trashket Ball
//
//  Created by Spence on 7/15/19.
//  Copyright © 2019 Hael. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene{
    
    var isInBin = false
    
    var scoreLabel: SKLabelNode!
    
    var score = 0
    {
        didSet
        {
            scoreLabel.text = "SCORE: \(score)"
        }
    }
    
    let sodaTexture = SKTexture(imageNamed: "soda")
    let wineBottleTexture = SKTexture(imageNamed: "winebottle")
    let newsTexture = SKTexture(imageNamed: "news")
    let hangerTexture = SKTexture(imageNamed: "hanger")
    let glassJarTexture = SKTexture(imageNamed: "glassJar")
    let boxTexture = SKTexture(imageNamed: "cardboard")
    let waterBottleTexture = SKTexture(imageNamed: "bottle")
    let bananaTexture = SKTexture(imageNamed: "banana")
    let appleCoreTexture = SKTexture(imageNamed: "appleCore")
    let plasticRingsTexture = SKTexture(imageNamed: "6Pack")
    
    let trashSprite = SKSpriteNode(imageNamed: "soda")
    
    let bioBin = SKSpriteNode(imageNamed: "brown-bin")
    let glassBin = SKSpriteNode(imageNamed: "glass-bin")
    let metalBin = SKSpriteNode(imageNamed: "metal-bin")
    let paperBin = SKSpriteNode(imageNamed: "paper-bin")
    let plasticBin = SKSpriteNode(imageNamed: "plastic-bin")
    
    
    let lives5Texture = SKTexture(imageNamed: "5Lives")
    let lives4Texture = SKTexture(imageNamed: "4Lives")
    let lives3Texture = SKTexture(imageNamed: "3Lives")
    let lives2Texture = SKTexture(imageNamed: "2Lives")
    let lives1Texture = SKTexture(imageNamed: "1Lives")
    
    var livesSprite = SKSpriteNode(imageNamed: "5Lives")
    var lives = 5
 

    
    
    override func didMove(to view: SKView)
    {
        setUpTrash()
        setUpBinSprites()
        createScore()
        createLives()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        throwTrash()
        checkTrash()
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        if trashSprite.position.y >= bioBin.position.y + trashSprite.size.height/2
        {
            isInBin = true
            setRandomTrash()
        }
        else
        {
            isInBin = false
        }
    }
    
    func createScore()
    {
        scoreLabel = SKLabelNode(fontNamed: "ArcadeClassic")
        scoreLabel.fontSize = 24
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 60)
        scoreLabel.text = "SCORE: 0"
        scoreLabel.fontColor = UIColor.black
        addChild(scoreLabel)
    }
    
    func incrementScore()
    {
        score+=1
    }
    
    func setUpTrash()
    {
        trashSprite.size = CGSize(width: 150, height: 150)
        let trashXPos = self.frame.minX + 50
        let trashYPos = self.frame.minY + 100
        trashSprite.zPosition = 5
        trashSprite.anchorPoint = CGPoint(x: trashSprite.frame.midX*1.5, y: trashSprite.frame.midY)
        trashSprite.position = CGPoint(x: trashXPos, y: trashYPos)
        addChild(trashSprite)
        setRandomTrash()
    }
    
    func moveTrash()
    {
        let trashXPos1 = self.frame.minX - 50
        let trashXPos2 = self.frame.maxX - 100
        let trashYPos = self.frame.minY + 100
        let trashMoveRight = SKAction.move(to: CGPoint(x: trashXPos2, y: trashYPos), duration: 2.0)
        let trashMoveLeft = SKAction.move(to: CGPoint(x: trashXPos1, y: trashYPos), duration: 2.0)
        let trashMoveArray = SKAction.sequence([trashMoveRight, trashMoveLeft])
        let trashMovement = SKAction.repeatForever(trashMoveArray)
        let trashWaitAndMove = SKAction.sequence([SKAction.wait(forDuration: 0.1), trashMovement])
        trashSprite.run(trashWaitAndMove)
    }
    
    func setUpBinSprites()
    {
        let binSprites = [bioBin, glassBin, metalBin, paperBin, plasticBin]
        
        for i in 0..<binSprites.count
        {
            binSprites[i].size = CGSize(width: 200, height: 200)
            let xPos = frame.width/5*CGFloat(i)
            binSprites[i].anchorPoint = CGPoint(x: binSprites[i].frame.midX, y: binSprites[i].frame.midY)
            binSprites[i].position = CGPoint(x: xPos - 65, y: frame.maxY - 400)
            binSprites[i].zPosition = 1
            addChild(binSprites[i])
        }
    }
    
    func throwTrash()
    {
        trashSprite.removeAllActions()
        
        let moveUp = SKAction.move(to: CGPoint(x: trashSprite.position.x, y: bioBin.position.y + 100), duration: 0.5)
        trashSprite.run(moveUp)
    }
    
    func checkTrash(){
        
        let xSize = CGFloat(metalBin.size.width/3)
        
        if(trashSprite.position.x >= metalBin.frame.minX && trashSprite.position.x <= metalBin.frame.minX + xSize)
        {
            print("touched metal bin")
            if(trashSprite.texture == hangerTexture || trashSprite.texture == sodaTexture)
            {
                incrementScore()

                //setRandomTrash()
            } else{
                decrementLives()
                
            }
            } else if (trashSprite.position.x >= bioBin.position.x + xSize && trashSprite.position.x <= bioBin.position.x + 2*xSize){
            
        }
        else if (trashSprite.position.x >= bioBin.frame.minX && trashSprite.position.x <= bioBin.frame.minX + xSize)
        {
            print("touched bio bin")
            if(trashSprite.texture == appleCoreTexture || trashSprite.texture == bananaTexture)
            {
                incrementScore()
                //setRandomTrash()
            }else{
                decrementLives()
                
            }
        }
            
        else if (trashSprite.position.x >= glassBin.position.x + xSize && trashSprite.position.x <= glassBin.position.x + 2*xSize){
            
        }
        else if (trashSprite.position.x >= glassBin.frame.minX && trashSprite.position.x <= glassBin.frame.minX + xSize)
        {
            print("touched glass bin")
            if(trashSprite.texture == glassJarTexture || trashSprite.texture == wineBottleTexture)
            {
                incrementScore()
                //setRandomTrash()
            }else{
                decrementLives()
                
            }
        }
            
        else if (trashSprite.position.x >= paperBin.position.x + xSize && trashSprite.position.x <= paperBin.position.x + 2*xSize){
            
        }
        else if (trashSprite.position.x >= paperBin.frame.minX && trashSprite.position.x <= paperBin.frame.minX + xSize)
        {
            print("touched paper bin")
            if(trashSprite.texture == boxTexture || trashSprite.texture == newsTexture)
            {
                incrementScore()
                //setRandomTrash()
            }else{
                decrementLives()}
        }
            
        else if (trashSprite.position.x >= plasticBin.position.x + xSize && trashSprite.position.x <= plasticBin.position.x + 2*xSize){
            
        }
        else if (trashSprite.position.x >= plasticBin.frame.minX && trashSprite.position.x <= plasticBin.frame.minX + xSize)
        {
            print("touched plastic bin")
            if(trashSprite.texture == waterBottleTexture || trashSprite.texture == plasticRingsTexture)
            {
                incrementScore()
                //setRandomTrash()
            }else{
                decrementLives()
                
            }
            
        }
        
    }
    

   
    func setRandomTrash()
    {
        trashSprite.position = CGPoint(x: frame.minX - 50, y: frame.minY + 100)
        
        let trashTextures = [sodaTexture, wineBottleTexture, newsTexture, hangerTexture, glassJarTexture, boxTexture, waterBottleTexture, bananaTexture, appleCoreTexture, plasticRingsTexture]
        let trashIndex = Int.random(in: 0..<trashTextures.count)
        trashSprite.texture = trashTextures[trashIndex]
        
        moveTrash()
    }
    
    func createLives(){
        livesSprite.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        livesSprite.position = CGPoint(x: frame.minX + 70
            , y: frame.maxY)
        livesSprite.size  = CGSize(width: 300, height: 250)
        addChild(livesSprite)
    }
    
    func decrementLives(){
        let livesTextures = [lives1Texture, lives2Texture, lives3Texture, lives4Texture, lives5Texture]
        lives -= 1
        livesSprite.texture = livesTextures[lives - 1]
       
    }


            

}

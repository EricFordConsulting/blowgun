//
//  GameViewController.swift
//  Blowgun
//
//  Created by Eric Ford on 11/22/15.
//  Copyright (c) 2015 Eric Ford Consulting. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import CoreAudio
class GameViewController: UIViewController
{
    var recorder: AVAudioRecorder!
    var levelTimer = Timer()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // when the view controller appears rotate it to landscape mode
        UIApplication.shared.setStatusBarOrientation(UIInterfaceOrientation.landscapeRight, animated: true)

        if let scene = GameScene(fileNamed:"GameScene") {
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            skView.ignoresSiblingOrder = false
            scene.scaleMode = .fill
            skView.presentScene(scene)
        }
        
        let session = AVAudioSession.sharedInstance()
        do
        {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        }
        catch let error as NSError
        {
            print("could not set session category")
            print(error.localizedDescription)
        }
        do
        {
            try session.setActive(true)
        }
        catch let error as NSError
        {
            print("could not make session active")
            print(error.localizedDescription)
        }

        let documents: AnyObject = NSSearchPathForDirectoriesInDomains( FileManager.SearchPathDirectory.documentDirectory,  FileManager.SearchPathDomainMask.userDomainMask, true)[0] as AnyObject
        let str =  documents.appendingPathComponent("recordTest.caf") as String
        let url = URL(fileURLWithPath: str as String)

        let recordSettings:[String : AnyObject] = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue as AnyObject,
            AVEncoderBitRateKey : 320000 as AnyObject,
            AVNumberOfChannelsKey: 2 as AnyObject,
            AVSampleRateKey : 44100.0 as AnyObject
        ]

        do
        {
            recorder = try AVAudioRecorder(url: url, settings: recordSettings)
            recorder.delegate = self
            recorder.isMeteringEnabled = true
            recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        }
        catch let error as NSError
        {
            recorder = nil
            print(error.localizedDescription)
        }

        recorder.record()            
        self.levelTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(GameViewController.levelTimerCallback), userInfo: nil, repeats: true)
    }

    @objc func levelTimerCallback()
    {
        //we have to update meters before we can get the metering values
        recorder.updateMeters()
        
        let force = recorder.averagePower(forChannel: 0)
        if force > -15
        {
            if force > appDelegate.projectileForce
            {
                appDelegate.projectileForce = force
            }
            appDelegate.firing = true
            /*print(recorder.averagePowerForChannel(0))
            print("")*/
        }
        else
        {
            appDelegate.firing = false
        }
    }
    
    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask
    {
        return UIInterfaceOrientationMask.landscapeRight
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}

// MARK: AVAudioRecorderDelegate
extension GameViewController : AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder,
        successfully flag: Bool) {
            print("finished recording \(flag)")
            
            // iOS8 and later
            let alert = UIAlertController(title: "Recorder",
                message: "Finished Recording",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Keep", style: .default, handler: {action in
                print("keep was tapped")
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: {action in
                print("delete was tapped")
                self.recorder.deleteRecording()
            }))
            self.present(alert, animated:true, completion:nil)
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder,
        error: Error?) {
            
            if let e = error {
                print("\(e.localizedDescription)")
            }
    }
    
}

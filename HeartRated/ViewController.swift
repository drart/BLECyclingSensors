//
//  ViewController.swift
//  HeartRated
//
//  Created by Adam Tindale on 2015-11-28.
//  Copyright (c) 2015 Adam Tindale. All rights reserved.
//

import Cocoa
import CoreBluetooth

class ViewController: NSViewController, CBCentralManagerDelegate, CBPeripheralDelegate {

    var centralManager : CBCentralManager!
    var powerMeter : CBPeripheral!
    var heartRateMonitor : CBPeripheral!
    var speedSensor : CBPeripheral!
    var cadenceSensor : CBPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        //[CBUUID(string:"180D")]
        //centralManager.scanForPeripheralsWithServices(nil, options: nil)
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    /*-----CentralManagerDelegate-----*/
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        if central.state == CBCentralManagerState.PoweredOn{
            centralManager.scanForPeripheralsWithServices(nil, options: nil)
            println("scanning");
        }else{
            print("ble is off")
        }
        
    }

    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        if peripheral.name != nil{
            println( peripheral.name )
        }else{
            println("wtf")
        }
        
        //[central .connectPeripheral(peripheral, options: nil)]
    }
    
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        println("did connect peripheral " + peripheral.name)
        peripheral.discoverServices(nil)
    }
 
    
    /*-----PeripheralDelegate-----*/

    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        for  service in peripheral.services!{
            let thisService = service as! CBService
            
            
            //if ([thisService.UUID isEqual:[CBUUID UUIDWithString:@"180D"]])
            if service.UUIDString == "180D"
            {
                println("heart rate service found")
                //[peripheral discoverCharacteristics:nil forService:aService];
            }
            
            
        }
    }
    
}


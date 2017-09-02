//
//  ResultsTableViewController.swift
//  eyeView
//
//  Created by Portia Sharma on 9/1/17.
//  Copyright © 2017 Portia Sharma. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController, ESTNearableManagerDelegate {

    var nearableManager = ESTNearableManager()
    var nearables = [ESTNearable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nearables = []
        nearableManager = ESTNearableManager()
        nearableManager.delegate = self
        nearableManager.startRanging(for: ESTNearableType.all)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func nearableManager(_ manager: ESTNearableManager, didRangeNearables nearables: [ESTNearable], with type: ESTNearableType) {
        self.nearables = nearables
        print(nearables)
        //        print(ESTNearableDefinitions.name(for: nearables[0].type as ESTNearableType))
        //print("Type: \(ESTNearableDefinitions.name(for: nearable.type)) RSSI: \(nearable.rssi)")
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nearables.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ESTTableViewCell
        
        let nearable = nearables[indexPath.row] as ESTNearable
        let windowName  = "\(ESTNearableDefinitions.name(for: nearable.type as ESTNearableType))"
        
        cell.textLabel?.text = "\(windowName.capitalized) : \(nearable.identifier)"
        cell.detailTextLabel?.text = "RSSI: \(nearable.rssi)"
        
        let imageView = UIImageView(frame: CGRect(x: self.view.frame.size.width - 60, y: 30, width: 30, height: 30))
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = self.imageForNearableType(type: nearable.type)
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    // MARK: - Utility methods
    
    func imageForNearableType(type: ESTNearableType) -> UIImage?
    {
        switch (type)
        {
        case ESTNearableType.bag:
            return  UIImage(named: "sticker_bag")
        case ESTNearableType.bike:
            return UIImage(named: "sticker_bike")
        case ESTNearableType.car:
            return UIImage(named: "sticker_car")
        case ESTNearableType.fridge:
            return UIImage(named: "sticker_fridge")
        case ESTNearableType.bed:
            return UIImage(named: "sticker_bed")
        case ESTNearableType.chair:
            return UIImage(named: "sticker_chair")
        case ESTNearableType.shoe:
            return UIImage(named: "sticker_shoe")
        case ESTNearableType.door:
            return UIImage(named: "sticker_door")
        case ESTNearableType.dog:
            return UIImage(named: "sticker_dog")
        default:
            return UIImage(named: "sticker_grey")
        }
    }
    

}


class ESTTableViewCell: UITableViewCell
{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

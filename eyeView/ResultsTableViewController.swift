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
    var nearablesSorted = [[ESTNearable]]()
    
    let sections = ["NEARBY (less than 2m)", "FAR AWAY (more than 2m)"]
    
    //initialize arrays, setup managers & delegates and start ranging
    override func viewDidLoad() {
        super.viewDidLoad()
        nearables = []
        nearablesSorted = [[],[]]
        nearableManager = ESTNearableManager()
        nearableManager.delegate = self
        nearableManager.startRanging(for: ESTNearableType.all)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //get and sort nearables; reload tableview
    func nearableManager(_ manager: ESTNearableManager, didRangeNearables nearables: [ESTNearable], with type: ESTNearableType) {
        self.nearables = nearables
        sortNearables(allNearables: nearables)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source and delegates

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return nearablesSorted[0].count
        case 1:
            return nearablesSorted[1].count
        default:
            return nearables.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ESTTableViewCell
        
        let nearable = nearablesSorted[indexPath.section][indexPath.row] as ESTNearable
        let nearableName  = "\(ESTNearableDefinitions.name(for: nearable.type as ESTNearableType))"
        
        cell.stickerTypeIDLabel.text = "\(nearableName.capitalized) (\(nearable.identifier))"
        cell.stickerStrengthLabel.text = "\(nearable.rssi)dB"
        cell.stickerImage.image = self.imageForNearableType(type: nearable.type as ESTNearableType)
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    // MARK: - Custom methods
    
    //choose nearable image for cell
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
            return UIImage(named: "sticker_blank")
        }
    }
    
    //sort nearables into near & far
    func sortNearables(allNearables: [ESTNearable]) {
        nearablesSorted = [[],[]]
        for nearable in nearables {
            if nearable.rssi >= -85 {
                nearablesSorted[0].append(nearable)
            }
            else {
                nearablesSorted[1].append(nearable)
            }
        }
    }
    
}


class ESTTableViewCell: UITableViewCell
{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBOutlet weak var stickerImage: UIImageView!
    @IBOutlet weak var stickerTypeIDLabel: UILabel!
    @IBOutlet weak var stickerStrengthLabel: UILabel!
}

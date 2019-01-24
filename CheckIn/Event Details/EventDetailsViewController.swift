//
//  EventDetails.swift
//  CheckIn
//
//  Created by Alexander Stevens on 12/12/18.
//  Copyright © 2018 Anand Kelkar. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    @IBOutlet weak var checkInCount: UILabel!
    @IBOutlet weak var guestCount: UILabel!
	
    override func viewDidLoad() {
		super.viewDidLoad();
		let coreData = CoreDataHelper.retrieveData("Checkins");
		updateCheckInCount(checkInData: coreData as! [Checkins]);
		updateGuestCount(checkInData: coreData as! [Checkins]);
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
	
	func updateCheckInCount(checkInData: [Checkins]) {
		//print(checkInData);
		checkInCount.text = String(checkInData.count);
		//TODO figure out why it checks in 2 students when you check in a student with guests
	}
	
	func updateGuestCount(checkInData: [Checkins]) {
		var totalGuests = Int16();
		for checkIns in checkInData {
			totalGuests += checkIns.guests;
		}
		guestCount.text = String(totalGuests);
	}
}

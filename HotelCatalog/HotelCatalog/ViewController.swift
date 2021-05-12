//
//  ViewController.swift
//  HotelCatalog
//
//  Created by Kirolos Agayby on 5/10/21.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var hotelName: UILabel!
    @IBOutlet var roomsTextbox: UITextField!
    @IBOutlet var dropDown: UIPickerView!
    
    @IBOutlet var rightArrow: UIImageView!
    @IBOutlet var leftArrow: UIImageView!
    
    @IBOutlet var nameUser: UITextField!
    @IBOutlet var pNumber: UITextField!
    @IBOutlet var rooms: UITextField!
    @IBOutlet var adults: UITextField!
    @IBOutlet var childrenInput: UITextField!
    @IBOutlet var fromDate: UIDatePicker!
    @IBOutlet var toDate: UIDatePicker!
    var roomsList = ["1", "2", "3", "4", "5", "6", "7+"]
    var userDict = [String:Any]()
    var userArray = [Any]()
    
    var nameUserx: String = ""
    var pNumberx: String = ""
    var roomsx: String = ""
    var adultsx: String = ""
    var childrenInputx: String = ""
    var fromDatex: String = ""
    var toDatex: String = ""
    var hotelSelectedx: String = ""
    var data: [(nameUser: String, pNumber: String, rooms: String, adults: String, childrenInput: String, fromDate: String, toDate: String, hotelSelected: String)] = []
    @IBAction func reserveButton(_ sender: Any) {
        userDict.updateValue(nameUser.text!, forKey: "nameUser")
        userDict.updateValue(pNumber.text!, forKey: "pNumber")
        userDict.updateValue(rooms.text!, forKey: "rooms")
        userDict.updateValue(adults.text!, forKey: "adults")
        userDict.updateValue(childrenInput.text!, forKey: "childrenInput")
        let defaults = UserDefaults.standard
        /*reservations.set(nameUser.text, forKey: "nameUser")
        reservations.set(pNumber.text, forKey: "pNumber")
        reservations.set(rooms.text, forKey: "rooms")
        reservations.set(adults.text, forKey: "adults")
        reservations.set(childrenInput.text, forKey: "childrenInput")*/
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = NSTimeZone.local as TimeZone?
        let convertedFromDate = dateFormatter.string(from: fromDate.date)
        let convertedToDate = dateFormatter.string(from: toDate.date)
        /*reservations.set(convertedFromDate, forKey: "fromDate")
        reservations.set(convertedToDate, forKey: "toDate")
        var array = [nameUser: "Name", pNumber: "18283", rooms: "2"]
        reservations.set(array, forKey: "reservations")*/
        
        userDict.updateValue(convertedFromDate, forKey: "fromDate")
        userDict.updateValue(convertedToDate, forKey: "toDate")
        let hotelSelected = currentHotel()
        userDict.updateValue(hotelSelected, forKey: "hotelSelected")
        userArray.append(userDict)
        let alert = UIAlertController(title: "Reservation saved", message: "Your reservation was saved.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        defaults.set(userArray, forKey: "reservations")
        
        nameUserx = String(nameUser.text!)
        pNumberx = String(pNumber.text!)
        roomsx = String(rooms.text!)
        adultsx = String(adults.text!)
        childrenInputx = String(childrenInput.text!)
        fromDatex = String(convertedFromDate)
        toDatex = String(convertedToDate)
        hotelSelectedx = String(hotelSelected)
        let table = ReservationsViewController();
        data.append((nameUser: nameUserx, pNumber: pNumberx, rooms: roomsx, adults: adultsx, childrenInput: childrenInputx, fromDate: fromDatex, toDate: toDatex, hotelSelected: hotelSelectedx))
        //print(table.data)
        //print(userArray)
        
    }
    var images: [String] = ["Hotel-Tips", "FIH_Homepage_HotelView-1-1920x1080.jpg", "Bellagio-Hotel-Casino-Las-Vegas", "baglioni-hotel-london", "PVDDTN-2880x1870.jpg", "hotel-presidente-4s", "pool-for-google-blog", "jqg_1557420223"]
    var hotel_Name: [String] = ["hotel1", "hotel2", "hotel3", "4", "5", "6", "7", "8"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

    override func viewDidLoad() {
            super.viewDidLoad()
            
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.isPagingEnabled = true
        for index in 0..<images.count {
                    frame.origin.x = scrollView.frame.size.width * CGFloat(index)
                    frame.size = scrollView.frame.size
            let imageView = UIImageView(frame: frame)
                        imageView.image = UIImage(named: images[index])
                        self.scrollView.addSubview(imageView)
                    }
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count), height: scrollView.frame.size.height)
                scrollView.delegate = self
        if (scrollView.contentOffset.x/scrollView.bounds.size.width == 0.0){
            leftArrow.isHidden = true
        }
        hotelName.text = "Regency Palace"
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if (scrollView.contentOffset.x >= (scrollView.contentSize.width - scrollView.frame.size.width)) {
            rightArrow.isHidden = true
        }
        
        if (scrollView.contentOffset.x/scrollView.bounds.size.width == 0.0){
            leftArrow.isHidden = true
        }
        if (scrollView.contentOffset.x/scrollView.bounds.size.width > 0.0){
            leftArrow.isHidden = false
        }

        if (scrollView.contentOffset.x >= 0 && scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.frame.size.width)){
            rightArrow.isHidden = false
        }
        switch (scrollView.contentOffset.x/scrollView.bounds.size.width) {
        case 0:
            hotelName.text = "Regency Palace"
        case 1:
            hotelName.text = "Flares Reservation"
        case 2:
            hotelName.text = "The New View"
        case 3:
            hotelName.text = "Sunset Bliss"
        case 4:
            hotelName.text = "Four Seasons"
        case 5:
            hotelName.text = "Golden Suites"
        case 6:
            hotelName.text = "Relax Hotel"
        case 7:
            hotelName.text = "Fresco Inn"
        case 8:
            hotelName.text = "Ramada Reservations"
            
        default:
            hotelName.text = "..."
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
            return 1
        }

        public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{

            return roomsList.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

            self.view.endEditing(true)
            return roomsList[row]
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

            self.roomsTextbox.text = self.roomsList[row]
            self.dropDown.isHidden = true
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {

            if textField == self.roomsTextbox {
                self.dropDown.isHidden = false
                //if you don't want the users to se the keyboard type:

                textField.endEditing(true)
            }
        }
    func currentHotel() -> String{
        switch (scrollView.contentOffset.x/scrollView.bounds.size.width) {
        case 0:
            return "Regency Palace"
        case 1:
            return "Flares Reservation"
        case 2:
            return "The New View"
        case 3:
            return "Sunset Bliss"
        case 4:
            return "Four Seasons"
        case 5:
            return "Golden Suites"
        case 6:
            return "Relax Hotel"
        case 7:
            return "Fresco Inn"
        case 8:
            return "Ramada Reservations"
            
        default:
            return "error"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ReservationsViewController {
            let vc = segue.destination as? ReservationsViewController
            if (nameUserx != ""){
            vc?.nameUser = nameUserx
            vc?.pNumber = pNumberx
            vc?.rooms = roomsx
            vc?.adults = adultsx
            vc?.childrenInput = childrenInputx
            vc?.fromDate = fromDatex
            vc?.toDate = toDatex
                vc?.hotelSelected = hotelSelectedx
                
            }
            vc?.data = data
            /*vc?.data.append((nameUser: nameUserx, pNumber: pNumberx, rooms: roomsx, adults: adultsx, childrenInput: childrenInputx, fromDate: fromDatex, toDate: toDatex, hotelSelected: hotelSelectedx))*/
            
        }
        /*if segue.identifier == "reserv" {
            let reservationViewController = segue.destination as!
                      ReservationsViewController
            reservationViewController.data.append((nameUser: nameUserx, pNumber: pNumberx, rooms: roomsx, adults: adultsx, childrenInput: childrenInputx, fromDate: fromDatex, toDate: toDatex, hotelSelected: hotelSelectedx))
        }*/
    }
}


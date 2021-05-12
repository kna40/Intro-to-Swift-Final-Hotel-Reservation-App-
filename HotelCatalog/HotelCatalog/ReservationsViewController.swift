//
//  ReservationsViewController.swift
//  HotelCatalog
//
//  Created by Kirolos Agayby on 5/11/21.
//

import UIKit

class ReservationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet var reservationsTable: UITableView!
    var nameUser: String = ""
    var pNumber: String = ""
    var rooms: String = ""
    var adults: String = ""
    var childrenInput: String = ""
    var fromDate: String = ""
    var toDate: String = ""
    var hotelSelected: String = ""
    var data: [(nameUser: String, pNumber: String, rooms: String, adults: String, childrenInput: String, fromDate: String, toDate: String, hotelSelected: String)] = []
    var arr = [Any]()
    var array: [String: String] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reservationsTable.delegate = self
        reservationsTable.dataSource = self
        
        //print(data)
        
        //data.append(reservations!)
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let reservations: [[String : String]] = (defaults.object(forKey: "reservations") as? [[String : String]])!
        //print(reservations)
            /*data.append((nameUser: nameUser, pNumber: nameUser, rooms: rooms, adults: adults, childrenInput: childrenInput, fromDate: fromDate, toDate: toDate, hotelSelected: hotelSelected))*/
        reservationsTable.reloadData()
        print(data)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Reserved: " + data[indexPath.row].hotelSelected
        cell.detailTextLabel?.text = data[indexPath.row].nameUser + " for " + data[indexPath.row].rooms + " rooms " + " on " + data[indexPath.row].fromDate + " to " + data[indexPath.row].toDate + " with " + data[indexPath.row].adults + " adults and " + data[indexPath.row].childrenInput
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

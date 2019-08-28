//
//  ViewController.swift
//  BitCoin-Ticker
//
//  Created by Bharat Khatke on 24/08/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalURL = ""
    var selectedCurrency: String = ""
    var currencySymbol: String = ""
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- {Picket view Delegate And datasource methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedCurrency = currencyArray[row]
        currencySymbol   = currencySymbolArray[row]
        getPriceOfSelectedCurrency(currency: selectedCurrency)
        print(row)
    }
    
    //MARK:- Call Networking call here
    
    func getPriceOfSelectedCurrency(currency: String)  {
        finalURL = baseURL + currency
        
        AF.request(finalURL, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let dataJSON: JSON = JSON(value)
                print(dataJSON)
                self.updateBitcoinData(bitCoinJSON: dataJSON)
                
            case .failure(let error):
                print(error.localizedDescription)
        }
     }
    }
    
    
    //MARK:- set UI Updation
    
    func updateBitcoinData(bitCoinJSON: JSON)  {
        
        let bidValue = bitCoinJSON["bid"].double ?? 0
        priceLbl.text = "\(currencySymbol)\(bidValue)"
    }
    


}


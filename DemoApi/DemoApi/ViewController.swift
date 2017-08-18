//
//  ViewController.swift
//  DemoApi
//
//  Created by Deepak Tomar on 17/08/17.
//  Copyright © 2017 Deepak Tomar. All rights reserved.
//

import UIKit
import Alamofire



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // with soap api call
        let url = "http://139.59.27.120:8080/register/" // put here url
        let params = "name=Jafar2%20Naqvi2&password=jafarnaqvi2&phone=84312406882&email=jafar9122%40gmail.com" // put here parameter
        
        var xmlRequest = URLRequest(url: NSURL(string: url)! as URL) // create url request
        xmlRequest.httpBody = params.data(using: String.Encoding.utf8, allowLossyConversion: true) // set boday with parameter
        xmlRequest.httpMethod = "POST" // set here method type
        xmlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type") // set here content type
        
        Alamofire.request(xmlRequest as URLRequestConvertible).responseData{ response in
            print(response.result.value as Any) //get response in bytes form
            
            if let string = String(data: (response.result.value!), encoding: .utf8) // convert bytes to string from
            {
                print(string) // print response string
                if let data = string.data(using: .utf8) // string to convert data
                {
                    do {
                        let dic =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] // convert data to json dictionary
                        print(dic ?? "string")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } else {
                print("not a valid UTF-8 sequence")
            }
          
        }


        
        // with rest client api call
        let webUrl:String = "http://kinbow.cladev.com:81/api/v1.0/useractivity/" // put here own URL
        let parameter = ["username":"vrohilla@clavax.us1","password":"Kinbow20","op":"login"] // put here parameter
        
        Alamofire.request(webUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! , method: .post, parameters: parameter).responseJSON { (response) in
            print(response.result)// get result
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




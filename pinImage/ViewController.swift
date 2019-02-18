//
//  ViewController.swift
//  pinImage
//
//  Created by Nikhil on 1/14/19.
//  Copyright © 2019 Nikhil. All rights reserved.
//

import UIKit
import FetchFileLib
class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource
{
    
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var table: UITableView!
    var jsonDict: NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
    
        table.dataSource = self
        table.delegate = self
       // maxlimit = 50 // configure max capacity of fetch file library
        
        let downloader = downloadAsyncController() //to download json
        downloader.getFileForURL(urlString: "http://pastebin.com/raw/wgkJgazE") { (data) in
            var error: NSError?
           // let jsonData: NSData = /* get your json data */
            do{
                self.jsonDict = try JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSArray
                 DispatchQueue.main.async {
                    self.table.reloadData()

                }
            }catch
            {}
           // (data as! Data, options: nil) as NSDictionary

        }
        
      //  self.UpdateUI()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:dataContainerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "dataContainerTableViewCell", for: indexPath) as! dataContainerTableViewCell
        cell.containerLabel.text = "\(indexPath.row)"
        cell.tag = indexPath.row        //to handle safelly in cell reuse case
        let dict = jsonDict[indexPath.row] as! NSDictionary
        let url = dict["urls"] as! NSDictionary
        cell.containerImage.image = nil
        let downloader = downloadAsyncController()

        
            cell.viewWithTag(707)?.removeFromSuperview()    //check optionl to check if already exist
        
        
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
 
        spinner.frame = CGRect(x: 50, y: 50, width: cell.frame.width / 2, height: cell.frame.height / 2)
        spinner.tag = 707
        cell.addSubview(spinner)    //spinner while waiting
        
        //start image downloading 
         downloader.getFileForURL(urlString: url["full"] as! String) { (data) in
            DispatchQueue.main.async {
                 UIView.transition(with: cell, duration: 0.2, options: .transitionCrossDissolve, animations: {
                    let imgData = data as? Data
                    if (imgData != nil)
                    {
                        if(cell.tag == indexPath.row)
                        {
                            cell.containerImage.image =  UIImage(data: imgData! ) //convert data into image and assign
                        }
                        
                    }


                 }, completion: {
                    finished in

                })
                spinner.stopAnimating()
                spinner.removeFromSuperview()
            }
        }

        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 300.0;//Choose your custom row height
    }

    func UpdateUI(){
        let downloader = downloadAsyncController()

        downloader.getFileForURL(urlString: "https://tineye.com/images/widgets/mona.jpg") { (data) in
            //data is value return by test function
            DispatchQueue.main.async {
                // Update UI
                //do task what you want.
                // run on the main queue, after the previous code in outer block
               // self.img.image = UIImage(cgImage: data  as! CGImage)
                self.img.image = UIImage(data: data as! Data)

            }
        }
    }
   
}


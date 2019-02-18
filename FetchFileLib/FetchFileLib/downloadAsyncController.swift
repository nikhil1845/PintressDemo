//
//  downloadAsyncController.swift
//  pinImage
//
//  Created by Nikhil on 1/14/19.
//  Copyright © 2019 Nikhil. All rights reserved.
//

import UIKit

public struct File {
    var URL: String
    var COUNT: Int
    var DATA: AnyObject
}
var buffer = [File]()   //
public var maxlimit = 10
public class downloadAsyncController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    public func getFileForURL(urlString: String,returnCompletion: @escaping (AnyObject) -> () )  {
        for file in buffer {
            if(file.URL == urlString)
            {
                print("Found In buffer ,Do not download")
                returnCompletion(file.DATA) //return if already exist in buffer
            }
        }
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            
            
            DispatchQueue.global(qos: .background).async {
                // start downloading for new file
                let data = try? Data(contentsOf: URL(string: urlString)!)
                // convert the data in you formate. here i am using anyobject.
                returnCompletion(data as AnyObject)
                self.appendToBuffer(urlString: urlString, data: data as AnyObject)//append to buffer new entry
            }
            
            
        }).resume()
        
    }
    public func appendToBuffer(urlString: String,data: AnyObject)
    {
        //append to buffer if not already axist there
        if(buffer.count > maxlimit)
        {
            var leastused = Int.max
            var fileToberemoved = File(URL: "", COUNT: 0, DATA: "" as AnyObject)
            for file in buffer {
                if(file.COUNT < leastused)
                {
                    leastused = file.COUNT
                    fileToberemoved = file
                }
            }
            
            buffer.remove(at:buffer.index(where: { $0.URL == fileToberemoved.URL })!)
        }
        var file = File(URL: urlString, COUNT: 0, DATA: data)

        if((buffer.index(where: { $0.URL == file.URL })) != nil)
        {
            file.COUNT = file.COUNT + 1

        }else
        {
            buffer.append(file)
        }
//        for var file in buffer {
//            if(file.URL == urlString)
//            {
//                file.DATA = data
//                file.COUNT = file.COUNT + 1
//            }
//        }
       
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

//
//  JSONViewer.swift
//  SwiftUI-PersistingData-01
//
//  Created by Mike Panitz on 5/1/21.
//






// / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
// WARNING: THIS CODE DOESN'T ACTUALLY WORK YET
// / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
import SwiftUI
import SwiftyJSON

struct JSONViewer: View {
    
    func getJSONData() -> JSON? {
        let jsonString = """
            {
               "metadata":{
                  "responseInfo":{
                     "status":200,
                     "developerMessage":"OK",
                  }
               }
            }
    """
        var jsonData: JSON?
        if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
            jsonData = JSON(dataFromString)
        }
        return jsonData
    }
    
    
    var body: some View {
        
        if let jsonData = getJSONData() {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                
                if let textToShow = jsonData["metadata"]["responseInfo"]["developerMessage"].string {
                    Text(textToShow)
                }
            }
        } else {
            Text("Error loading Data")
        }
    }
}

struct JSONViewer_Previews: PreviewProvider {
    static var previews: some View {
        JSONViewer()
    }
}

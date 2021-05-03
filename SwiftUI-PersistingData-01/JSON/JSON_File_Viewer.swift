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

struct JSON_File_Viewer: View {
    
    let dataFileName = "AppData.json"
    
    func saveData(filename: String) {
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
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent(filename)
            do {
                let path = pathWithFilename.absoluteString
                print("Path:")
                print(path)
                
                try jsonString.write(to: pathWithFilename,
                                     atomically: true,
                                     encoding: .utf8)
            } catch {
                // Handle error
                print("error!")
            }
        }
    }
    
    func loadData(filename: String) -> JSON? {
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent(filename)
            do {
                let path = pathWithFilename.absoluteString
                print("Path:")
                print(path)
                let jsonString = try String(contentsOfFile: pathWithFilename.absoluteString)
                if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
                    return JSON(dataFromString)
                }
            } catch  {
                // Handle error
                print("error!")
                // print(errorDescription)
            }
        }
        return nil
    }
    
    @State private var display:String = ""
    
    var body: some View {
        
        VStack {
            Text("JSON File Example")
            HStack{
                Button("Load", action: {
                    display="Error loading Data"
                    if let jsonData = loadData(filename: dataFileName) {
                        display="Loaded file"
                            if let textToShow = jsonData["metadata"]["responseInfo"]["developerMessage"].string {
                                display=textToShow
                        }
                    }
                })
                Spacer()
                Button("Save", action: {
                    saveData(filename: dataFileName)
                })
            }
            
            Text(self.display)
        } .padding()
    }
}

struct JSON_File_Viewer_Previews: PreviewProvider {
    static var previews: some View {
        JSON_File_Viewer()
    }
}

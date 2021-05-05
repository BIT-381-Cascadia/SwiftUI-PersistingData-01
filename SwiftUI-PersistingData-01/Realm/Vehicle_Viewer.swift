//
//  Vehicle_Viewer.swift
//  SwiftUI-PersistingData-01
//
//  Created by Student Account on 5/5/21.
//

import Foundation
import SwiftUI
import RealmSwift

struct Vehicle_Viewer: View {
    
    @State private var VehicleResults: Results<Vehicle>
    
    init() {
        let tr = try! Realm()
        VehicleResults = tr.objects(Vehicle.self)
    }
    
    func saveData() {
        let newCar = Vehicle()
        newCar.type = "Mazda"
        newCar.year = 2015
        
        let newCar2 = Vehicle()
        newCar2.type = "Ford"
        newCar2.year = 2052
        
        let CarRealm = try! Realm()
        
        try! CarRealm.write {
            CarRealm.add(newCar)
            CarRealm.add(newCar2)
        }
    }
    
    func loadData() -> Results<Vehicle> {
      
        let realm = try! Realm()
        let allVehicles = realm.objects(Vehicle.self)
        print(allVehicles.count)
        return allVehicles
    }
    
    //@State private var display:String = ""
    
    var body: some View {
        VStack {
            Text("Realm Example")
            HStack{
                Button("Load", action: {
                    VehicleResults = loadData()
                })
                Spacer()
                Button("Save", action: {
                    saveData()
                    VehicleResults = loadData()
                })
            }
            
          ForEach(self.VehicleResults.map(Vehicle.init), id: \.self) {
                aVehicle in
                Text(aVehicle.type)
            }

        } .padding()
    }
}



struct Vehicle_Viewer_Previews: PreviewProvider {
    static var previews: some View {
        Vehicle_Viewer()
    }
}

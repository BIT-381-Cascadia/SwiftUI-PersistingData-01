//
//  Realm_Viewer.swift
//  SwiftUI-PersistingData-01
//
//  Created by Mike Panitz on 5/1/21.
//

import SwiftUI
import RealmSwift

struct Realm_Viewer: View {
    init() {
        let tr = TestRealm()
        tr.RunTest()
    }

    func saveData() {
        let fido = Dog()
        fido.name = "Fido"
        fido.age = 3
        
        let rex = Dog()
        rex.name="Rex"
        rex.age=4
        
        let protagonist = Person()
        protagonist.name = "???"
        protagonist.dogs.append(fido)
        protagonist.dogs.append(rex)
        
        // setDefaultRealmForUser(filename: "filename_for_other_db_goes_here") // optionally use this to switch to a different Realm DB
        let realm = try! Realm()
        
        let people = realm.objects(Person.self)
        protagonist.name = "Person #" + String(people.count + 1)
        try! realm.write {
            realm.add(protagonist)
        }
    }
    
    func loadData() -> Person? {
      
        let realm = try! Realm()
        let people = realm.objects(Person.self)
        print(people.count)
        
        return people[people.count-1]
    }
    
    @State private var display:String = ""
    
    var body: some View {
        VStack {
            Text("Realm Example")
            HStack{
                Button("Load", action: {
                    display="Error loading Data"
                    if let thePerson = loadData() {
                        display=thePerson.name
                    }
                })
                Spacer()
                Button("Save", action: {
                    saveData()
                })
            }
            
            Text(self.display)
        } .padding()
    }
}

struct Realm_Viewer_Previews: PreviewProvider {
    static var previews: some View {
        Realm_Viewer()
    }
}

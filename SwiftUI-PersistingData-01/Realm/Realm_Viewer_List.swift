//
//  Realm_Viewer.swift
//  SwiftUI-PersistingData-01
//
//  Created by Mike Panitz on 5/1/21.
//

import SwiftUI
import RealmSwift

struct Realm_Viewer_List: View {
    
//    @State private var peopleResults: Results<Person>
//
//    init() {
//        let realm = try! Realm()
//        peopleResults = realm.objects(Person.self)
//    }
//
//    func saveData() {
//        let fido = Dog()
//        fido.name = "Fido"
//        fido.age = 3
//
//        let rex = Dog()
//        rex.name="Rex"
//        rex.age=4
//
//        let protagonist = Person()
//        protagonist.name = "???"
//        protagonist.dogs.append(fido)
//        protagonist.dogs.append(rex)
//
//        let realm = try! Realm()
//
//        let people = realm.objects(Person.self)
//        protagonist.name = "Person #" + String(people.count + 1)
//        try! realm.write {
//            realm.add(protagonist)
//        }
//    }
//
//    func loadData() -> Results<Person> {
//
//        let realm = try! Realm()
//        let allPeeps = realm.objects(Person.self)
//        print(allPeeps.count)
//        return allPeeps
//    }
//
    var body: some View {
        VStack {
            Text("Realm Example")
//            HStack{
//                Button("Load", action: {
//                    peopleResults = loadData()
//                })
//                Spacer()
//                Button("Save", action: {
//                    saveData()
//                    peopleResults = loadData()
//                })
//            }
//            
//            ForEach(self.peopleResults.map(Person.init), id: \.self) { aPerson in
//                Text(aPerson.name)
//            }
            
        } .padding()
    }
}

struct Realm_Viewer_List_Previews: PreviewProvider {
    static var previews: some View {
        Realm_Viewer_List()
    }
}

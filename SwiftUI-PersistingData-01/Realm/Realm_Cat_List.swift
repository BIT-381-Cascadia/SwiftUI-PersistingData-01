//
//  Realm_Cat_List.swift
//  SwiftUI-PersistingData-01
//
//  Created by Student Account on 5/5/21.
//

import SwiftUI
import RealmSwift

struct Realm_Cat_List: View {
    
    @State private var peopleResults: Results<Person2>

    init() {
        let realm = try! Realm()
        peopleResults = realm.objects(Person2.self)
    }

    func saveData() {
        let jeff = Cat()
        jeff.name = "Jeff"
        jeff.age = 4

        let steve = Cat()
        steve.name="Steve"
        steve.age=6

        let protagonist = Person2()
        protagonist.name = "???"
        protagonist.cats.append(jeff)
        protagonist.cats.append(steve)

        let realm = try! Realm()

        let people = realm.objects(Person2.self)
        protagonist.name = "Cat #" + String(people.count + 1)
        try! realm.write {
            realm.add(protagonist)
        }
    }

    func loadData() -> Results<Person2> {

        let realm = try! Realm()
        let allPeeps = realm.objects(Person2.self)
        print(allPeeps.count)
        return allPeeps
    }

    var body: some View {
        VStack {
            Text("Realm Example")
            HStack{
                Button("Load", action: {
                    peopleResults = loadData()
                })
                Spacer()
                Button("Save", action: {
                    saveData()
                    peopleResults = loadData()
                })
            }
            
            ForEach(self.peopleResults.map(Person2.init), id: \.self) { aPerson in
                Text(aPerson.name)
            }
            
        } .padding()
    }
}

struct Realm_Cat_List_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Realm_Cat_List()
        }
    }
}


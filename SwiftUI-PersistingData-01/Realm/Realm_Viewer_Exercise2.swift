//
//  Realm_Viewer_Exercise2.swift
//  SwiftUI-PersistingData-01
//
//  Created by Natalman Nahm on 5/5/21.
//

import SwiftUI
import RealmSwift

struct Realm_Viewer_Exercise2: View {
    
    @State private var catResults: Results<Cat>
    
    init(){
        let realm = try! Realm()
        catResults = realm.objects(Cat.self)
    }
    
    func saveData(){
        let catPo = Cat()
        catPo.name = "???"
        catPo.age = 4
        catPo.sex = "Male"
        
        
        
        setDefaultRealmForUser(filename: "kitty")
        
        
        let realm = try! Realm()
        let ct = realm.objects(Cat.self)
        catPo.name = "Cat #" + String(ct.count + 1)
        
        try! realm.write{
            realm.add(catPo)
        }
        
    }
    
    func loadData() -> Results<Cat>{
        
        let realm = try! Realm()
        let cats = realm.objects(Cat.self)
        print(cats.count)
        return cats
    }
    
    @State private var displayName:String = ""
    
    var body: some View {
        
        ScrollView{
            VStack{
                Text("Exercise 1")
                
                HStack{
                    Button("Load", action: {
                        catResults = loadData()
                        
                    })
                    Spacer()
                    Button("Save", action:{
                        saveData()
                        catResults = loadData()
                    })
                }
                
                ForEach(self.catResults.map(Cat.init), id: \.self) { aCat in
                    Text(aCat.name)
                }
                
                
                Text(self.displayName)
            }.padding()
        }
        
    }
}

struct Realm_Viewer_Exercise2_Previews: PreviewProvider {
    static var previews: some View {
        Realm_Viewer_Exercise2()
    }
}

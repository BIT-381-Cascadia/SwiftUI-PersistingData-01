//
//  Realm_viewer_Exercise.swift
//  SwiftUI-PersistingData-01
//
//  Created by Natalman Nahm on 5/5/21.
//

import SwiftUI
import RealmSwift

struct Realm_viewer_Exercise: View {
    
    init() {
        let realm = TestRealm()
        realm.RunTest()
    }
    
    func saveData(){
//        let kitty1 = Cat()
//        kitty1.name = "Meow"
//        kitty1.age = 5
//        kitty1.sex = "Male"
//        
//        let kitty2 = Cat()
//        kitty2.name = "Aww"
//        kitty2.age = 4
//        kitty2.sex = "Female"
        
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
    
    func loadData() -> Cat? {
        
        let realm = try! Realm()
        let cats = realm.objects(Cat.self)
        print(cats.count)
        return cats[cats.count-1]
        
    }
    @State private var displayName:String = ""
    @State private var displayAge:String = ""
    @State private var displaySex:String = ""
    var body: some View {
        
        VStack{
            Text("Exercise 1")
            
            HStack{
                Button("Load", action: {
                    displayName = "Error Message"
                    displayAge = "Error Message"
                    displaySex = "Error Message"
                    if let kitty = loadData(){
                        displayName = "Name: " + kitty.name
                        displayAge = "Age: "  + String(kitty.age)
                        displaySex = "Sex: " + kitty.sex
                    }
                    
                })
                Spacer()
                Button("Save", action:{
                    saveData()
                })
            }
            
            Text(self.displayName)
            Text(self.displayAge)
            Text(self.displaySex)
        }.padding()
        
    }
}

struct Realm_viewer_Exercise_Previews: PreviewProvider {
    static var previews: some View {
        Realm_viewer_Exercise()
    }
}

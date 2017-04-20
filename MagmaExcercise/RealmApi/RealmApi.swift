//
//  RealmApi.swift
//  KokonutTemplate
//
//  Created by Aldo Bonilla on 24/08/16.
//  Copyright © 2016 Aldo Bonilla. All rights reserved.
//  Para usar esta clase en futuros proyectos los primeros metodos no cambian apartir de getPokemon ya debemos ir sustituyendo por nuestros objetos del proyecto

import Foundation
import RealmSwift

protocol RealmSubscriber {
    
    var id: Int { get set }
    func createRealmEntity() -> Object
}

class RealmApi {
    
    static let sharedInstance = RealmApi()
    
    let realm = try! Realm()
    
    ///writes an entity in the realm default
    func writeEntity(_ entity: Object) {
        try! realm.write {
            realm.add(entity, update: true)
        }
    }
    
    ///deletes an entity from realm default
    func deleteEntity(_ entity: Object) {
        try! realm.write {
            realm.delete(entity)
        }
    }
    
    ///deletes all entities realm
    func deleteAll() {
        try! realm.write({
            realm.deleteAll()
        })
    }
}

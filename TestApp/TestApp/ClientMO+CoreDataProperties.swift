//
//  ClientMO+CoreDataProperties.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 03.02.2023.
//
//

import Foundation
import CoreData


extension ClientMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClientMO> {
        return NSFetchRequest<ClientMO>(entityName: "ClientMO")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float

}

extension ClientMO : Identifiable {

}

extension ClientMO {
    static func fromClient(_ client: Client) -> ClientMO {
        let clientMO = ClientMO(context: CoreDataManager.shared.persistentContainer.viewContext)
        clientMO.id = Int32(client.id)
        clientMO.name = client.name
        clientMO.latitude = client.latitude
        clientMO.longitude = client.longitude
        return clientMO
    }
    
    func setProperties(client: Client) {
        id = Int32(client.id)
        name = client.name
        latitude = client.latitude
        longitude = client.longitude
    }
}

extension Client {
    init(from clientMO: ClientMO) {
        self.id = Int(clientMO.id)
        self.name = clientMO.name
        self.latitude = clientMO.latitude
        self.longitude = clientMO.longitude
    }
}

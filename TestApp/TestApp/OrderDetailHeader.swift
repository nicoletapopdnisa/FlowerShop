//
//  OrderDetailHeader.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 29.01.2023.
//

import SwiftUI
import CoreLocation

struct OrderDetailHeader: View {
    var client: Client
    var currentLocation: CLLocation
    
    var body: some View {
        VStack(alignment: .leading, spacing: CGFloat(Constants.Layout.padding)) {
            Text("\(Constants.Message.distanceFrom) \(client.name)")
            Text("\(CLLocation(latitude: Double(client.latitude), longitude: Double(client.longitude)).distance(from: currentLocation)/1000) km")
                .font(.subheadline)
        }.font(.title2)
    }
}

struct OrderDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailHeader(client: Client(id: 200, name: "Maria", latitude: 46.462, longitude: 23.784734), currentLocation: CLLocation(latitude: 46.5678, longitude: 23.6784)).previewLayout(.sizeThatFits)
    }
}

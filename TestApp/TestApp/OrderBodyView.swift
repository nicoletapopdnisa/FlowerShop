//
//  OrderBodyView.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 29.01.2023.
//

import SwiftUI

struct OrderBodyView: View {
    @State var order: Order
    var completion: (String) -> Void
    
    init(order: Order, completion: @escaping (String) -> Void) {
        self.order = order
        self.completion = completion
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
          HStack {
            Text("Description:")
              Text("\(order.desc)")
              .foregroundColor(.gray)
          }
          
          HStack {
            Text("Price:")
              Text("\(order.price)")
              .foregroundColor(.gray)
          }
          
          HStack {
            Text("Image:")
            ImageWithURLView(urlString: "\(order.imageUrl)")
                    .frame(width: 100, height: 100)
          }
            Picker("Status:", selection: $order.status) {
                ForEach(OrderStatusType.allCases, id: \.id) { value in
                    Text(value.uppercaseLabel)
                        .tag(value)
                }.pickerStyle(.menu)
            }.onChange(of: order.status) { newValue in
                completion(newValue.rawValue)
            }
            
        }
    }
}

struct OrderBodyView_Previews: PreviewProvider {
    static var previews: some View {
        OrderBodyView(order: Order(id: 1, desc: "un order minuscul", price: 5000, customerId: 200, imageUrl: "https://images.pexels.com/photos/736230/pexels-photo-736230.jpeg", status: .new), completion: { newValue in print("fine \(newValue)")}).previewLayout(.sizeThatFits)
    }
}

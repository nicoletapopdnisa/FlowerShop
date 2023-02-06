//
//  OrderDetailView.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 29.01.2023.
//

import SwiftUI

//struct OrderDetailView: View {
//    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(fetchRequest: OrderMO.fetchRequest()) var order: FetchedResults<OrderMO>
//    @FetchRequest(fetchRequest: ClientMO.fetchRequest()) var client: FetchedResults<ClientMO>
struct OrderDetailView: View {
    @ObservedObject var viewModel: OrderDetailViewModel
    var delegate: OrderDetailViewControllerDelegate?

    init(viewModel: OrderDetailViewModel) {
      self.viewModel = viewModel
    }
    var body: some View {
        List {
            header
                .frame(minWidth: UIScreen.main.bounds.size.width, maxWidth: .infinity)
            Spacer()
                .frame(height: CGFloat(Constants.Layout.spacerHeight))
            orderBody

        }.padding([.top], CGFloat(Constants.Layout.padding))
        .navigationBarTitle(viewModel.title)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            delegate?.goBack()
        }) {
            Image(systemName:
                    Constants.View.arrowBack)
                .foregroundColor(.red)
        })
    }
}

private extension OrderDetailView {
    @ViewBuilder
    var header: some View {
        ZStack {
            Color.pink
                .ignoresSafeArea()
            if let clientId = viewModel.client?.id, let clientName = viewModel.client?.name, let latitude = viewModel.currentLocation?.coordinate.latitude, let longitude = viewModel.currentLocation?.coordinate.longitude, let currentLocation = viewModel.currentLocation {
                OrderDetailHeader(client: Client(id: clientId, name: clientName, latitude: Float(latitude), longitude: Float(longitude)), currentLocation: currentLocation)
            } else {
                noDataView
            }
        }
    }
    
    var orderBody: some View {
        OrderBodyView(order: viewModel.order) { [weak viewModel] newStatus in
            viewModel?.changeStatus(newValue: newStatus)
        }
    }
    
    var noDataView: some View {
        Group {
            if viewModel.client == nil && viewModel.currentLocation == nil {
                Text(Constants.Message.noDataClientLocation)
            } else if viewModel.client == nil {
                Text(Constants.Message.noDataClient)
            } else if viewModel.currentLocation == nil {
                Text(Constants.Message.noDataLocation)
            }
        }
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(viewModel: OrderDetailViewModel(order: Order(id: 1, desc: "un order minuscul", price: 5000, customerId: 200, imageUrl: "https://images.pexels.com/photos/736230/pexels-photo-736230.jpeg", status: .new)))
    }
}

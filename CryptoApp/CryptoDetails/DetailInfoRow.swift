import SwiftUI

struct DetailInfoRow: View {
    let category: String
    let priceValue: Double
    var body: some View {
        HStack {
         Text(category)
                .font(.title)
                .foregroundStyle(.gray)
            PriceWithCurrencyView(price: priceValue)
                   .font(.title)
                   .foregroundStyle(Color.white)
        }
    }
}

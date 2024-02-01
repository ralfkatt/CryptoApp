import SwiftUI

struct CryptoListHeader: View {
    var body: some View {
        HStack(spacing: 10) {
            Text("Base asset")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Symbol").fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
            Text("Ask Price")
                .fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundStyle(.white)
        .padding(.leading)
        .padding(.trailing, 60)
    }
}

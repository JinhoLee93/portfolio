//
//  BeatitudoMediaStatusView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/17/24.
//

import SwiftUI

struct BeatitudoMediaStatusView: View {
    @Binding var showStatusPage: Bool
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Color.adaptiveBackground
            
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showStatusPage = false
                            }
                        }
                }
                .frame(height: 40)
                
                VStack(alignment: .leading) {
                    Text("소중한 이진호님, ")
                    Text("\(Utils.getAndClassifyCurrentHour())")
                        .frame(alignment: .trailing)
                }
                .font(.system(size: 20))
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(
                        action: { /* Login or Logout */ },
                        label: {
                            HStack {
                                Image(systemName: "door.left.hand.open")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text("로그인하기")
                                    .font(.system(size: 20))
                            }
                            .foregroundStyle(.black)
                        }
                    )
                }
            }
            .frame(width: 250)
            .padding(.trailing, 20)
        }
    }
}

#Preview {
    BeatitudoMediaView()
}

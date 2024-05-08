//
//  ReportSheetView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/7/24.
//

import SwiftUI

struct ReportSheetView: View {
    
    @Binding var presentingReportSheet: Bool
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(presentingReportSheet ? 0.5 : 0)
                .ignoresSafeArea()
                .onTapGesture { presentingReportSheet = false }
            
            VStack {
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .ignoresSafeArea()
                        .foregroundStyle(Color(uiColor: UIColor.darkGray))
                    
                    VStack(alignment: .trailing) {
                        HStack {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(Color(uiColor: UIColor.lightGray))
                                .frame(width: 15, height: 15)
                                .foregroundStyle(Color.black)
                            
                            Spacer()
                            
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color(uiColor: UIColor.lightGray))
                                .onTapGesture { presentingReportSheet = false }
                        }
                        .padding(EdgeInsets(top: 15, leading: 25, bottom: 0, trailing: 15))
                        
                        Spacer()
                        
                        List {
                            ZStack(alignment: .leading) {
                                Color(uiColor: UIColor.darkGray)
                                
                                HStack(spacing: 10) {
                                    Image(systemName: "light.beacon.max")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(Color.red)
                                    
                                    Text("제보하기")
                                        .font(.system(size: 15))
                                        .foregroundStyle(Color.red)
                                }
                            }
                            .onTapGesture { presentingReportSheet = false }
                            .listRowBackground(Color(uiColor: UIColor.darkGray))
                            .listRowSeparator(.hidden)
                        }
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(Color(uiColor: UIColor.darkGray))
                        .scrollDisabled(true)
                        .ignoresSafeArea()
                        .listStyle(.inset)
                    }
                }
                .frame(height: 100)
                .offset(y: presentingReportSheet ? 0 : 150)
                .transition(.move(edge: .bottom))
            }
        }
        .animation(.spring(duration: 0.3, bounce: 0.2), value: presentingReportSheet)
    }
}

#Preview {
    BeatitudoMediaView()
}

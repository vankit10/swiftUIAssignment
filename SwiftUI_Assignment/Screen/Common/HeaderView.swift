//
//  HeaderView.swift
//  SwiftUI_Assignment
//
//  Created by Ankit on 02/10/25.
//
import SwiftUI

struct HeaderView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .bold()
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .background(Color.white)
            .foregroundColor(.black)
    }
}

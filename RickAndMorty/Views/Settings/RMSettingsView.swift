//
//  RMSettingsView.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 24/05/2023.
//

import SwiftUI

struct RMSettingsView: View {
    let viewModel: RMSettingsViewViewModel
    
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: viewModel.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color(uiColor: viewModel.iconContainerColor).cornerRadius(6))
            
                Text(viewModel.title)
                Spacer()
            }
            .padding(.vertical, 4)
            .background(Color.clear)
            .onTapGesture {
                viewModel.onTapHanler(viewModel.type)
            }
        }
        
    }
}

struct RESettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(viewModel: .init(
            cellViewModels: RMSettingsOption.allCases.compactMap({
                return RMSettingsCellViewModel(type: $0) { opiton in
                    
                }
        })))
    }
}

//
//  CarouselItem.swift
//  CarouselListUikit
//
//  Created by Nikita Patidar on 23/04/25.
//
import Foundation

struct CarouselItem: Identifiable {
    let id = UUID()
    let title: String
    let items: [ListItem]
}
struct ListItem: Identifiable {
    let id = UUID()
    let title: String?
    let description: String?
    let imageName: String?
}

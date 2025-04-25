//
//  CarouselViewModel.swift
//  CarouselListUikit
//
//  Created by Nikita Patidar on 23/04/25.
//

class CarouselViewModel {
    // MARK: - Variables
    var carouselItems: [CarouselItem] = []
    var selectedIndex: Int = 0
    var currentItem: CarouselItem? = nil
    var searchText: String = "" {
        didSet {
            updateFilteredItems()
        }
    }
    var filteredItems: [ListItem] = []
    var showStats = false
    
    // MARK: - Initializer
    init() {
        setup()
    }
    
    // MARK: - Setup
    func setup() {
        carouselItems = [
            CarouselItem(title: "image1", items: [
                ListItem(title: "Apple", description: "A sweet red fruit", imageName: "image1"),
                ListItem(title: "Banana", description: "A yellow tropical fruit", imageName: "image2"),
                ListItem(title: "Orange", description: "Citrus fruit rich in vitamin C", imageName: "image1"),
                ListItem(title: "Blueberry", description: "A small blue fruit", imageName: "image3"),
                ListItem(title: "Apple", description: "A sweet red fruit", imageName: "image1"),
                ListItem(title: "Banana", description: "A yellow tropical fruit", imageName: "image3"),
                ListItem(title: "Orange", description: "Citrus fruit rich in vitamin C", imageName: "image3"),
                ListItem(title: "Blueberry", description: "A small blue fruit", imageName: "image1"),
                ListItem(title: "Apple", description: "A sweet red fruit", imageName: "image2"),
                ListItem(title: "Banana", description: "A yellow tropical fruit", imageName: "image1"),
                ListItem(title: "Orange", description: "Citrus fruit rich in vitamin C", imageName: "image2"),
                ListItem(title: "Blueberry", description: "A small blue fruit", imageName: "image1")
            ]),
            CarouselItem(title: "image2", items: [
                ListItem(title: "Dog", description: "A loyal companion", imageName: "image2"),
                ListItem(title: "Cat", description: "A curious feline", imageName: "image1"),
                ListItem(title: "Elephant", description: "A large mammal", imageName: "image3"),
                ListItem(title: "Giraffe", description: "Tallest land animal", imageName: "image1")
            ]),
            CarouselItem(title: "image3", items: [
                ListItem(title: "India", description: "Country in South Asia", imageName: "image3"),
                ListItem(title: "USA", description: "United States of America", imageName: "image1"),
                ListItem(title: "Canada", description: "Country in North America", imageName: "image2"),
                ListItem(title: "Germany", description: "Country in Europe", imageName: "image2")
            ]),
            CarouselItem(title: "image1", items: [
                ListItem(title: "Apple", description: "A sweet red fruit", imageName: "image2"),
                ListItem(title: "Banana", description: "A yellow tropical fruit", imageName: "image1"),
                ListItem(title: "Orange", description: "Citrus fruit rich in vitamin C", imageName: "image2"),
                ListItem(title: "Blueberry", description: "A small blue fruit", imageName: "image2")
            ]),
            CarouselItem(title: "image2", items: [
                ListItem(title: "Dog", description: "A loyal companion", imageName: "image1"),
                ListItem(title: "Cat", description: "A curious feline", imageName: "image3"),
                ListItem(title: "Elephant", description: "A large mammal", imageName: "image1"),
                ListItem(title: "Giraffe", description: "Tallest land animal", imageName: "image3")
            ]),
            CarouselItem(title: "image3", items: [
                ListItem(title: "India", description: "Country in South Asia", imageName: "image3"),
                ListItem(title: "USA", description: "United States of America", imageName: "image1"),
                ListItem(title: "Canada", description: "Country in North America", imageName: "image1"),
                ListItem(title: "Germany", description: "Country in Europe", imageName: "image2")
            ])
        ]
        currentItem = carouselItems.first
        updateFilteredItems()
    }
    
    // MARK: - Get stats
    var stats: [String: Int] {
        let chars = filteredItems.compactMap { $0.title }
            .joined()
            .lowercased()
        var freq: [String: Int] = [:]
        for char in chars where char.isLetter {
            freq[String(char), default: 0] += 1
        }
        return freq.sorted { $0.value > $1.value }
            .prefix(3)
            .reduce(into: [:]) { $0[$1.key] = $1.value }
    }
    
    // MARK: - Change carousel items
    func moveTo(index: Int) {
        guard index >= 0 && index < carouselItems.count else { return }
        selectedIndex = index
        currentItem = carouselItems[index]
        updateFilteredItems()
    }
    
    // MARK: - Update Filtered Items
    func updateFilteredItems() {
        if let currentItem = currentItem {
            filteredItems = searchText.isEmpty ? currentItem.items : currentItem.items.filter {
                $0.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
        } else {
            filteredItems = []
        }
    }
}

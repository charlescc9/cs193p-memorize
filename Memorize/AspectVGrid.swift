import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    private var items: [Item]
    private var aspectRatio: CGFloat
    private let content: (Item) -> ItemView

    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidth(
                count: items.count,
                size: geometry.size, aspectRatio: aspectRatio)
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: gridItemSize), spacing: 0)
                ],
                spacing: 0
            ) {
                ForEach(items) { item in
                    content(item).aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }

    init(_ items: [Item], aspectRatio: CGFloat, content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }

    func gridItemWidth(count: Int, size: CGSize, aspectRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0

        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count

        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}

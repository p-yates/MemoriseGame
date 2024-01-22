//
//  AspectVGrid.swift
//  MemoriseGame
//
//  Created by Paul Y on 2024-01-21.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    
    var body: some View {
        
        GeometryReader { geometry in
            //send the parameters to the func gridItemWidthThatFits
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
                
            )
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize),spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)

                }
                
            }
        }
        
    }
    
    func gridItemWidthThatFits (
    count: Int,
    size: CGSize,
    atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        //need to calculate what will fit
        //try one column, see if it fits, if not try two, keep trying until it fits vertically
        //use a repeat while
        let count = CGFloat(count) //type conversion, or it won't take the non float version. This overrides the other version of count
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            
            let rowCount = (count / columnCount.rounded(.up))
            if rowCount * height < size.height {
                //it fits, so we're done
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
            
        } while columnCount < count
        //no point adding more columns that the unmber of items, it can't help
        
        return min(size.width / count , size.height * aspectRatio).rounded(.down)
    }
}




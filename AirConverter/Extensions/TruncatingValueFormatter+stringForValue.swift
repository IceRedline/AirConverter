//
//  Double+rounded.swift
//  AirConverter
//
//  Created by Артем Табенский on 02.06.2025.
//

import DGCharts
import Foundation

final class TruncatingValueFormatter: NSObject, ValueFormatter {
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        if value < 2 {
            return String(format: "%.4f", value)
        } else {
            return String(format: "%.2f", value)
        }
    }
}

//
//  MarshmallowWidgetBundle.swift
//  MarshmallowWidget
//
//  Created by 박준하 on 2023/04/29.
//

import WidgetKit
import SwiftUI

@main
struct MarshmallowWidgetBundle: WidgetBundle {
    var body: some Widget {
        MarshmallowWidget()
        MarshmallowWidgetLiveActivity()
    }
}

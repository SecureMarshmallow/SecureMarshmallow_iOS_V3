import WidgetKit
import SwiftUI

@main
struct MarshmallowWidgetBundle: WidgetBundle {
    var body: some Widget {
        MarshmallowWidget()
        MarshmallowWidgetLiveActivity()
    }
}

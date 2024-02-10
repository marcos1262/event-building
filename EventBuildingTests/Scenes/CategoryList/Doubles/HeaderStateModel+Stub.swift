@testable import EventBuilding

extension HeaderStateModel {

    static func stub(title: String = "Event Builder",
                     subtitle: String = "Add to your event to view our cost estimate.",
                     total: String = "$1,234-5,678") -> HeaderStateModel {
        HeaderStateModel(title: title, subtitle: subtitle, total: total)
    }
}

import dates from "./contents/dates.js";
import workspace from "./contents/workspace.js";
import { getDistroIcon } from "../../utils/system.js";
import systray from "./contents/systray.js";

const startContent = () => Widget.Box({
    class_name: "bar-contents",
    spacing: 8,
    vertical: false,
    children: [
        Widget.Icon({
            class_name: "bar-distro-icon",
            icon: getDistroIcon(),
            size: 24,
        }),
        workspace()
    ]
})

const centerContent = () => Widget.Box({
    class_name: "bar-contents-date",
    spacing: 8,
    vertical: false,
    children: [
        dates(),
    ]
})

const endContent = () => Widget.Box({
    class_name: "bar-contents",
    spacing: 8,
    hpack: "end",
    vertical: false,
    children: [
        systray(),
    ]
})

export default (monitor) => Widget.Window({
    class_name: "bar",
    name: `bar-${monitor}`,
    exclusivity: "exclusive",
    monitor: monitor,
    anchor: ["top", "left", "right"],
    margins: [4, 4, 4, 4],
    child: Widget.CenterBox({
        startWidget: startContent(),
        centerWidget: centerContent(),
        endWidget: endContent(),
    })
})
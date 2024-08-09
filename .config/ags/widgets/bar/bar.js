import { RoundedCorner } from "../misc/roundedcorner.js";
import { enableClickthrough } from "../misc/clickthrough.js";
import dates from "./contents/dates.js";
import workspace from "./contents/workspace.js";
import { getDistroIcon } from "../../utils/system.js";
import systray from "./contents/systray.js";

const startContent = () => Widget.Box({
    class_names: ["bar-contents", "bar-contents-start"],
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
    class_names: ["bar-contents", "bar-contents-end"],
    spacing: 8,
    hpack: "end",
    vertical: false,
    children: [
        systray(),
        Widget.Button({
            class_name: "bar-menu",
            cursor: "pointer",
            child: Widget.Label({
                class_name: "bar-icon",
                label: "power_settings_new"
            })
        })
    ]
})

export default (monitor) => Widget.Window({
    class_name: "bar",
    name: `bar-${monitor}`,
    exclusivity: "exclusive",
    monitor: monitor,
    anchor: ["top", "left", "right"],
    child: Widget.CenterBox({
        startWidget: startContent(),
        centerWidget: centerContent(),
        endWidget: endContent(),
    })
})

export const barCornerTopLeft = (monitor = 0) => Widget.Window({
    monitor,
    name: `bar-corner-left${monitor}`,
    layer: 'top',
    anchor: ['top', 'left'],
    exclusivity: 'normal',
    visible: true,
    child: RoundedCorner('topleft', { className: 'bar-corner', }),
    setup: enableClickthrough,
});

export const barCornerTopRight = (monitor = 0) => Widget.Window({
    monitor,
    name: `bar-corner-right-${monitor}`,
    layer: 'top',
    anchor: ['top', 'right'],
    exclusivity: 'normal',
    visible: true,
    child: RoundedCorner('topright', { className: 'bar-corner', }),
    setup: enableClickthrough,
});
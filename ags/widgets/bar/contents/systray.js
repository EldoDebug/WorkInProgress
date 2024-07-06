import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';

const SysTrayItem = item => Widget.Button({
    class_name: "systray-button",
    cursor: "pointer",
    child: Widget.Icon().bind('icon', item, 'icon'),
    tooltipMarkup: item.bind('tooltip_markup'),
    onPrimaryClick: (_, event) => item.activate(event),
    onSecondaryClick: (_, event) => item.openMenu(event),
})

export default () => Widget.Box({
    class_name: "systray",
    children: SystemTray.bind('items').as(i => i.map(SysTrayItem))
})
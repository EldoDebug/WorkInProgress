import popupwindow from "../misc/popupwindow.js";

const { query } = await Service.import("applications");
export const WINDOW_NAME = "applauncher";

const appItem = (app) => Widget.Button({
    class_name: "app-item",
    on_clicked: () => {
        App.closeWindow(WINDOW_NAME);
        app.launch();
    },
    attribute: { app },
    child: Widget.Box({
        children: [
            Widget.Icon({
                icon: app.icon_name || "",
                size: 30,
            }),
            Widget.Label({
                class_name: "app-title",
                label: app.name,
                vpack: "center",
                truncate: "end",
            })
        ]
    })
})

const container = () => {
    
    let applications = query("").map(appItem);

    const list = Widget.Box({
        class_name: "app-list",
        vertical: true,
        children: applications,
        spacing: 8,
    })

    function repopulate() {
        applications = query("").map(appItem);
        list.children = applications;
    }

    const entry = Widget.Box({
        children: [
            Widget.Entry({
                class_name: "app-entry-box",
                hexpand: true,
                on_accept: () => {
                    const results = applications.filter((item) => item.visible);
                    if (results[0]) {
                        App.toggleWindow(WINDOW_NAME);
                        results[0].attribute.app.launch();
                    }
                },
                on_change: ({ text }) => {
                    applications.forEach((item) => {
                        item.visible = item.attribute.app.match(text ?? "");
                    })
                },
                setup: (self) => {
                    self.hook(App, (_, windowName, visible) => {
                        if (windowName !== WINDOW_NAME) return;
                        if (visible) {
                            self.text = "";
                            self.grab_focus();
                        }
                    })
                }
            })
        ]
    })

    return Widget.Box({
        vertical: true,
        class_names: ["app-container"],
        children: [
            entry,
            Widget.Scrollable({
                hscroll: "never",
                css: `min-width: 350px;` + `min-height: 350px;`,
                child: list,
            }),
        ],
        setup: (self) => {
            self.hook(App, (_, windowName, visible) => {
                if (windowName !== WINDOW_NAME) return;
                if (visible) {
                    repopulate();
                }
            })
        }
    })
}

export default () => popupwindow({
    name: WINDOW_NAME,
    class_name: WINDOW_NAME,
    child: container(),
    keymode: "exclusive",
})
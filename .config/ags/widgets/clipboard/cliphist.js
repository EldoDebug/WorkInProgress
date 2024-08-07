import * as Utils from 'resource:///com/github/Aylur/ags/utils.js'
import popupwindow from '../misc/popupwindow.js';

export const WINDOW_NAME = "cliphist";

function createClipObject(id, title) {
    return {
        id: id,
        title: title.trim()
    }
}

const clips = () => {
    try {

        const clipId = Utils.exec('bash -c "cliphist list | awk \'{print $1}\'"').split("\n");
        const clipTitle = Utils.exec('bash -c "cliphist list | awk \'{$1=\\\"\\\"; print}\'"').split("\n");
        
        return clipId.map((id, index) => createClipObject(id, clipTitle[index]));
    } catch (err) {
        return [];
    }
}

const clipItem = (clip) => Widget.Button({
    class_name: "clip-item",
    on_clicked: () => {
        App.closeWindow(WINDOW_NAME);
        Utils.execAsync('bash -c "' + 'cliphist decode ' + clip.id + ' | wl-copy"');
    },
    attribute: { clip },
    child: Widget.Box({
        children: [
            Widget.Label({
                class_name: "clip-title",
                label: clip.title,
                vpack: "center",
                truncate: "end",
            })
        ]
    })
})

const container = () => {

    let clipButtons = clips().map(clipItem);

    const list = Widget.Box({
        class_name: "clip-list",
        vertical: true,
        children: clipButtons,
        spacing: 8,
    })

    function repopulate() {
        clipButtons = clips().map(clipItem);
        list.children = clipButtons;
    }

    return Widget.Box({
        vertical: true,
        class_names: ["clip-container"],
        children: [
            Widget.Scrollable({
                hscroll: "never",
                css: `min-width: 350px;` + `min-height: 350px;`,
                child: list
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
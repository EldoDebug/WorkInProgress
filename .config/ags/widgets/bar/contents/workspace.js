import { hyprland } from "../../../utils/services.js";

const button = (i) => Widget.Button({
    setup: (self) => {
        self.hook(hyprland, () => {
            const workspace = hyprland.getWorkspace(i);
            self.toggleClassName("active-workspace", Boolean(workspace?.windows));
        }, "changed");
    },
    className: hyprland.active.workspace.bind("id").transform((id) => `${id === i ? "focused-workspace" : ""}`),
    child: Widget.Box({
        className: "workspace-fill",
        hpack: "center",
        vpack: "center",
    }),
    onPrimaryClick: () => {
        hyprland.message(`dispatch workspace ${i}`);
    }
});

export default () => Widget.Box({
    className: "workspace",
    hpack: "center",
    vpack: "center",
    children: Array.from(
        { length: 10 },
        (_, i) => i + 1,
    ).map((i) => button(i)),
});

const { Gdk } = imports.gi;
import GLib from 'gi://GLib';
import App from 'resource:///com/github/Aylur/ags/app.js'
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js'

import applauncher from './widgets/applauncher/applauncher.js';
import bar from './widgets/bar/bar.js';
import cliphist from './widgets/clipboard/cliphist.js';

const range = (length, start = 1) => Array.from({ length }, (_, i) => i + start);

function forMonitors(widget) {
    const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
    return range(n, 0).map(widget).flat(1);
}

const Windows = () => [
    applauncher(),
    forMonitors(bar),
    cliphist()
]

const CLOSE_ANIM_TIME = 210;
const closeWindowDelays = {};

for (let i = 0; i < (Gdk.Display.get_default()?.get_n_monitors() || 1); i++) {
    closeWindowDelays[`osk${i}`] = CLOSE_ANIM_TIME;
}

const scss = App.configDir + "/styles/main.scss";
const css = GLib.get_user_state_dir() + "ags/style.css";

Utils.exec(`sass ${scss} ${css}`);
App.resetCss();
App.applyCss(css);

App.addIcons(`${App.configDir}/assets`)

App.config({
    css: css,
    stackTraceOnError: true,
    closeWindowDelay: closeWindowDelays,
    windows: Windows().flat(1),
});
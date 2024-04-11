App.addIcons(`${App.configDir}/assets`)

import Gdk from 'gi://Gdk';
import GLib from 'gi://GLib';
import App from 'resource:///com/github/Aylur/ags/app.js'
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js'

import options from './options.js';
import { init } from './lib/init.js';

// import Lockscreen from './modules/lock/Lockscreen.js';
// import Powermenu from './modules/powermenu/Powermenu.js';
// import OSD from './modules/osd/OSD.js';
// import Verification from './modules/powermenu/Verification.js';
import Overview from './modules/overview/Overview.js';
// import NotificationPopups from './modules/notifications/NotificationPopups.js';
// import Bar from './modules/bar/Bar.js'
// import { setupDateMenu } from './modules/datemenu/DateMenu.js';
// import { setupQuickSettings } from './modules/quicksettings/QuickSettings.js';
// import Test from './test.js';

const range = (length, start = 1) => Array.from({ length }, (_, i) => i + start);
function forMonitors(widget) {
  const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
  return range(n, 0).map(widget).flat(1);
}


print(App.configDir)
// SCSS compilation
// Utils.exec(`bash -c 'echo "" > ${App.configDir}/scss/_musicwal.scss'`); // reset music styles
// Utils.exec(`bash -c 'echo "" > ${App.configDir}/scss/_musicmaterial.scss'`); // reset music styles
async function applyStyle() {
  const COMPILED_STYLE_DIR = `${GLib.get_user_cache_dir()}/ags/user/generated`
  if (options.recompileSass) {
    Utils.exec(`mkdir -p ${COMPILED_STYLE_DIR}`);
    Utils.exec(`sassc ${App.configDir}/scss/main.scss ${COMPILED_STYLE_DIR}/style.css`);
  }
  App.resetCss();
  App.applyCss(`${COMPILED_STYLE_DIR}/style.css`);
  print('[LOG] Styles loaded')
  print(`CRITICAL: Reload Sass option is set to: ${options.recompileSass}`)
}
applyStyle().catch(print);


const Windows = () => [
  // Lockscreen(),
  // Powermenu(),
  // // Dock(),
  // Verification(),
  Overview(),
  // Test(),
  // forMonitors(NotificationPopups),
  // forMonitors(Bar),
  // forMonitors(OSD),
];

// const CLOSE_ANIM_TIME = 210; // Longer than actual anim time to make sure widgets animate fully
export default {
  onConfigParsed: () => {
    // setupQuickSettings()
    // setupDateMenu()
    init()
    if (options.monitorCSS) {
      Utils.monitorFile(
        // directory that contains the scss files
        `${App.configDir}/scss`,
        function() {
          applyStyle()
        },
      )
    }
  },
  css: `${App.configDir}/style.css`,
  stackTraceOnError: true,
  closeWindowDelay: { // For animations
    // "powermenu": options.theme.PopupCloseDuration,
    // "verification": options.theme.PopupCloseDuration,
    "overview": options.theme.PopupCloseDuration,
    // "quicksettings": options.theme.PopupCloseDuration,
    //   'sideright': CLOSE_ANIM_TIME,
    //   'sideleft': CLOSE_ANIM_TIME,
    //   'osk': CLOSE_ANIM_TIME,
  },
  windows: Windows().flat(1),
};

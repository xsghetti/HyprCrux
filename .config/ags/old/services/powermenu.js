import options from '../options.js';
// const { sleep, reboot, logout, shutdown } = options.powermenu

// export type Action = "sleep" | "reboot" | "logout" | "shutdown"

class PowerMenu extends Service {
  static {
    Service.register(this, {}, {
      "title": ["string"],
      "cmd": ["string"],
    })
  }

  #title = ""
  #cmd = ""

  get title() { return this.#title }
  get cmd() { return this.#cmd }

  action(action) {
    [this.#cmd, this.#title] = {
      sleep: [options.powermenu.sleep, "Sleep"],
      reboot: [options.powermenu.reboot, "Reboot"],
      logout: [options.powermenu.logout, "Log Out"],
      shutdown: [options.powermenu.shutdown, "Shutdown"],
      lock: [options.powermenu.lock, "Lock"],
    }[action]

    this.notify("cmd")
    this.notify("title")
    this.emit("changed")
    App.closeWindow("powermenu")
    App.openWindow("verification")
  }

  shutdown = () => {
    this.action("shutdown")
  }
}

const powermenu = new PowerMenu
globalThis["powermenu"] = powermenu
export default powermenu

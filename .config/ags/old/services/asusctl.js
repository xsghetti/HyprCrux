import { sh } from "../lib/utils.js"

class Asusctl extends Service {
  static {
    Service.register(this, {}, {
      "profile": ["string", "r"],
      "mode": ["string", "r"],
    })
  }

  available = !!Utils.exec("which asusctl")
  #profile = "Balanced"
  #mode = "Hybrid"

  async nextProfile() {
    await sh("asusctl profile -n")
    const profile = await sh("asusctl profile -p")
    const p = profile.split(" ")[3]
    this.#profile = p
    this.changed("profile")
  }

  async setProfile(prof) {
    await sh(`asusctl profile --profile-set ${prof}`)
    this.#profile = prof
    this.changed("profile")
  }

  async nextMode() {
    await sh(`supergfxctl -m ${this.#mode === "Hybrid" ? "Integrated" : "Hybrid"}`)
    this.#mode = await sh("supergfxctl -g")
    this.changed("profile")
  }

  constructor() {
    super()

    if (this.available) {
      sh("asusctl profile -p").then(p => this.#profile = p.split(" ")[3])
      sh("supergfxctl -g").then(m => this.#mode = m)
    }
  }

  get profiles() { return ["Performance", "Balanced", "Quiet"] }
  get profile() { return this.#profile }
  get mode() { return this.#mode }
}

export default new Asusctl()

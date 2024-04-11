const { GLib } = imports.gi;
class ClockService extends Service {
	static {
		Service.register ( this, {}, {
				'time': ['gobject']
			}
		)
	}

	#time = GLib.DateTime.new_now_local()

	get time() { return this.#time; }
	constructor() {
		super()
		Utils.interval(1000, () => {
			this.#time = GLib.DateTime.new_now_local()
			this.changed("time")
		})
	}
}
export default new ClockService()


// these are functionalities that I might include in ags

/* eslint-disable @typescript-eslint/no-explicit-any */
import { Variable } from "resource:///com/github/Aylur/ags/variable.js"
import { App } from "resource:///com/github/Aylur/ags/app.js"
import GObject from "gi://GObject?version=2.0"

// eslint-disable-next-line max-len
// export function watch(init, objs, callback)
// export function watch(init, obj, callback)
export function pwatch(
  init,
  objs,
  sigOrFn,
  callback,
) {
  const v = new Variable(init)
  const f = typeof sigOrFn === "function" ? sigOrFn : callback ?? (() => v.value)
  const set = () => v.value = f()

  if (Array.isArray(objs)) {
    // multiple objects
    for (const obj of objs) {
      if (Array.isArray(obj)) {
        // obj signal pair
        const [o, s = "changed"] = obj
        o.connect(s, set)
      } else {
        // obj on changed
        obj.connect("changed", set)
      }
    }
  } else {
    // watch single object
    const signal = typeof sigOrFn === "string" ? sigOrFn : "changed"
    objs.connect(signal, set)
  }

  return v.bind()
}
export function watch(init, objs, sigOrFn, callback) {
  print(objs)
  const v = new Variable(init);
  const f = typeof sigOrFn === "function" ? sigOrFn : (callback || (() => v.value));
  const set = () => { v.value = f(); };

  if (Array.isArray(objs)) {
    // multiple objects
    for (const obj of objs) {
      if (Array.isArray(obj)) {
        // obj signal pair
        const [o, s = "changed"] = obj;
        o.connect(s, set);
      } else {
        // obj on changed
        obj.connect("changed", set);
      }
    }
  } else {
    // watch single object
    const signal = typeof sigOrFn === "string" ? sigOrFn : "changed";
    objs.connect(signal, set);
  }

  return v.bind();
}

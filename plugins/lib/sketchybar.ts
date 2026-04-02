export function sketchybar(...args: string[]) {
  Bun.spawnSync(["sketchybar", ...args]);
}

#!/Users/magtastic/.bun/bin/bun
import { $ } from "bun";
import { env } from "./lib/env.ts";
import { sketchybar } from "./lib/sketchybar.ts";

const colors = {
  default: "0xffcdd6f4",
  warning: "0xfff38ba8",
};

const NAME = env("NAME");
const LEVEL = 50;

const volume = parseInt(
  (await $`osascript -e 'input volume of (get volume settings)'`.text()).trim(),
  10,
);

if (volume === 0) {
  await $`osascript -e ${`set volume input volume ${LEVEL}`}`;
  sketchybar("--set", NAME, "icon=􀊱", `icon.color=${colors.warning}`);
} else {
  await $`osascript -e 'set volume input volume 0'`;
  sketchybar("--set", NAME, "icon=􀊲", `icon.color=${colors.default}`);
}

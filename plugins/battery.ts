#!/Users/magtastic/.bun/bin/bun
import { $ } from "bun";
import { env } from "./lib/env.ts";
import { sketchybar } from "./lib/sketchybar.ts";

const colors = {
  default: "0xffcdd6f4",
  warning: "0xfff38ba8",
};

const NAME = env("NAME");

const data = await $`pmset -g batt`.text();
const percentMatch = data.match(/(\d+)%/);
const percent = percentMatch?.[1] ? parseInt(percentMatch[1], 10) : 0;
const charging = data.includes("AC Power");
const caffeinated = (await $`pgrep -x caffeinate`.quiet().nothrow()).exitCode === 0;

let icon: string;
let color = colors.default;

if (charging) {
  icon = "􀢋";
} else if (percent >= 80) {
  icon = "􀛨";
} else if (percent >= 30) {
  icon = "􀺶";
} else if (percent >= 20) {
  icon = "􀛩";
} else {
  icon = "􀛩";
  color = colors.warning;
}

if (caffeinated) {
  icon = `􀸙 ${icon}`;
}

sketchybar("-m", "--set", NAME, `label=${icon}`, `label.color=${color}`);

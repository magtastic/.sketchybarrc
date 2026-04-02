#!/Users/magtastic/.bun/bin/bun
import { $ } from "bun";
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = process.env.NAME!;
const INFO = process.env.INFO ?? "";

const settings = await $`osascript -e 'get volume settings'`.text();
const muted = settings.includes("muted:true");

const volume = parseInt(INFO) || parseInt(settings.split(":")[1]?.split(",")[0] ?? "0");
let icon: string;

if (muted) {
  icon = "􀊣";
} else if (volume >= 70) {
  icon = "􀊩";
} else if (volume >= 20) {
  icon = "􀊧";
} else {
  icon = "􀊥";
}

sketchybar("-m", "--set", NAME, `icon=${icon}`);

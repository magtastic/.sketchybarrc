#!/Users/magtastic/.bun/bin/bun
import { $ } from "bun";
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = process.env.NAME!;
const SENDER = process.env.SENDER!;
let INFO = process.env.INFO ?? "";

if (SENDER === "front_app_switched" || SENDER === "window_title_changed") {
  if (!INFO) {
    const query = await $`yabai -m query --windows --window`.quiet().nothrow().text();
    try {
      INFO = JSON.parse(query).app;
    } catch {}
  }
  sketchybar("--set", NAME, `icon=${INFO}`);
} else if (SENDER === "display_change") {
  sketchybar("--set", NAME, `associated_display=${INFO}`);
}

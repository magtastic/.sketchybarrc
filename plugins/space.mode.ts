#!/usr/bin/env bun
import { $ } from "bun";
import { APP_ICONS, DEFAULT_ICON } from "./lib/app-icons.ts";
import { env } from "./lib/env.ts";
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = env("NAME");
const SENDER = env("SENDER");
const INFO = process.env["INFO"] ?? "";

if (SENDER === "front_app_switched" || SENDER === "space_mode_changed") {
  const query = await $`yabai -m query --windows --window`.quiet().nothrow().text();
  let app = "";
  try {
    app = JSON.parse(query).app;
  } catch {}

  const icon = APP_ICONS[app] ?? DEFAULT_ICON;
  sketchybar("--set", NAME, `icon=${icon}`);
} else if (SENDER === "display_change") {
  sketchybar("--set", NAME, `associated_display=${INFO}`);
}

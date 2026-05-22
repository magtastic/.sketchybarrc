#!/usr/bin/env bun
import { $ } from "bun";
import { APP_ICONS, DEFAULT_ICON } from "./lib/app-icons.ts";
import { env } from "./lib/env.ts";
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = env("NAME");
const parts = NAME.split(".");
const spaceIndex = parseInt(parts[parts.length - 1] ?? "0", 10);

// Prefer FOCUSED from the aerospace_workspace_change event payload, otherwise query.
let focused = process.env["FOCUSED"];
if (!focused) {
  focused = (await $`aerospace list-workspaces --focused`.quiet().nothrow().text()).trim();
}
const SELECTED = focused === String(spaceIndex);

const SPACE_ICONS = ["􀀺", "􀀼", "􀀾", "􀁀", "􀁂", "􀁄", "􀁆", "􀁈", "􀁊"];
const SELECTED_ICONS = ["􀀻", "􀀽", "􀀿", "􀁁", "􀁃", "􀁅", "􀁇", "􀁉", "􀁋"];

// Apps in this workspace
const query = await $`aerospace list-windows --workspace ${spaceIndex} --json`
  .quiet()
  .nothrow()
  .text();

let appIcons = "";
let windowCount = 0;
try {
  const windows = JSON.parse(query) as { "app-name": string }[];
  windowCount = windows.length;
  const seen = new Set<string>();
  const icons: string[] = [];
  for (const win of windows) {
    const icon = APP_ICONS[win["app-name"]] ?? DEFAULT_ICON;
    if (!seen.has(icon)) {
      seen.add(icon);
      icons.push(icon);
    }
  }
  appIcons = icons.join(" ");
} catch {}

if (appIcons.length === 0) {
  appIcons = "—";
}

// Re-evaluate this workspace's monitor on every event, so unplugging an
// external causes its workspaces to migrate to the laptop bar (and vice
// versa) without a sketchybar restart.
const monMap = (
  await $`aerospace list-workspaces --all --format '%{workspace}=%{monitor-id}'`
    .quiet()
    .nothrow()
    .text()
).trim();
const monLine = monMap.split("\n").find((l) => l.startsWith(`${spaceIndex}=`));
const monitorId = monLine ? monLine.split("=")[1] : "1";

sketchybar(
  "-m",
  "--set",
  NAME,
  "drawing=on",
  `display=${monitorId}`,
  `icon=${SELECTED ? SELECTED_ICONS[spaceIndex - 1] : SPACE_ICONS[spaceIndex - 1]}`,
  `icon.highlight=${SELECTED}`,
  `label=${appIcons}`,
  `label.highlight=${SELECTED}`,
  `background.drawing=${SELECTED}`,
);
